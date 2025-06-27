SELECT o.vstdate, p.cid, p.hn, concat(p.pname,' ',p.fname,' ',p.lname) as patient_name, pt.name, coalesce(vn_stat.age_y, an_stat.age_y) as age_y,
STRING_AGG(CASE WHEN op.icode = '3000865' THEN (SELECT billcode FROM nondrugitems WHERE icode = op.icode) ELSE NULL END, ', ') AS billcode,
STRING_AGG(DISTINCT CASE 
    WHEN vn_stat.pdx = 'Z124' THEN vn_stat.pdx 
    WHEN vn_stat.dx0 = 'Z124' THEN vn_stat.dx0 
    WHEN vn_stat.dx1 = 'Z124' THEN vn_stat.dx1 
    WHEN vn_stat.dx2 = 'Z124' THEN vn_stat.dx2 
    WHEN vn_stat.dx3 = 'Z124' THEN vn_stat.dx3 
    WHEN vn_stat.dx4 = 'Z124' THEN vn_stat.dx4 
    WHEN vn_stat.dx5 = 'Z124' THEN vn_stat.dx5 
    WHEN an_stat.pdx = 'Z124' THEN an_stat.pdx 
    WHEN an_stat.dx0 = 'Z124' THEN an_stat.dx0 
    WHEN an_stat.dx1 = 'Z124' THEN an_stat.dx1 
    WHEN an_stat.dx2 = 'Z124' THEN an_stat.dx2 
    WHEN an_stat.dx3 = 'Z124' THEN an_stat.dx3 
    WHEN an_stat.dx4 = 'Z124' THEN an_stat.dx4 
    WHEN an_stat.dx5 = 'Z124' THEN an_stat.dx5 
    ELSE COALESCE(an_stat.pdx, vn_stat.pdx) END, ', ') AS pdx, 
CASE 
    WHEN i.an IS NOT NULL THEN an_stat.income 
    WHEN o.vn IS NOT NULL AND i.an IS NULL THEN vn_stat.income 
ELSE 0 END AS costs, 
SUM(DISTINCT CASE 
    WHEN op.icode = '3000865' THEN 250 
    WHEN vn_stat.pdx = 'Z124' AND NOT EXISTS(SELECT 1 FROM opitemrece op2 WHERE op2.vn = o.vn AND op2.icode = '3000865' ) THEN 250 
ELSE 0 END ) AS cost
FROM ovst o                                                                                     
LEFT OUTER JOIN ipt i ON o.vn = i.vn OR o.an = i.an
LEFT OUTER JOIN patient p ON p.hn = o.hn 
LEFT OUTER JOIN pttype pt ON pt.pttype = o.pttype 
LEFT OUTER JOIN (SELECT DISTINCT vn, icode FROM opitemrece) op ON op.vn = o.vn  
LEFT OUTER JOIN vn_stat ON vn_stat.vn = o.vn
LEFT OUTER JOIN an_stat ON an_stat.an = i.an
WHERE (CASE WHEN i.an IS NULL THEN o.vstdate BETWEEN '2025-01-01' AND '2025-01-15' ELSE i.dchdate BETWEEN '2025-01-01' AND '2025-01-15' END) 
AND (
  vn_stat.pdx = 'Z124' OR vn_stat.dx0 = 'Z124' OR vn_stat.dx1 = 'Z124' OR vn_stat.dx2 = 'Z124' 
  OR vn_stat.dx3 = 'Z124' OR vn_stat.dx4 = 'Z124' OR vn_stat.dx5 = 'Z124' 
  OR an_stat.pdx = 'Z124' OR an_stat.dx0 = 'Z124' OR an_stat.dx1 = 'Z124' OR an_stat.dx2 = 'Z124' 
  OR an_stat.dx3 = 'Z124' OR an_stat.dx4 = 'Z124' OR an_stat.dx5 = 'Z124' 
  OR op.icode = '3000865'
)
AND ((vn_stat.age_y BETWEEN '15' AND '59') OR (an_stat.age_y BETWEEN '15' AND '59'))
AND pt.pttype = 'F2' 
GROUP BY p.cid, p.hn, o.vstdate, p.pname, p.fname, p.lname, pt.name, o.vn, i.an, vn_stat.pdx, an_stat.pdx, vn_stat.age_y, an_stat.age_y, vn_stat.income, an_stat.income
ORDER BY o.vstdate 