SELECT 
  (t.name) as chw_name,
  vv.hcode,
  (h.name) as name_hcode,
  CONCAT(p.pname, p.fname,' ', p.lname) as patient_name,
  p.cid,
  vv.age_y,
  CASE
    WHEN p.sex = '1' THEN 'ชาย' 
    WHEN p.sex = '2' THEN 'หญิง' 
  ELSE 'ไม่ระบุ' END AS sex,
  CASE                                
      WHEN pt.pttype IN (             
          'U1','U2','U3','U4','U5','U6','U7','U8','U9',  
          'V1','V2','V3','V4','V5','V6','V7','V8','V9',  
          'W1','W2','W3','W4','W5','W6','W7','W8','W9',  
          'X1','X2','X3','X4','X5','X6','X7','X8','X9',  
          'Y1','Y2','Y3','Y4','Y5','Y6','Y7','Y8','Y9',  
          'K1','D1','F1','F2','T1','T2','T3','T4'        
      ) THEN 'UC'                                        
      WHEN pt.pttype IN (                                
          'S0','SO','S1','S2','S3','S4','S5','S6','S7','S8','S9','Z4'     
      ) THEN 'ประกันสังคม'                               
      WHEN pt.pttype IN (                                
          'A1','A2','A3','A4',                           
          'B1','B2','B3','B4','B5',                      
          'C1','C2','C3','C4','C5','C6',                 
          'E2','E3','E4','G1',                           
          'O1','O2','O3','O4','O5',                      
          'P1','P2','P3'                                 
      ) THEN 'ข้าราชการ'                                                                                 
      WHEN pt.pttype IN ('L1','L2','L3','L4','L5','L6','L9') THEN 'ข้าราชการท้องถิ่น'                     
      WHEN pt.pttype IN ('N1','N2','N3','N4','N5','N6','F3','H3','H4') THEN 'แรงงานต่างด้าว'              
      WHEN pt.pttype IN ('H1','H2','H5','H6','I2','I3','J2','J3','J4','J6','D2') THEN 'ชำระเงินเอง'      
      WHEN pt.pttype IN ('I1') THEN 'พรบ.ประกันภัยรถ'                                                     
      WHEN pt.pttype IN ('1') THEN 'นักเรียน/นักศึกษา'                                                    
      ELSE 'สิทธิอื่น ๆ'                                                                                  
  END AS pttype_patient,                                 
  STRING_AGG( DISTINCT CASE 
   WHEN p.hometel <> '' AND p.hometel ~ '^[0-9-]+$' AND p.hometel !~ '^(.)\1*$' THEN p.hometel 
   WHEN p.mobile_phone_number <> '' AND p.mobile_phone_number ~ '^[0-9-]+$' AND p.mobile_phone_number !~ '^(.)\1*$' THEN p.mobile_phone_number 
   WHEN p.informtel <> '' AND p.informtel ~ '^[0-9-]+$' AND p.informtel !~ '^(.)\1*$' THEN p.informtel 
  ELSE NULL END, ', ') AS contact,
  CASE WHEN p.occupation BETWEEN '502' AND '505' THEN 'Y' ELSE NULL END AS occupation_y,
  CASE WHEN p.occupation NOT BETWEEN '502' AND '505' THEN 'Y' ELSE NULL END AS occupation_n,

  CASE 
    WHEN ppt.pp_special_code = '1B1172' THEN 'มีความเสี่ยง' 
    WHEN ppt.pp_special_code = '1B1173' THEN 'ไม่ปลอดภัย' 
  ELSE NULL END AS pp_special_result,
  o.vstdate
FROM ovst o 
LEFT OUTER JOIN pp_special pp ON pp.vn = o.vn 
LEFT OUTER JOIN vn_stat vv ON vv.vn = o.vn 
LEFT OUTER JOIN patient p ON p.hn = o.hn
LEFT OUTER JOIN pp_special_type ppt ON ppt.pp_special_type_id = pp.pp_special_type_id
LEFT OUTER JOIN pttype pt ON pt.pttype = o.pttype 
LEFT JOIN hospcode h ON h.hospcode = vv.hcode                                                            
LEFT JOIN thaiaddress t on t.chwpart = h.chwpart and t.codetype = '1'        
WHERE o.vstdate BETWEEN '2019-10-01' AND '2024-09-30'
AND ppt.pp_special_code BETWEEN '1B1172' AND '1B1173'
AND vv.age_y >= 15
GROUP BY vv.hcode, h.name, t.name, p.pname, p.fname, p.lname, p.cid, vv.age_y, p.sex, pt.pttype, ppt.pp_special_type_name, o.vstdate, ppt.pp_special_code, p.occupation

