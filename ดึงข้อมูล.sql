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