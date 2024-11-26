SELECT 
    th.chwpart, th.amppart, th.name,  COALESCE(COUNT(o.vn), 0) AS visit_count, COALESCE(SUM(vn_stat.income), 0) AS costs
FROM ovst o
LEFT OUTER JOIN hospcode h 
    ON h.hospcode = o.hospmain
LEFT OUTER JOIN thaiaddress th 
    ON h.chwpart = th.chwpart 
    AND h.amppart = th.amppart
    AND th.tmbpart = '00'
LEFT OUTER JOIN vn_stat ON vn_stat.vn = o.vn
WHERE o.vstdate BETWEEN '2023-10-01' AND '2024-09-30' 
  AND o.pttype IN ('T1', 'T2') 
  AND th.chwpart = '84'
  AND th.amppart <> '02'
  AND o.an IS NULL
  GROUP BY th.chwpart, th.amppart, th.name

