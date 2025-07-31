SELECT 
    o.vstdate, 
    p.hn,
    p.cid,
    concat(p.pname, p.fname, ' ', p.lname) as patient_name,
    vv.age_y, 
    STRING_AGG(od.icd10, ', ') as icd10, 
    os.cc
FROM ovst o
LEFT OUTER JOIN patient p ON p.hn = o.hn
LEFT OUTER JOIN opdscreen os ON os.vn = o.vn
LEFT OUTER JOIN ovstdiag od ON od.vn = o.vn
LEFT OUTER JOIN vn_stat vv ON vv.vn = o.vn
WHERE o.vstdate BETWEEN '2025-05-01' AND '2025-05-31'
AND (os.cc ILIKE '%refer%'  OR os.cc LIKE '%ส่งต่อ%' OR os.cc LIKE '%ส่งกลับ%' OR os.cc LIKE '%กลับจาก%' OR os.cc LIKE '%ไปรษณีย์%' OR os.cc LIKE '%ปณ%')
AND (os.cc LIKE '%สุราษ%' OR os.cc LIKE '%สฎ%' OR os.cc LIKE '%สฏ%' OR os.cc LIKE '%สวนฯ%' OR os.cc LIKE '%สวนสราญ%' OR os.cc LIKE '%สสร%' OR os.cc LIKE '%สรร%')
AND od.icd10 BETWEEN 'F00' AND 'F999'
GROUP BY o.vstdate, p.hn, p.cid, p.pname, p.fname, p.lname, vv.age_y, os.cc