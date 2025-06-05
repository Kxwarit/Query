SELECT o.vstdate, i.regdate, i.dchdate, i.an, p.cid, p.hn, concat(p.pname,' ',p.fname,' ',p.lname) as patient_name, pt.name, STRING_AGG(li.lab_items_name,', ') as Lab,
SUM(40.00) AS cost, 
CASE 
  WHEN i.an IS NOT NULL THEN an_stat.income 
  WHEN o.vn IS NOT NULL AND i.an IS NULL THEN vn_stat.income 
ELSE 0 END AS costs 
FROM ovst o 
LEFT OUTER JOIN ipt i ON i.an = o.an 
LEFT OUTER JOIN patient p ON p.hn = o.hn 
LEFT OUTER JOIN pttype pt ON pt.pttype = o.pttype 
LEFT OUTER JOIN vn_stat ON vn_stat.vn = o.vn 
LEFT OUTER JOIN an_stat ON an_stat.an = i.an 
INNER JOIN lab_head lh ON lh.vn = o.vn
INNER JOIN lab_order lo ON lo.lab_order_number = lh.lab_order_number
INNER JOIN lab_items li ON li.lab_items_code = lo.lab_items_code
WHERE (CASE WHEN i.an IS NULL THEN o.vstdate BETWEEN '2025-01-01' AND '2025-01-10' ELSE i.dchdate BETWEEN '2025-01-01' AND '2025-01-10' END)  
AND lo.lab_items_code IN ('48','3001')
AND ((vn_stat.age_y BETWEEN '35' AND '59') OR (an_stat.age_y BETWEEN '35' AND '59')) 
and i.an IS NULL 
GROUP BY o.vstdate, i.regdate, i.dchdate, i.an, p.cid, p.hn, p.pname, p.fname, p.lname, pt.name, o.vn, an_stat.income, vn_stat.income 
ORDER BY o.vstdate