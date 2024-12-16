SELECT 
    i.hn, p.cid, Concat(p.pname, p.fname, ' ', p.lname) AS patient_name,
    CASE WHEN p.sex = '1' AND p.sex <> '' THEN 'ชาย' ELSE 'หญิง' END AS sex,
    an.age_y, an.age_m, an.age_d,
    n.name AS nationality,
    oc.name AS occupation,
    String_Agg(DISTINCT CASE
        WHEN p.hometel <> '' AND p.hometel ~ '^[0-9-]+$' AND p.hometel !~ '^(.)\1*$' THEN p.hometel
        WHEN p.mobile_phone_number <> '' AND p.mobile_phone_number ~ '^[0-9-]+$' AND p.mobile_phone_number !~ '^(.)\1*$' THEN p.mobile_phone_number
        WHEN p.informtel <> '' AND p.informtel ~ '^[0-9-]+$' AND p.informtel !~ '^(.)\1*$' THEN p.informtel
    ELSE NULL END, ', ') AS contact,
    CASE WHEN p.informaddr <> '' THEN p.informaddr ELSE Concat_Ws(' ', p.addrpart, (CASE WHEN p.moopart <> '' THEN Concat('หมู่ ', p.moopart) END), th.full_name) END AS addr,
    TO_CHAR(id.modify_datetime + INTERVAL '543 years', 'DD/MM/YYYY HH24:MI:SS') AS modify_datetime_thai,
    id.icd10,
    STRING_AGG( CASE WHEN lo.lab_items_code IN ('76', '3660') THEN lo.lab_order_result ELSE NULL END, ', ') as lab_order_result
FROM ipt i 
INNER JOIN ipt_newborn nb ON nb.an = i.an
LEFT OUTER JOIN iptdiag id ON id.an = i.an
LEFT OUTER JOIN patient p ON p.hn = i.hn
LEFT OUTER JOIN an_stat an ON an.an = i.an
LEFT OUTER JOIN nationality n ON n.nationality = p.nationality
LEFT OUTER JOIN occupation oc ON oc.occupation = p.occupation
LEFT OUTER JOIN thaiaddress th ON th.chwpart = p.chwpart AND th.amppart = p.amppart AND th.tmbpart = p.tmbpart
LEFT OUTER JOIN lab_head lh ON lh.vn = i.an
LEFT OUTER JOIN lab_order lo ON lo.lab_order_number = lh.lab_order_number
WHERE i.dchdate BETWEEN '2023-10-01' AND '2024-09-30' 
AND (id.icd10 BETWEEN 'A50' AND 'A539' OR id.icd10 IN ('I980', 'M031', 'N290', 'O981'))
AND i.pttype = 'K1' 
GROUP BY  i.hn, p.cid, an.age_y, an.age_m, an.age_d, n.name, oc.name, id.modify_datetime,  id.icd10, p.pname, p.fname, p.lname, p.sex, p.informaddr, p.addrpart, p.moopart, th.full_name, i.dchdate 
ORDER BY i.dchdate 