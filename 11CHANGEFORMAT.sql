SELECT o.vstdate, i.regdate, i.dchdate, p.cid, p.hn, o.vn, i.an, concat(p.pname, p.fname, " ", p.lname) as patient_name, STRING_AGG(n.name,E",\n" ) as items, sum(op.sum_price), CASE WHEN i.an IS NOT NULL THEN "IPD" ELSE "OPD" END AS dep,
CASE WHEN i.an IS NOT NULL THEN aa.uc_money ELSE vv.uc_money END AS uc_money 
FROM ovst o
LEFT OUTER JOIN ipt i ON i.an = o.an OR i.vn = o.vn
LEFT OUTER JOIN patient p ON p.hn = o.hn
LEFT OUTER JOIN opitemrece op ON op.vn = o.vn OR op.an = i.an
LEFT OUTER JOIN nondrugitems n ON n.icode = op.icode
LEFT OUTER JOIN xray_items x ON x.icode = n.icode
LEFT OUTER JOIN vn_stat vv ON vv.vn = o.vn
LEFT OUTER JOIN an_stat aa ON aa.an = i.an
WHERE CASE WHEN i.an IS NULL THEN o.vstdate BETWEEN "2025-01-01" AND "2025-01-24" ELSE i.dchdate BETWEEN "2025-01-01" AND "2025-01-24" END
AND o.pttype IN ("T1","T2","T3","T4")
AND (x.xray_items_name LIKE "CT%" OR n.icode IN ("3003821","3003822"))
GROUP BY  o.vstdate, i.regdate, i.dchdate, p.cid, p.hn, o.vn, i.an, p.pname, p.fname, p.lname, aa.uc_money, vv.uc_money


SELECT o.vstdate, p.cid, p.hn, o.vn, i.an, concat(p.pname, p.fname, " ", p.lname) as patient_name, STRING_AGG(n.name,E",\n" ) as items, sum(op.sum_price), CASE WHEN i.an IS NOT NULL THEN "IPD" ELSE "OPD" END AS dep
FROM ovst o
LEFT JOIN ipt i ON i.an = o.an OR i.vn = o.vn
LEFT JOIN patient p ON p.hn = o.hn
LEFT JOIN opitemrece op ON op.vn = o.vn OR op.an = i.an
LEFT JOIN nondrugitems n ON n.icode = op.icode
LEFT JOIN xray_items x ON x.icode = n.icode
WHERE o.vstdate BETWEEN "2025-01-01" AND "2025-01-10"
  AND o.pttype IN ("T1","T2","T3","T4")
GROUP BY o.vstdate, p.cid, p.hn, o.vn, i.an, p.pname, p.fname, p.lname
HAVING SUM(CASE WHEN x.xray_items_name LIKE "CT%" OR n.icode IN ("3003821","3003822") THEN 1 ELSE 0 END) = 0;
