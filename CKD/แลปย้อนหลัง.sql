WITH order_dates_results AS ( 
  SELECT 
    patient.cid,
    patient.hn,
    concat(patient.pname, ' ', patient.fname, ' ', patient.lname) as patient_name, 
    ARRAY_AGG(lab_head.order_date) AS order_dates,
    ARRAY_AGG(lab_order.lab_order_result) AS order_results,
    MAX(lab_head.order_date) AS max_order_date
  FROM patient
  LEFT JOIN ovst ON ovst.hn = patient.hn
  LEFT JOIN ipt ON ipt.an = ovst.an
  LEFT JOIN lab_head ON lab_head.vn = ovst.vn OR lab_head.vn = ovst.an
  INNER JOIN lab_order ON lab_order.lab_order_number = lab_head.lab_order_number
  INNER JOIN lab_items ON lab_items.lab_items_code = lab_order.lab_items_code
  WHERE lab_items.lab_items_code = '48' 
    AND lab_order.lab_order_result <> '' 
    AND lab_order.lab_order_result ~ '^[0-9]+(\.[0-9]+)?$'
  GROUP BY patient.cid, patient.hn, patient.pname, patient.fname, patient.lname
),
ago_order AS (
  SELECT 
    od.cid,
    od.hn,
    od.patient_name, 
    od.order_dates,
    od.order_results,
    od.max_order_date,

    -- ย้อนหลัง 90 วัน
    (SELECT order_date 
     FROM unnest(od.order_dates) AS order_date 
     WHERE order_date <= (od.max_order_date - INTERVAL '90 days')  AND order_date > od.max_order_date - INTERVAL '180 days'
     ORDER BY order_date DESC LIMIT 1) AS ago_90_date,

    -- ย้อนหลัง 180 วัน
    (SELECT order_date 
     FROM unnest(od.order_dates) AS order_date 
     WHERE order_date <= (od.max_order_date - INTERVAL '180 days') AND order_date > od.max_order_date - INTERVAL '365 days'
     ORDER BY order_date DESC LIMIT 1) AS ago_180_date,

    -- ย้อนหลัง 1 ปี
    (SELECT order_date 
     FROM unnest(od.order_dates) AS order_date 
     WHERE order_date <= (od.max_order_date - INTERVAL '365 days') 
     ORDER BY order_date DESC LIMIT 1) AS ago_365_date,

    -- ผลล่าสุด
    (SELECT od.order_results[idx] 
     FROM generate_series(1, array_length(od.order_dates, 1)) AS idx 
     WHERE od.order_dates[idx] = od.max_order_date 
     LIMIT 1) AS max_order_result

  FROM order_dates_results od
)
SELECT 
  ao.cid,
  ao.hn,
  ao.patient_name, 
  ao.order_dates,
  ao.order_results,
  ao.max_order_date,

  -- วันที่ย้อนหลัง
  ao.ago_90_date,
  ao.ago_180_date,
  ao.ago_365_date,

  -- ผลย้อนหลัง 90 วัน
  (SELECT ao.order_results[idx] 
   FROM generate_series(1, array_length(ao.order_dates, 1)) AS idx 
   WHERE ao.order_dates[idx] = ao.ago_90_date LIMIT 1) AS result_90,

  -- ผลย้อนหลัง 180 วัน
  (SELECT ao.order_results[idx] 
   FROM generate_series(1, array_length(ao.order_dates, 1)) AS idx 
   WHERE ao.order_dates[idx] = ao.ago_180_date LIMIT 1) AS result_180,

  -- ผลย้อนหลัง 365 วัน
  (SELECT ao.order_results[idx] 
   FROM generate_series(1, array_length(ao.order_dates, 1)) AS idx 
   WHERE ao.order_dates[idx] = ao.ago_365_date LIMIT 1) AS result_365,

  -- ผลล่าสุด
  ao.max_order_result

FROM ago_order ao
ORDER BY ao.ago_365_date, ao.ago_180_date, ao.ago_90_date, ao.max_order_date;
