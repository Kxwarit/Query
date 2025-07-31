WITH base AS ( 
     SELECT 
         v.hcode, 
         h.name AS name_hcode, 
         t.name AS chw_name, 
         p.cid, 
         o.vstdate, 
         CONCAT(p.pname, p.fname, ' ', p.lname) AS fullname, 
         v.age_y, 
         s.name AS sex, 
         p.mobile_phone_number, 
         g.pttype_coverage_group_code AS pttype_patient, 
  
         CASE 
             WHEN oc.nhso_code IN ('6111','6112','6113','9211','6114','9213','9214') THEN '/' 
         END AS เกษตรกรผู้ประกอบอาชีพ, 
  
         CASE 
             WHEN oc.nhso_code NOT IN ('6111','6112','6113','9211','6114','9213','9214') THEN '/' 
         END AS ประชาชนกลุ่มเสี่ยง, 
  
         CASE 
             WHEN ppt.pp_special_code = '1B1170' THEN '4' 
             WHEN ppt.pp_special_code = '1B1171' THEN '3' 
             WHEN ppt.pp_special_code = '1B1172' THEN '2' 
             WHEN ppt.pp_special_code = '1B1173' THEN '1' 
         END AS special 
  
     FROM pp_special pp 
     LEFT JOIN ovst o ON o.vn = pp.vn 
     LEFT JOIN vn_stat v ON o.vn = v.vn 
     LEFT JOIN patient p ON p.hn = o.hn 
     LEFT JOIN sex s ON s.code = p.sex 
     LEFT JOIN occupation oc ON oc.occupation = p.occupation 
     LEFT JOIN pttype ptt ON ptt.pttype = o.pttype 
     LEFT JOIN pttype_coverage_group g ON g.pttype_coverage_group_code = ptt.hipdata_code 
     LEFT JOIN person ps ON ps.patient_hn = p.hn 
     LEFT JOIN pp_special_type ppt ON ppt.pp_special_type_id = pp.pp_special_type_id 
     LEFT JOIN pp_special_service_place_type ppp ON ppp.pp_special_service_place_type_id = pp.pp_special_service_place_type_id 
     LEFT JOIN doctor d ON d.code = pp.doctor 
     LEFT JOIN patient_pttype pt ON pt.hn = p.hn 
     LEFT JOIN hospcode h ON h.hospcode = v.hcode 
     LEFT JOIN thaiaddress t ON t.chwpart = h.chwpart AND t.codetype = '1' 
     WHERE o.vstdate BETWEEN '2024-01-01' AND '2025-06-30'        
       AND v.age_y >= '15' 
       AND ppt.pp_special_code IN ('1B1170','1B1171','1B1172','1B1173') 
 ) 
  
 SELECT DISTINCT ON (cid) * 
 FROM base 
 WHERE EXTRACT(YEAR FROM vstdate) = 2025 
   AND cid NOT IN ( 
       SELECT cid 
       FROM base 
       WHERE EXTRACT(YEAR FROM vstdate) = 2024 
   ) 
 ORDER BY cid, vstdate DESC