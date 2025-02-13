SELECT o.vstdate, p.hn, p.cid, concat(p.pname,p.fname,' ',p.lname) as patient_name, k.department
FROM ovst o
LEFT OUTER JOIN patient p ON p.hn = o.hn
LEFT OUTER JOIN kskdepartment k ON k.depcode = o.main_dep
WHERE o.vstdate BETWEEN '2025-01-01' AND '2025-03-31' AND o.ovstist = '10'
LIMIT 100