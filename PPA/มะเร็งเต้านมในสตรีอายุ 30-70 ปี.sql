SELECT CONCAT(p1.pname, p1.fname, ' ', p1.lname) AS fullname,p1.cid ,EXTRACT(YEAR FROM AGE(DATE '2024-10-01', p1.birthday)) AS age_yy, 
   ov.vstdate,ps2.pp_special_code ,vs.hcode,(h.name) as name_hcode,(t.name) as chw_name,g.pttype_coverage_group_code as pttype_patient,                                                                  
   CASE                                 
        WHEN p1.sex = '1' THEN 'ชาย'    
        WHEN p1.sex = '2' THEN 'หญิง'  
        ELSE 'ไม่ระบุ'                  
    END AS sex_patient,                 
 
    CASE                                                                                                    
        WHEN ps2.pp_special_code IN ('1B0030', '1B0031', '1B0032', '1B0033') THEN 'ปกติ'                    
        WHEN ps2.pp_special_code IN ('1B0034', '1B0035', '1B0036', '1B0037') THEN 'ผิดปกติ'                 
        ELSE 'ไม่ระบุ'                                                                                      
    END AS special                                                                                          
   FROM person p                                                                                            
   LEFT JOIN patient p1 ON p.cid = p1.cid                                                                   
   LEFT JOIN ovst ov ON p1.hn = ov.hn                                                                       
   left join vn_stat vs on vs.vn=ov.vn                                                                      
   INNER JOIN pp_special ps1 ON ov.vn = ps1.vn                                                              
   INNER JOIN pp_special_type ps2 ON ps1.pp_special_type_id = ps2.pp_special_type_id                        
   LEFT JOIN pttype pt ON pt.pttype = ov.pttype                                                             
   LEFT JOIN pttype_coverage_group g on g.pttype_coverage_group_code = pt.hipdata_code                      
   LEFT JOIN hospcode h ON h.hospcode = vs.hcode                                                            
   LEFT join thaiaddress t on t.chwpart=h.chwpart and t.codetype = '1'                                      
   WHERE EXTRACT(YEAR FROM AGE(DATE '2024-10-01', p1.birthday)) BETWEEN 30 AND 70                                              
     AND p1.sex = '2' and p.house_regist_type_id in ('1','3') and p.nationality='99' and vs.pdx='Z123'      
     AND ps2.pp_special_code IN ('1B0030','1B0031','1B0032','1B0033','1B0034','1B0035','1B0036','1B0037'  ) 
     AND ov.vstdate BETWEEN  '2024-12-01' and '2025-06-30'                                                 
   GROUP BY p1.pname, p1.fname, p1.lname, p1.cid,vs.hcode,h.name,p1.birthday, p1.sex, ov.vstdate, ps2.pp_special_code, ov.pttype,t.name,g.pttype_coverage_group_code  
   ORDER BY ov.vstdate DESC