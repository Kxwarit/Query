SELECT COUNT(distinct i.hn) as hn, COUNT(distinct i.an) as an
FROM ipt i
LEFT OUTER JOIN doctor d ON d.code = i.dch_doctor
WHERE i.dchdate BETWEEN '2024-10-01' AND '2025-01-31' 
AND d.spclty = '08'

----------------------------

SELECT 
 'all' as spclty,
(SUM(i.adjrw)/count(i.an)) AS cmi
FROM ipt i
LEFT OUTER JOIN doctor d ON d.code = i.dch_doctor
WHERE i.dchdate BETWEEN '2024-10-01' AND '2025-01-31' 
--GROUP BY  d.spclty

UNION ALL
SELECT 
d.spclty, 
(SUM(i.adjrw)/count(i.an)) AS cmi
FROM ipt i
LEFT OUTER JOIN doctor d ON d.code = i.dch_doctor
WHERE i.dchdate BETWEEN '2025-01-31'  AND '2025-01-31'   AND d.spclty IS NOT NULL
GROUP BY  d.spclty

--------------------------------

SELECT 
 'all' as spclty,
(SUM(i.adjrw)) AS adjrw
FROM ipt i
LEFT OUTER JOIN doctor d ON d.code = i.dch_doctor
WHERE i.dchdate BETWEEN '2024-10-01'  AND '2025-01-31' 
--GROUP BY  d.spclty

UNION ALL
SELECT 
d.spclty, 
(SUM(i.adjrw)) AS adjrw
FROM ipt i
LEFT OUTER JOIN doctor d ON d.code = i.dch_doctor
WHERE i.dchdate BETWEEN '2024-10-01'  AND '2025-01-31'   AND d.spclty IS NOT NULL
GROUP BY  d.spclty


-------------------------
SELECT count(distinct ol.hn) as hn, count(distinct ol.an) as an, count(distinct ol.vn) as vn
FROM operation_list ol 
LEFT OUTER JOIN operation_detail od ON od.operation_id = ol.operation_id  
LEFT OUTER JOIN operation_set os ON os.operation_set_id = ol.operation_set_id 
LEFT OUTER JOIN spclty ON spclty.spclty = od.spclty 
LEFT OUTER JOIN operation_team ot ON ot.operation_detail_id = od.operation_detail_id  
    AND ot.position_id = 1 
LEFT OUTER JOIN doctor d ON d.code = ot.doctor
LEFT OUTER JOIN doctor d_set ON d_set.code = os.operation_set_doctor_code  
    AND d_set.position_id = 1
WHERE ol.operation_date BETWEEN '2024-10-01' AND '2025-02-28' 
AND ol.patient_department = 'IPD'
AND COALESCE(d.spclty, d_set.spclty) = '08'