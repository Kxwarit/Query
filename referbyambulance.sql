SELECT ro.refer_date, p.hn, concat(p.pname, p.fname,' ', p.lname) as patient_name, ro.with_ambulance
FROM referout ro
LEFT OUTER JOIN patient p ON p.hn = ro.hn
LEFT OUTER JOIN opitemrece op ON op.vn = ro.vn OR op.an = ro.vn
LEFT OUTER JOIN nondrugitems n ON n.icode = op.icode
WHERE ro.refer_date BETWEEN '2024-10-01' AND '2024-10-31'
AND (ro.with_ambulance = 'Y' OR n.name LIKE 'ค่าบริการรถพยาบาล%' )
GROUP BY ro.refer_date, p.hn, p.pname, p.fname, p.lname, ro.with_ambulance