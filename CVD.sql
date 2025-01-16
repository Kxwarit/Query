SELECT  
    o.vstdate, 
    o.vn, 
    p.hn, 
    CONCAT(p.pname, p.fname, ' ', p.lname) AS patient_name,
    os.cc, 
    vv.age_y,
    STRING_AGG(od.icd10, ', ') as icd10,
    s.name as spclty,
    opd_ill_history.cc_persist_disease
FROM ovst o
LEFT OUTER JOIN opdscreen os ON os.vn = o.vn
LEFT OUTER JOIN patient p ON p.hn = o.hn
LEFT OUTER JOIN ovstdiag od ON od.vn = o.vn
LEFT OUTER JOIN vn_stat vv ON vv.vn = o.vn
LEFT OUTER JOIN spclty s ON s.spclty = o.spclty
LEFT OUTER JOIN opd_ill_history ON o.hn = opd_ill_history.hn
WHERE o.vstdate BETWEEN '2024-06-01' AND '2024-06-30' 
AND o.main_dep = '010' 
AND (os.cc ILIKE '%risk%' OR os.cc ILIKE '%cvd%')
AND vv.age_y BETWEEN '35' AND '60'
AND ((od.icd10 BETWEEN 'E10' AND 'E149' AND NOT EXISTS ( SELECT 1 FROM ovstdiag od_sub WHERE od_sub.vn = o.vn AND od_sub.icd10 BETWEEN 'I60' AND 'I699' ))
OR ((od.icd10 BETWEEN 'I10' AND 'I159' AND od.icd10 NOT IN ('I110','I119','I130','I131','I132','I139')) AND NOT EXISTS ( SELECT 1 FROM ovstdiag od_sub WHERE od_sub.vn = o.vn AND od_sub.icd10 BETWEEN 'I60' AND 'I699' )))
GROUP BY o.vstdate, o.vn, p.hn, p.pname, p.fname, p.lname,os.cc, vv.age_y, s.name, opd_ill_history.cc_persist_disease  
ORDER BY o.vstdate
----------------------
'SELECT ' 
+ '    o.vstdate,' 
+ '    o.vn, '
+ '    p.hn, '
+ '    CONCAT(p.pname, p.fname, " ", p.lname) AS patient_name,'
+ '    os.cc, '
+ '    vv.age_y,'
+ '    STRING_AGG(od.icd10, ", ") as icd10,'
+ '    s.name as spaclty,'
+ '    opd_ill_history.cc_persist_disease'
+ '    FROM ovst o'
+ '    LEFT OUTER JOIN opdscreen os ON os.vn = o.vn'
+ '    LEFT OUTER JOIN patient p ON p.hn = o.hn'
+ '    LEFT OUTER JOIN ovstdiag od ON od.vn = o.vn'
+ '    LEFT OUTER JOIN vn_stat vv ON vv.vn = o.vn'
+ '    LEFT OUTER JOIN spclty s ON s.spclty = o.spclty'
+ '    LEFT OUTER JOIN opd_ill_history ON o.hn = opd_ill_history.hn'
+ '    WHERE o.vstdate BETWEEN "2023-12-01" AND "2025-01-10" '
+ '    AND o.main_dep = "010" '
+ '    AND (os.cc ILIKE "%risk%" OR os.cc ILIKE "%cvd%")'
+ '    AND vv.age_y BETWEEN "35" AND "60"'
+ '    AND ((od.icd10 BETWEEN "E10" AND "E149" AND NOT EXISTS ( SELECT 1 FROM ovstdiag od_sub WHERE od_sub.vn = o.vn AND od_sub.icd10 BETWEEN "I60" AND "I699" ))'
+ '    OR ((od.icd10 BETWEEN "I10" AND "I159" AND od.icd10 NOT IN ("I110","I119","I130","I131","I132","I139")) AND NOT EXISTS ( SELECT 1 FROM ovstdiag od_sub WHERE od_sub.vn = o.vn AND od_sub.icd10 BETWEEN "I60" AND "I699" )))'
+ '    GROUP BY o.vstdate, o.vn, p.hn, p.pname, p.fname, p.lname,os.cc, vv.age_y  '
------------
'SELECT ' 
+ '    o.vstdate,' 
+ '    o.vn, '
+ '    p.hn, '
+ '    CONCAT(p.pname, p.fname, " ", p.lname) AS patient_name,'
+ '    os.cc, '
+ '    vv.age_y,'
+ '    STRING_AGG(od.icd10, ", ") as icd10'
+ '    FROM ovst o'
+ '    LEFT OUTER JOIN opdscreen os ON os.vn = o.vn'
+ '    LEFT OUTER JOIN patient p ON p.hn = o.hn'
+ '    LEFT OUTER JOIN ovstdiag od ON od.vn = o.vn'
+ '    LEFT OUTER JOIN vn_stat vv ON vv.vn = o.vn'
+ '    WHERE o.vstdate BETWEEN "2023-12-01" AND "2025-01-10" '
+ '    AND o.main_dep = "010" '
+ '    AND (os.cc NOT ILIKE "%risk%" OR os.cc NOT ILIKE "%cvd%")'
+ '    AND vv.age_y BETWEEN "35" AND "60"'
+ '    AND ((od.icd10 BETWEEN "E10" AND "E149" AND NOT EXISTS ( SELECT 1 FROM ovstdiag od_sub WHERE od_sub.vn = o.vn AND od_sub.icd10 BETWEEN "I60" AND "I699" ))'
+ '    OR ((od.icd10 BETWEEN "I10" AND "I159" AND od.icd10 NOT IN ("I110","I119","I130","I131","I132","I139")) AND NOT EXISTS ( SELECT 1 FROM ovstdiag od_sub WHERE od_sub.vn = o.vn AND od_sub.icd10 BETWEEN "I60" AND "I699" )))'
+ '    GROUP BY o.vstdate, o.vn, p.hn, p.pname, p.fname, p.lname,os.cc, vv.age_y  '