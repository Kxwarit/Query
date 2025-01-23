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