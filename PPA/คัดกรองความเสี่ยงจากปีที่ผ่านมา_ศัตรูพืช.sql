 select 
(t.name) as chw_name,                                   
v.hcode,(h.name) as name_hcode,                                                                                                                                                                                                                                                                                                             
concat(p.pname,p.fname,' ',p.lname) as fullname,                                                                          
p.cid,                                                                                                                    
v.age_y,                                                                                                                  
s.name as sex,                                                                                                            
g.pttype_coverage_group_code  as pttype,                                                                                   
p.mobile_phone_number,                                                                                                    
case when  oc.nhso_code = '6111' THEN '/' END as farmer,                                                                  
case when  oc.nhso_code <> '6111' THEN '/' END as nonfarmer,                                                              
case when  ppt.pp_special_code = '1B1172' THEN 'มีความเสี่ยง'                                                             
WHEN  ppt.pp_special_code = '1B1173' THEN 'ไม่ปลอดภัย'                                                                    
END as result,                                                                                                                                                                                      
q.vstdate as vstdate2,                                                                                                    
q.result2                                                                                                                 
from  pp_special pp                                                                                                       
LEFT JOIN ovst o on o.vn = pp.vn                                                                                          
LEFT JOIN vn_stat v on o.vn = v.vn                                                                                        
LEFT JOIN patient p  on p.hn = o.hn                                                                                      
LEFT JOIN sex s on s.code = p.sex                                                                                         
LEFT JOIN occupation oc on oc.occupation = p.occupation                                                                                        
LEFT JOIN person ps on ps.patient_hn = p.hn                                                                                
LEFT JOIN pp_special_type ppt on ppt.pp_special_type_id = pp.pp_special_type_id                                                
LEFT JOIN pp_special_service_place_type ppp on ppp.pp_special_service_place_type_id = pp.pp_special_service_place_type_id  
LEFT JOIN doctor d on d.code = pp.doctor                                                                                  
LEFT JOIN patient_pttype pt on pt.hn = p.hn                                                                               
LEFT JOIN hospcode h ON h.hospcode = v.hcode                                                                              
LEFT join thaiaddress t on t.chwpart = h.chwpart and t.codetype = '1'                                                     
LEFT JOIN pttype pt2 on o.pttype = pt2.pttype                                                                            
LEFT JOIN pttype_coverage_group g on g.pttype_coverage_group_code = pt2.hipdata_code                                      
LEFT JOIN                                                                                                                 
       (                                                                                                                  
         SELECT cid,o.vstdate,                                                                                            
               case when  pt.pp_special_code = '1B1173' THEN '1'                                                                
               WHEN  pt.pp_special_code = '1B1172' THEN '2'                                                                     
               WHEN  pt.pp_special_code = '1B1171' THEN '3'                                                                     
               WHEN  pt.pp_special_code = '1B1170' THEN '4'                                                                     
               END as result2                                                                                                   
               FROM                                                                                                                     
               ovst o                                                                                                                    
               LEFT JOIN patient p on p.hn = o.hn                                                                                        
               LEFT JOIN pp_special pp on pp.vn = o.vn                                                                                   
               LEFT JOIN pp_special_type pt on pt.pp_special_type_id = pp.pp_special_type_id                                             
               where o.vstdate BETWEEN '2025-01-01' and '2025-06-30'                                                                           
               AND pt.pp_special_code in ('1B1170','1B1171','1B1172','1B1173','1B1179')                                                 
              )q  on  p.cid = q.cid                                                                                                                                
      where o.vstdate  between '2024-01-01' and '2024-12-31'                                                                    
      and v.age_y >= 15                                                                                                         
      and ppt.pp_special_code in ('1B1172','1B1173')                                                                            
     
GROUP BY 
v.hcode, h.name, t.name, o.vstdate, 
p.pname, p.fname, p.lname, 
p.cid, v.age_y, s.name, 
g.pttype_coverage_group_code, p.mobile_phone_number, 
oc.nhso_code, ppt.pp_special_code, 
q.vstdate, q.result2