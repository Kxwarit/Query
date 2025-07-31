WITH ranked_data AS (  
    SELECT  "สุราษฎร์ธานี" as chw ,  
        vs.hn,    
        CONCAT(pt.pname, pt.fname, " ", pt.lname) AS ptname,  
        pt.cid,      
        concat(vs.age_y," ปี ",vs.age_m," เดือน ", vs.age_d," วัน") AS age,   
        s.name AS sex,   
        t.name AS pttype,  
        CASE  
            WHEN pt.mobile_phone_number IS NULL THEN pt.informtel  
            ELSE pt.mobile_phone_number  
        END AS Telno,  
        dc.entry_datetime::date AS vstdate1,   
        dc.dteeth,  
        dc.dcaries,  
        dc.dfilling,  
        dc.dextract,  
        CASE   
            WHEN dc.need_fluoride = "Y" THEN "ใช่"   
            WHEN dc.need_fluoride = "N" THEN "ไม่ใช่"    
            ELSE " "   
        END AS fluoride_flag,  
        CASE   
           WHEN dc.dteeth BETWEEN 1 AND 20 THEN "ผ่าน"  
           WHEN dc.entry_datetime is null THEN "ไม่ผ่าน"         
           ELSE "ไม่ผ่าน"  
        END AS is_valid_dteeth,  
        vs.vstdate AS vstdate2,  
        string_agg(dtt.name, ",") AS dtname,  
        string_agg(dtt.icd10tm_operation_code, ",") AS icd10tm,  
          CASE  
           WHEN "2330011" = ANY(array_agg(dtt.icd10tm_operation_code)) THEN 2330011   
           ELSE Null   
       END AS is_Oralexam, 
       CASE  
           WHEN "2377020" = ANY(array_agg(dtt.icd10tm_operation_code)) THEN "ผ่าน" 
           WHEN "2377021" = ANY(array_agg(dtt.icd10tm_operation_code)) THEN "ผ่าน" 
           ELSE "ไม่ผ่าน"  
       END AS fluoride,  
        CASE  
           WHEN "2377020" = ANY(array_agg(dtt.icd10tm_operation_code)) THEN 2377020  
           WHEN "2377021" = ANY(array_agg(dtt.icd10tm_operation_code)) THEN 2377021 
           ELSE Null   
       END AS is_fluoride, 
  
        ROW_NUMBER() OVER (PARTITION BY pt.cid ORDER BY dc.entry_datetime DESC NULLS LAST) AS rn  
    FROM dtmain dt                    
    LEFT JOIN vn_stat vs ON vs.vn = dt.vn        
    LEFT JOIN patient pt ON pt.hn = vs.hn  
    LEFT JOIN pttype t ON t.pttype = vs.pttype   
    LEFT JOIN sex s ON s.code = pt.sex  
    LEFT JOIN dttm dtt ON dtt.code = dt.tmcode  
    LEFT JOIN dental_care dc ON dc.vn = dt.vn  
    LEFT JOIN officer of ON of.officer_login_name = dt.staff       
    LEFT JOIN doctor doc ON doc.code = of.officer_doctor_code  
    WHERE vs.vstdate BETWEEN "ds1" AND "ds2"   
      AND pt.nationality = "99"  
      AND dtt.icd10tm_operation_code IN ("2377020","2377021","2330011")  
      AND vs.age_y <= "2"   
      AND doc.provider_type_code IN ("02","06")    
    GROUP BY    
        vs.hn, pt.pname, pt.fname, pt.lname, pt.cid,      
        vs.age_y,vs.age_m,vs.age_d,s.name, t.name,  
        pt.mobile_phone_number, pt.informtel, dc.entry_datetime, vs.vstdate,  
        dc.dteeth, dc.dcaries, dc.dfilling, dc.dextract, dc.need_fluoride  
  )  
    
  SELECT *  
  FROM ranked_data  
  WHERE rn = 1