WITH top_icd AS (
    SELECT icd.code, 
           icd.name,
           COUNT(rout.vn) AS count_total 
    FROM icd101 icd 
    LEFT JOIN referout rout ON rout.pdx = icd.code 
       AND rout.refer_date BETWEEN '2024-10-01' AND '2024-10-31' 
       AND rout.department = 'OPD' 
    WHERE rout.pdx NOT LIKE 'Z%' 
    GROUP BY icd.code, icd.name 
    ORDER BY count_total DESC 
    LIMIT 30
), 

others AS (
    SELECT 
        'อื่นๆ' AS code,
        'Other' AS name, 
        COUNT(rout.vn) AS count_total 
    FROM referout rout
    WHERE rout.refer_date BETWEEN '2024-10-01' AND '2024-10-31' 
      AND rout.department = 'OPD' 
      AND rout.pdx NOT IN (SELECT code FROM top_icd)
)
SELECT * FROM top_icd 
UNION ALL 
SELECT * FROM others
