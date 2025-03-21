SELECT od.icd10, count(o.vn) as vn
FROM ovst o
LEFT OUTER JOIN ovstdiag od ON od.vn = o.vn AND od.diagtype = '1'
LEFT OUTER JOIN icd101 ic ON ic.code = od.icd10
LEFT OUTER JOIN doctor d ON d.code = o.doctor AND d.position_id = '1'
WHERE d.code = '0542' AND o.vstdate BETWEEN '2024-12-01' AND '2024-12-31'
GROUP BY od.icd10
ORDER BY count(o.vn) DESC
LIMIT 100
--------
SELECT id.icd10, count(i.an) as an
FROM ipt i
LEFT OUTER JOIN iptdiag id ON id.an = i.an AND id.diagtype = '1'
LEFT OUTER JOIN icd101 ic ON ic.code = id.icd10
LEFT OUTER JOIN doctor d ON d.code = id.doctor
WHERE d.code = '0542' AND i.regdate BETWEEN '2023-12-01' AND '2024-12-31'
GROUP BY id.icd10
ORDER BY count(i.an) DESC
LIMIT 100
-----------
SELECT o.vstdate, d.name as doctor, count(o.vn) as patient
FROM ovst o
LEFT OUTER JOIN doctor d ON d.code = o.doctor AND d.position_id = '1'
WHERE o.vstdate BETWEEN '2024-12-01' AND '2024-12-31' AND (o.vsttime >= '07:00:00' OR o.vsttime < '16:30:00')
GROUP BY o.vstdate, d.name 
ORDER BY d.name
---------
SELECT d.name, count(DISTINCT o.vn) as patient
FROM ovst_service_time k
LEFT OUTER JOIN ovst o ON o.vn = k.vn
LEFT OUTER JOIN opduser u ON u.loginname = k.staff
INNER JOIN doctor d ON d.code = u.doctorcode AND d.position_id = '1' 
WHERE ovst_service_time_type_code= 'OPD-DOCTOR'
AND service_begin_datetime::date BETWEEN '2025-02-10' AND '2025-02-10'
AND service_begin_datetime::time >= '08:30:00' AND service_begin_datetime::time <= '16:00:00' 
GROUP BY d.name, d.code
ORDER BY d.code
LIMIT 100 