WITH top_icd AS (SELECT icd.code, 
         icd.name,
         Count(rout.vn) AS count_total 
       FROM icd101 icd 
       LEFT JOIN referout rout ON rout.pdx = icd.code AND rout.refer_date BETWEEN '2024-10-01' AND '2024-10-31' AND rout.department = 'OPD' 
       WHERE rout.pdx NOT LIKE 'Z%'
       GROUP BY icd.code, icd.name 
       ORDER BY count_total DESC 
 
       ), 
      
       others AS (   
       SELECT 
         'อื่นๆ' AS code,
         'Other' AS name, 
         COUNT(CASE WHEN rout.pdx NOT IN (SELECT code FROM icd101) OR rout.pdx LIKE 'Z%' THEN rout.vn END) AS count_total 
       FROM ovst o   
       LEFT OUTER JOIN (SELECT vn, pdx  FROM referout WHERE refer_date BETWEEN '2024-10-01' AND '2024-10-31' AND department = 'OPD') rout ON o.vn = rout.vn OR o.an = rout.vn) 
      
       SELECT * FROM top_icd 
       UNION ALL 
       SELECT * FROM others


WITH top_icd AS (
       SELECT icd.code, 
         icd.name, 
         COUNT(rin.vn) AS count_total 
       FROM icd101 icd 
       LEFT JOIN (SELECT rin.vn, rin.refer_date, rin.icd10 FROM referin rin LEFT JOIN ovst o ON o.vn = rin.vn WHERE o.an IS NULL) rin ON rin.icd10 = icd.code AND rin.refer_date BETWEEN '2024-10-01' AND '2024-10-31' 
       GROUP BY icd.code, icd.name 
       ORDER BY count_total DESC 
       LIMIT 30), 

       others AS ( 
       SELECT 
         'อื่นๆ' AS code, 
         'Other' AS name, 
         COUNT(CASE WHEN rin.icd10 NOT IN (SELECT code FROM icd101) THEN rin.vn END) AS count_total 
       FROM ovst o 
       LEFT JOIN (SELECT vn, icd10 FROM referin WHERE refer_date BETWEEN '2024-10-01' AND '2024-10-31') rin ON o.vn = rin.vn AND o.an IS NULL) 

       SELECT * FROM top_icd 
       UNION ALL 
       SELECT * FROM others
-----------------------
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

----
select * from referin rin
LEFT JOIN ovst o ON o.vn = rin.vn 
WHERE refer_date BETWEEN '2024-10-01' AND '2024-10-31' AND o.an IS NULL  
ORDER BY refer_date DESC


