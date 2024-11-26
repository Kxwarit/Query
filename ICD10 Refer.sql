WITH top_icd AS (SELECT icd.code,
    icd.name,
    Count(DISTINCT rin.vn) + Count(DISTINCT rout.vn) AS count_total,
    Count(DISTINCT rin.vn) AS count_in,
    Count(DISTINCT rout.vn) AS count_out
  FROM icd101 icd
    LEFT JOIN (SELECT rin.vn, rin.refer_date, rin.icd10 FROM referin rin LEFT JOIN ovst o ON o.vn = rin.vn
        WHERE o.an IS NULL) rin ON rin.icd10 = icd.code AND rin.refer_date BETWEEN "2024-09-01" AND "2024-09-30"
    LEFT JOIN referout rout ON rout.pdx = icd.code AND rout.refer_date BETWEEN "2024-09-01" AND "2024-09-30" AND rout.department = "OPD"
  GROUP BY icd.code, icd.name
  ORDER BY count_total DESC
  LIMIT 30
  ),others AS (
    SELECT 
    "อื่นๆ" AS code,
    "Other" AS name,
    COUNT(DISTINCT CASE WHEN rin.icd10 NOT IN (SELECT code FROM icd101) THEN rin.vn END) +
    COUNT(DISTINCT CASE WHEN rout.pdx NOT IN (SELECT code FROM icd101) THEN rout.vn END) AS count_total, 
    COUNT(DISTINCT CASE WHEN rin.icd10 NOT IN (SELECT code FROM icd101) THEN rin.vn END) AS count_in,
    COUNT(DISTINCT CASE WHEN rout.pdx NOT IN (SELECT code FROM icd101) THEN rout.vn END) AS count_out
FROM ovst o
LEFT OUTER JOIN (SELECT vn, icd10 FROM referin WHERE refer_date BETWEEN "2024-09-01" AND "2024-09-30") rin ON o.vn = rin.vn   
LEFT OUTER JOIN (SELECT vn, pdx  FROM referout WHERE refer_date BETWEEN "2024-09-01" AND "2024-09-30" AND department = "OPD") rout ON o.vn = rout.vn OR o.an = rout.vn)
SELECT * FROM top_icd
UNION ALL
SELECT * FROM others