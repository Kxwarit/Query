---กลุ่มโรค504--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

SELECT 
    rn.id, 
    CONCAT(COALESCE(rn.name1, ''), ' ', '[', LEFT(rc.code1, 3), '-', LEFT(rc.code2, 3), '] ') AS rpt_name, 
    COUNT(DISTINCT od.hn) AS cc_hn, 
    COUNT(DISTINCT od.vn) AS cc_vn 
FROM rpt_504_name rn
LEFT JOIN rpt_504_code rc ON rn.id = rc.id  
LEFT JOIN ovstdiag od ON od.icd10 >= rc.code1 AND od.icd10 <= rc.code2
LEFT OUTER JOIN doctor d ON d.code = od.doctor 
LEFT JOIN ovst o ON o.vn = od.vn
WHERE o.vstdate BETWEEN '2022-10-01' AND '2023-09-30' 
    AND od.diagtype = '1' 
    AND d.spclty = '01'
GROUP BY rn.id, rpt_name
ORDER BY cc_hn DESC
LIMIT 10

---ผู้ป่วยใน------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 
SELECT COUNT(distinct i.hn) as hn, COUNT(distinct i.an) as an
FROM ipt i
LEFT OUTER JOIN doctor d ON d.code = i.dch_doctor
WHERE i.dchdate BETWEEN '2024-10-01' AND '2025-01-31' 
AND d.spclty = '08'

---CMI------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

SELECT 
    'all' as spclty,
    (SUM(i.adjrw)/count(i.an)) AS cmi
FROM ipt i
LEFT OUTER JOIN doctor d ON d.code = i.dch_doctor
WHERE i.dchdate BETWEEN '2024-10-01' AND '2025-01-31' 

UNION ALL

SELECT 
    d.spclty, 
    (SUM(i.adjrw)/count(i.an)) AS cmi
FROM ipt i
LEFT OUTER JOIN doctor d ON d.code = i.dch_doctor
WHERE i.dchdate BETWEEN '2025-01-31'  AND '2025-01-31'   AND d.spclty IS NOT NULL
GROUP BY  d.spclty

---SUM adj Rw------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

SELECT 
 'all' as spclty,
(SUM(i.adjrw)) AS adjrw
FROM ipt i
LEFT OUTER JOIN doctor d ON d.code = i.dch_doctor
WHERE i.dchdate BETWEEN '2024-10-01'  AND '2025-01-31' 

UNION ALL

SELECT 
    d.spclty, 
    (SUM(i.adjrw)) AS adjrw
FROM ipt i
LEFT OUTER JOIN doctor d ON d.code = i.dch_doctor
WHERE i.dchdate BETWEEN '2024-10-01'  AND '2025-01-31'   AND d.spclty IS NOT NULL
GROUP BY  d.spclty

---OR ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

SELECT count(distinct ol.hn) as hn, count(distinct ol.an) as an, count(distinct ol.vn) as vn
FROM operation_list ol 
LEFT OUTER JOIN operation_detail od ON od.operation_id = ol.operation_id  
LEFT OUTER JOIN operation_set os ON os.operation_set_id = ol.operation_set_id 
LEFT OUTER JOIN spclty ON spclty.spclty = od.spclty 
LEFT OUTER JOIN operation_team ot ON ot.operation_detail_id = od.operation_detail_id  AND ot.position_id = 1 
LEFT OUTER JOIN doctor d ON d.code = ot.doctor
LEFT OUTER JOIN doctor d_set ON d_set.code = os.operation_set_doctor_code  AND d_set.position_id = 1
WHERE ol.operation_date BETWEEN '2024-10-01' AND '2025-02-28' 
AND ol.patient_department = 'IPD'
AND COALESCE(d.spclty, d_set.spclty) = '08'


---บริการทางออโธ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

WITH combined_data AS (
    SELECT o.hn, o.vn, o.an
    FROM ovst o
    LEFT OUTER JOIN ovstdiag od ON od.vn = o.vn
    LEFT OUTER JOIN doctor d ON d.code = od.doctor
    WHERE o.vstdate BETWEEN '2024-10-01' AND '2025-02-28' AND d.spclty = '08' --AND o.spclty = '08' 

    UNION ALL

    SELECT i.hn, o.vn, i.an
    FROM ovst o
    LEFT OUTER JOIN ipt i ON i.an = o.an
    LEFT OUTER JOIN ovstdiag od ON od.vn = o.vn
    LEFT OUTER JOIN doctor d ON d.code = od.doctor
    WHERE i.dchdate BETWEEN '2024-10-01' AND '2025-02-28' AND d.spclty = '08' --AND i.spclty = '08'
)
SELECT 
    COUNT(DISTINCT hn) AS distinct_hn_count,
    COUNT(DISTINCT vn) AS distinct_vn_count,
    COUNT(DISTINCT an) AS distinct_an_count
FROM combined_data;

---วันนอนผู้ป่วย OR------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

WITH totals AS (
    SELECT distinct ol.an , CASE WHEN a.admdate > 0 THEN a.admdate ELSE 1 END  AS days
    FROM operation_list ol 
    LEFT OUTER JOIN operation_detail od ON od.operation_id = ol.operation_id  
    LEFT OUTER JOIN operation_set os ON os.operation_set_id = ol.operation_set_id 
    LEFT OUTER JOIN spclty ON spclty.spclty = od.spclty 
    LEFT OUTER JOIN operation_team ot ON ot.operation_detail_id = od.operation_detail_id AND ot.position_id = 1 
    LEFT OUTER JOIN doctor d ON d.code = ot.doctor
    LEFT OUTER JOIN doctor d_set ON d_set.code = os.operation_set_doctor_code AND d_set.position_id = 1 
    LEFT OUTER JOIN an_stat a ON a.an = ol.an
    WHERE ol.operation_date BETWEEN '2024-10-01' AND '2025-02-28' 
    AND ol.patient_department = 'IPD'
    AND COALESCE(d.spclty, d_set.spclty) = '08'
)
select sum(days)
from totals

---รหัสโรค สูตินารีเวช------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

SELECT CONCAT(icd.code, ' - ',icd.name) as icd10, count(DISTINCT i.hn)  as hn, count(DISTINCT i.an)  as an
FROM ipt i
LEFT OUTER JOIN iptdiag id ON id.an = i.an
INNER JOIN icd101 icd ON icd.code = id.icd10
LEFT OUTER JOIN doctor d ON d.code = id.doctor 
WHERE i.dchdate BETWEEN '2024-10-01' AND '2025-02-28'
AND d.spclty = '03' AND id.diagtype = '1'
GROUP BY icd.code
ORDER BY an DESC
LIMIT 10

---หัตถการ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

SELECT 
    COUNT(DISTINCT q.hn),
    COUNT(DISTINCT q.an) as an
FROM (
    SELECT 
        CONCAT(d.shortname) AS doctor,
        dd.doctor_department_name,
        oi.name AS oper_name,
        od.operation_id,
        ol.hn,
        ol.vn,
        ol.an,
        ol.operation_date
    FROM operation_list ol
    LEFT JOIN operation_detail od ON od.operation_id = ol.operation_id
    LEFT JOIN operation_item oi ON oi.operation_item_id = od.operation_item_id
    LEFT JOIN operation_type ot ON ot.operation_type_id = ol.operation_type_id
    LEFT JOIN operation_anes oa ON oa.operation_id = ol.operation_id
    LEFT JOIN operation_anes_type oat ON oa.anes_type_id = oat.anes_type_id
    LEFT JOIN operation_wound ow ON ow.operation_wound_id = od.operation_wound_id
    LEFT JOIN operation_time_type ott ON ol.operation_time_type_id = ott.operation_time_type_id
    LEFT JOIN operation_team om ON om.operation_id = ol.operation_id AND om.position_id = '1'
    LEFT JOIN doctor d ON d.code = om.doctor 
    LEFT JOIN doctor_department dd ON d.doctor_department_id = dd.doctor_department_id
    WHERE ol.operation_date BETWEEN '2024-10-01' AND '2025-02-28'
        AND ol.status_id <> '9' AND oi.icd9 BETWEEN '740' AND '749'
        AND d.spclty = '03'
    GROUP BY dd.doctor_department_name, oi.name, od.operation_id, d.shortname, d.name, ol.hn,ol.operation_date, ol.vn, ol.an
) q
GROUP BY q.doctor_department_name, q.oper_name
ORDER BY q.oper_name
------------

SELECT 
        ol.operation_type_id,*
    FROM operation_list ol
    LEFT JOIN operation_detail od ON od.operation_id = ol.operation_id
    LEFT JOIN operation_item oi ON oi.operation_item_id = od.operation_item_id
    LEFT JOIN operation_type ot ON ot.operation_type_id = ol.operation_type_id
    LEFT JOIN operation_anes oa ON oa.operation_id = ol.operation_id
    LEFT JOIN operation_anes_type oat ON oa.anes_type_id = oat.anes_type_id
    LEFT JOIN operation_wound ow ON ow.operation_wound_id = od.operation_wound_id
    LEFT JOIN operation_time_type ott ON ol.operation_time_type_id = ott.operation_time_type_id
    LEFT JOIN operation_team om ON om.operation_id = ol.operation_id AND om.position_id = '1'
    LEFT JOIN doctor d ON d.code = om.doctor 
    LEFT JOIN doctor_department dd ON d.doctor_department_id = dd.doctor_department_id
    WHERE ol.operation_date BETWEEN '2025-01-01' AND '2025-03-31'


---รหัสโรค Refer--------------------------------------------------------------------------------------------
SELECT CONCAT(icd.code, ' - ',icd.name) as icd10, count(DISTINCT o.hn)  as hn, count(DISTINCT o.vn)  as vn
FROM ovst o
INNER JOIN referout ro ON ro.vn = o.vn 
INNER JOIN icd101 icd ON icd.code = ro.pdx
--LEFT OUTER JOIN doctor d ON d.code = od.doctor 
WHERE ro.refer_date BETWEEN '2024-10-01' AND '2025-02-28'
AND o.spclty = '03' OR o.spclty = '04' 
GROUP BY icd.code
ORDER BY vn DESC
LIMIT 10

---วันนอนเตียง ICU--------------------------------------------------------------------------------------------
WITH sum_date AS (
    WITH ranked_data AS (
        SELECT t.*, 
               i.regdate,
               i.hn,
               ROW_NUMBER() OVER (PARTITION BY t.an ORDER BY t.iptbedmove_id ASC) AS rn_min,
               LAG(t.movedate) OVER (PARTITION BY t.an ORDER BY t.iptbedmove_id ASC) AS prev_movedate
        FROM ipt i
        LEFT OUTER JOIN iptbedmove t ON t.an = i.an
        WHERE i.dchdate BETWEEN '2024-10-01' AND '2025-02-28' 
        AND t.an IS NOT NULL 
    )
    SELECT *,
           CASE 
               WHEN rn_min = 1 THEN (movedate - regdate) 
               ELSE (movedate - prev_movedate)
           END AS diff_days
    FROM ranked_data
    WHERE obedno LIKE 'ICU%' AND obedno <> 'ICU'
    ORDER BY an, iptbedmove_id
)
SELECT 
    'Summary' AS summary, 
    sum(CASE WHEN diff_days > 0 THEN diff_days ELSE 1 END) AS total_days,
    count(DISTINCT hn) AS total_distinct_hn,
    count(DISTINCT an) AS total_an_count
FROM sum_date;