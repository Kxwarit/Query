SELECT ro.refer_date, p.hn, p.cid, Concat(p.pname, p.fname, ' ', p.lname) AS patient_name, ro.with_ambulance,
CASE WHEN ro.refer_point NOT IN ('ER', 'LR', 'ICU') THEN w.name ELSE ro.refer_point END AS refer_point
FROM referout ro
LEFT OUTER JOIN patient p ON p.hn = ro.hn
LEFT OUTER JOIN opitemrece op ON op.vn = ro.vn OR op.an = ro.vn
LEFT OUTER JOIN nondrugitems n ON n.icode = op.icode
LEFT OUTER JOIN ipt i ON i.an = ro.vn
LEFT OUTER JOIN ward w ON w.ward = i.ward
LEFT OUTER JOIN iptadm t ON t.an = i.an
WHERE ro.refer_date BETWEEN '2024-10-01' AND '2024-12-31' AND (ro.with_ambulance = 'Y' OR n.name LIKE 'ค่าบริการรถพยาบาล%')
GROUP BY ro.refer_date, p.hn, p.cid, ro.with_ambulance, p.pname, p.fname, p.lname, ro.refer_point, i.ward, w.name, t.bedno
HAVING (CASE WHEN ro.refer_point NOT IN ('ER', 'LR', 'ICU') THEN w.name ELSE ro.refer_point END) <> ''
ORDER BY refer_point, ro.refer_date