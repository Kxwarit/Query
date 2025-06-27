SELECT o.vstdate, i.regdate, i.dchdate, p.cid, p.hn, op.an, op.vn, concat(p.pname,' ',p.fname,' ',p.lname) as patient_name, pt.name,
SUM(CASE 
WHEN op.an <> '' THEN 50 
WHEN op.vn <> '' AND op.an IS NULL  THEN 50 
ELSE 0 END ) AS cost, 
CASE 
WHEN op.an IS NOT NULL THEN an_stat.income 
WHEN op.vn IS NOT NULL AND op.an IS NULL THEN vn_stat.income 
ELSE 0 END AS costs 
FROM ovst o
LEFT OUTER JOIN ipt i ON o.vn = i.vn OR o.an = i.an
LEFT OUTER JOIN patient p ON p.hn = o.hn 
LEFT OUTER JOIN pttype pt ON pt.pttype = o.pttype 
LEFT OUTER JOIN (SELECT DISTINCT vn, an, icode FROM opitemrece) op ON (op.an = i.an OR op.vn = o.vn) 
LEFT OUTER JOIN drugitems d ON d.icode = op.icode
LEFT OUTER JOIN vn_stat ON vn_stat.vn = o.vn 
LEFT OUTER JOIN an_stat ON an_stat.an = i.an 
WHERE (CASE WHEN i.an IS NULL THEN o.vstdate BETWEEN '+ds1+' AND '+ds2+' ELSE i.dchdate BETWEEN '+ds1+' AND '+ds2+' END) 
AND p.nationality = '99' 
AND p.birthday < '1992-01-01' 
AND op.icode = '3000038' 
GROUP BY p.cid, p.hn, o.vstdate, i.regdate, i.dchdate, p.pname, p.fname, p.lname, pt.name, op.an, op.vn, an_stat.income, vn_stat.income
ORDER BY o.vstdate 
----------
SELECT 
  o.vstdate,
  i.regdate,
  i.dchdate,
  p.cid,
  p.hn,
  op.an,
  op.vn,
  CONCAT(p.pname,' ', p.fname,' ', p.lname) AS patient_name,
  pt.name,
  SUM(
    CASE 
      WHEN op.an IS NOT NULL        THEN 50 
      WHEN op.vn IS NOT NULL        THEN 50 
      ELSE 0 
    END
  ) AS cost,

  CASE 
    WHEN op.an IS NOT NULL        THEN an_stat.income 
    WHEN op.vn IS NOT NULL        THEN vn_stat.income 
    ELSE 0 
  END AS costs

FROM ovst o


LEFT JOIN ipt i 
  ON  (o.vn = i.vn AND i.dchdate BETWEEN '2025-01-01' AND '2025-01-31')
   OR (o.an = i.an AND i.dchdate BETWEEN '2025-01-01' AND '2025-01-31')


INNER JOIN patient p ON p.hn = o.hn 
  AND p.nationality = '99' 
  AND p.birthday < '1992-01-01'

INNER JOIN pttype pt ON pt.pttype = o.pttype


INNER JOIN (
  SELECT vn, an 
  FROM opitemrece 
  WHERE icode = '3000038'
) op 
  ON op.vn = o.vn OR op.an = i.an


LEFT JOIN vn_stat ON vn_stat.vn = o.vn 
LEFT JOIN an_stat ON an_stat.an = i.an

WHERE 

  (i.an IS NULL   AND o.vstdate BETWEEN '2025-01-01' AND '2025-01-31')
  OR

  (i.an IS NOT NULL AND i.dchdate BETWEEN '2025-01-01' AND '2025-01-31')

GROUP BY 
  p.cid, p.hn, o.vstdate, i.regdate, i.dchdate, 
  p.pname, p.fname, p.lname, pt.name, op.an, op.vn, 
  an_stat.income, vn_stat.income

ORDER BY o.vstdate;
----------
' SELECT o.vstdate, i.regdate, i.dchdate, p.cid, p.hn, op.an, op.vn, CONCAT(p.pname," ", p.fname," ", p.lname) AS patient_name, pt.name,'
+ '   SUM( CASE '
+ '     WHEN op.an IS NOT NULL THEN 50 '
+ '     WHEN op.vn IS NOT NULL THEN 50 '
+ '   ELSE 0 END) AS cost,'
+ '   CASE '
+ '     WHEN op.an IS NOT NULL THEN an_stat.income '
+ '     WHEN op.vn IS NOT NULL THEN vn_stat.income '
+ '     ELSE 0 '
+ '   END AS costs'
+ ' FROM ovst o'
+ ' LEFT JOIN ipt i '
+ '    ON  (o.vn = i.vn AND i.dchdate BETWEEN "'+ds1+'" AND "'+ds2+'")'
+ '    OR (o.an = i.an AND i.dchdate BETWEEN "'+ds1+'" AND "'+ds2+'")'
+ ' INNER JOIN patient p ON p.hn = o.hn AND p.nationality = "99"  AND p.birthday < "1992-01-01"'
+ ' INNER JOIN pttype pt ON pt.pttype = o.pttype'
+ ' INNER JOIN ( SELECT vn, an  FROM opitemrece  WHERE icode = "3000038") op  ON op.vn = o.vn OR op.an = i.an'
+ ' LEFT JOIN vn_stat ON vn_stat.vn = o.vn '
+ ' LEFT JOIN an_stat ON an_stat.an = i.an'
+ ' WHERE  (i.an IS NULL AND o.vstdate BETWEEN "'+ds1+'" AND "'+ds2+'") OR (i.an IS NOT NULL AND i.dchdate BETWEEN "'+ds1+'" AND "'+ds2+'")'
+ ' GROUP BY p.cid, p.hn, o.vstdate, i.regdate, i.dchdate,  p.pname, p.fname, p.lname, pt.name, op.an, op.vn, an_stat.income, vn_stat.income'
+ ' ORDER BY o.vstdate'
