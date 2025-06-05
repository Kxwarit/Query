SELECT 
  o.vstdate, 
  p.cid, 
  p.hn, 
  CONCAT(p.pname,' ',p.fname,' ',p.lname) AS patient_name, 
  pt.name, 
  COALESCE(vn_stat.age_y, an_stat.age_y) AS age_y,


  STRING_AGG(DISTINCT 
    CASE 
      WHEN op.icode = '3000865' THEN (SELECT billcode FROM nondrugitems WHERE icode = op.icode LIMIT 1) 
      ELSE NULL 
    END, ', ') AS billcode,


  STRING_AGG(DISTINCT 
    CASE 
      WHEN id.icd10 = 'Z124' OR od.icd10 = 'Z124' THEN 'Z124' 
      ELSE NULL 
    END, ', ') AS pdx,


  CASE 
    WHEN i.an IS NOT NULL THEN an_stat.income 
    WHEN o.vn IS NOT NULL AND i.an IS NULL THEN vn_stat.income 
    ELSE 0 
  END AS costs,


  SUM(250.00) AS cost

FROM ovst o                                                                                     
LEFT JOIN ipt i ON o.vn = i.vn OR o.an = i.an
LEFT JOIN patient p ON p.hn = o.hn 
LEFT JOIN pttype pt ON pt.pttype = o.pttype 
LEFT JOIN (SELECT DISTINCT vn, icode FROM opitemrece) op ON op.vn = o.vn  
LEFT JOIN vn_stat ON vn_stat.vn = o.vn
LEFT JOIN an_stat ON an_stat.an = i.an
LEFT JOIN ovstdiag od ON od.vn = o.vn
LEFT JOIN iptdiag id ON id.an = i.an

WHERE 
  (
    CASE 
      WHEN i.an IS NULL THEN o.vstdate BETWEEN '2025-01-01' AND '2025-01-15' 
      ELSE i.dchdate BETWEEN '2025-01-01' AND '2025-01-15' 
    END
  ) 
  AND (
    (od.icd10 = 'Z124' OR id.icd10 = 'Z124') 
    OR op.icode = '3000865'
  )
  AND (
    (vn_stat.age_y BETWEEN 15 AND 59) 
    OR (an_stat.age_y BETWEEN 15 AND 59)
  )
  AND pt.pttype = 'F2' 

GROUP BY 
  p.cid, p.hn, o.vstdate, p.pname, p.fname, p.lname, pt.name, 
  o.vn, i.an, vn_stat.age_y, an_stat.age_y, vn_stat.income, an_stat.income

ORDER BY o.vstdate;
