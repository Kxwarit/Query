---ข้อมูลการเข้าทำงาน จากตาราง officer_activity_log---------------------------------------------------------------------------------------
WITH ranked_logs AS (
  SELECT 
    log.officer_activity_log_id,
    d.code,
    d.name,
    log.officer_activity_log_datetime::date as dates,
    log.officer_activity_log_datetime::time as times,
    log.officer_activity_log_parent_kv,
    ROW_NUMBER() OVER (PARTITION BY log.officer_activity_log_datetime::date , d.name ORDER BY log.officer_activity_log_id ASC) AS rn_min
  FROM officer_activity_log log
  LEFT OUTER JOIN officer o ON o.officer_id = log.officer_id
  LEFT OUTER JOIN doctor d ON d.code = o.officer_doctor_code  
  WHERE log.officer_activity_log_date BETWEEN '2025-02-01' AND '2025-02-28' AND log.officer_activity_log_datetime::time >= '08:30:00' AND log.officer_activity_log_datetime::time <= '16:00:00'
  AND d.position_id = '1' AND log.officer_activity_log_parent_kv <> ''
)
SELECT 
    code,
    name,
    COUNT(DISTINCT CASE WHEN rn_min = 1 AND times BETWEEN '08:30:00' AND '09:10:00' THEN dates END) AS days_in_A,
    COUNT(DISTINCT CASE WHEN rn_min = 1 AND times BETWEEN '09:10:01' AND '10:00:00' THEN dates END) AS days_in_B,
    COUNT(DISTINCT CASE WHEN rn_min = 1 AND times BETWEEN '10:00:01' AND '16:00:00' THEN dates END) AS days_in_C
FROM ranked_logs
WHERE rn_min = 1  
GROUP BY code, name

---ข้อมูลการเข้าทำงาน OPD (OPD NCD ER) จากตาราง ovst_service_time ---------------------------------------------------------------------------------------
WITH ranked_logs AS (
    SELECT 
        service_begin_datetime::date AS dates,
        service_begin_datetime::time AS times,
        k.ovst_service_time_id,
        d.code,
        d.name,
        ROW_NUMBER() OVER (PARTITION BY service_begin_datetime::date, d.name ORDER BY k.ovst_service_time_id ASC) AS rn_min
    FROM ovst_service_time k
    LEFT JOIN opduser u ON u.loginname = k.staff
    INNER JOIN doctor d ON d.code = u.doctorcode AND d.position_id = "1" 
    WHERE ovst_service_time_type_code = "OPD-DOCTOR"
    AND service_begin_datetime::date BETWEEN "2025-01-01" AND "2025-01-31"
    AND service_begin_datetime::time BETWEEN "08:30:00" AND "16:00:00"
)
SELECT 
    code,
    name,
    COUNT(DISTINCT CASE WHEN rn_min = 1 AND times BETWEEN "08:30:00" AND "09:10:00" THEN dates END) AS days_in_A,
    COUNT(DISTINCT CASE WHEN rn_min = 1 AND times BETWEEN "09:10:01" AND "10:00:00" THEN dates END) AS days_in_B,
    COUNT(DISTINCT CASE WHEN rn_min = 1 AND times BETWEEN "10:00:01" AND "16:00:00" THEN dates END) AS days_in_C,
    ( 
        COUNT(DISTINCT CASE WHEN rn_min = 1 AND times BETWEEN "08:30:00" AND "09:10:00" THEN dates END) 
        + COUNT(DISTINCT CASE WHEN rn_min = 1 AND times BETWEEN "09:10:01" AND "10:00:00" THEN dates END) 
        + COUNT(DISTINCT CASE WHEN rn_min = 1 AND times BETWEEN "10:00:01" AND "16:00:00" THEN dates END) 
    ) AS sums 
FROM ranked_logs
WHERE rn_min = 1  
GROUP BY code, name
ORDER BY code;

---ข้อมูลการเข้าทำงาน IPD จากตาราง ipd_doctor_order---------------------------------------------------------------------------------------
WITH ranked_logs AS (
SELECT i.order_date as dates, i.order_time times, d.code, d.name, ROW_NUMBER() OVER (PARTITION BY i.order_date, d.name ORDER BY i.ipd_doctor_order_id ASC) AS rn_min 
FROM ipd_doctor_order i
INNER JOIN doctor d ON d.code = i.order_doctor_code AND d.position_id = "1"
WHERE i.order_date BETWEEN "2025-02-03" AND "2025-02-03" AND i.order_time BETWEEN "08:30:00" AND "16:00:00"  
)
SELECT code,
           name,
           COUNT(DISTINCT CASE WHEN rn_min = 1 AND times BETWEEN "08:30:00" AND "09:10:00" THEN dates END) AS days_in_A,
           COUNT(DISTINCT CASE WHEN rn_min = 1 AND times BETWEEN "09:10:01" AND "10:00:00" THEN dates END) AS days_in_B,
           COUNT(DISTINCT CASE WHEN rn_min = 1 AND times BETWEEN "10:00:01" AND "16:00:00" THEN dates END) AS days_in_C,
           ( 
               COUNT(DISTINCT CASE WHEN rn_min = 1 AND times BETWEEN "08:30:00" AND "09:10:00" THEN dates END) 
               + COUNT(DISTINCT CASE WHEN rn_min = 1 AND times BETWEEN "09:10:01" AND "10:00:00" THEN dates END) 
               + COUNT(DISTINCT CASE WHEN rn_min = 1 AND times BETWEEN "10:00:01" AND "16:00:00" THEN dates END) 
           ) AS sums 
FROM ranked_logs
where rn_min = 1
group by code, name
order by code