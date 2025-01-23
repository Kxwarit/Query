SELECT
    reout.refer_date,
    p.cid,
    p.hn, 
    Concat(Coalesce(p.pname, ''), Coalesce(p.fname, ''), ' ', Coalesce(p.lname, '')) AS patient_name,
    CASE WHEN p.sex = '1' THEN 'ชาย' WHEN p.sex = '2' THEN 'หญิง' ELSE NULL END AS sex,
    Extract(YEAR FROM Age(o.vstdate, p.birthday)) as age,
    STRING_AGG( DISTINCT CASE 
     WHEN p.hometel <> '' AND p.hometel ~ '^[0-9-]+$' AND p.hometel !~ '^(.)\1*$' THEN p.hometel 
     WHEN p.mobile_phone_number <> '' AND p.mobile_phone_number ~ '^[0-9-]+$' AND p.mobile_phone_number !~ '^(.)\1*$' THEN p.mobile_phone_number 
     WHEN p.informtel <> '' AND p.informtel ~ '^[0-9-]+$' AND p.informtel !~ '^(.)\1*$' THEN p.informtel 
    ELSE NULL END, ', ') AS contact,
    concat(doc.name , ' ', doc.licenseno) AS dname,
    reout.pre_diagnosis as diag,
    Concat('                                 ', Replace(Replace(os.cc, E'\r', ''), E'\n', ', ')) AS cc,
    h.name AS hospmain
FROM ovst o
INNER JOIN referout reout ON o.vn = reout.vn OR o.an = reout.vn
LEFT OUTER JOIN patient p ON p.hn = o.hn
LEFT OUTER JOIN opdscreen os ON os.vn = o.vn
LEFT OUTER JOIN doctor doc ON doc.code = reout.doctor
LEFT OUTER JOIN icd101 icd ON icd.code = reout.pdx
LEFT OUTER JOIN hospcode h ON h.hospcode = reout.refer_hospcode
WHERE o.vn = 680122150326
GROUP BY reout.refer_date, p.cid, p.hn, p.pname, p.fname, p.lname, p.sex, doc.name, doc.licenseno, reout.pre_diagnosis, os.cc, h.name, o.vstdate, p.birthday
ORDER BY refer_date DESC
LIMIT 100