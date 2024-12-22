
      
SELECT 
o.vstdate,
o.vn, 
CONCAT(p.pname, " ", p.fname, " ", p.lname) AS patient_name,
CASE WHEN p.sex = "1" THEN "ชาย" ELSE "หญิง" END AS sex,
CONCAT(vn.age_y, " ปี ", vn.age_m, " เดือน ", vn.age_d, " วัน ") AS age,
COALESCE(cs.ckup_scr_bps, os.bps) AS bps,
COALESCE(cs.ckup_scr_bpd, os.bpd) AS bpd,
COALESCE(cs.ckup_scr_pulse, os.pulse) AS pulse,
COALESCE(cs.ckup_scr_weight, os.bw) AS bw,
COALESCE(cs.ckup_scr_height, os.height) AS height,
COALESCE(cs.ckup_scr_bmi, os.bmi) AS bmi,
COALESCE(cs.ckup_scr_waist, os.waist) AS waist,
STRING_AGG(DISTINCT opd_allergy.agent, ", ") AS opd_allergy,
oh.cc_persist_disease,
COALESCE(cs.ckup_scr_smoke, os.smoking_type_id::TEXT) AS smoking, 
COALESCE(cs.ckup_scr_drink, os.drinking_type_id::TEXT) AS drinking, 
MAX(CASE WHEN lo.lab_items_code = "1016" THEN lo.lab_order_result END) AS WBC,
MAX(CASE WHEN lo.lab_items_code = "1016" AND lo.abnormal_result = "N" THEN "ปกติ" 
WHEN lo.lab_items_code = "1016" AND lo.abnormal_result = "Y" THEN "ผิดปกติ" END) AS wbc_status,
      
MAX(CASE WHEN lo.lab_items_code = "1018" THEN lo.lab_order_result END) AS Neutrophil,
MAX(CASE WHEN lo.lab_items_code = "1018" AND lo.abnormal_result = "N" THEN "ปกติ" 
WHEN lo.lab_items_code = "1018" AND lo.abnormal_result = "Y" THEN "ผิดปกติ" END) AS Neutrophil_status, 
     
MAX(CASE WHEN lo.lab_items_code = "1019" THEN lo.lab_order_result END) AS Lymphocyte,
MAX(CASE WHEN lo.lab_items_code = "1019" AND lo.abnormal_result = "N" THEN "ปกติ" 
WHEN lo.lab_items_code = "1019" AND lo.abnormal_result = "Y" THEN "ผิดปกติ" END) AS Lymphocyte_status, 
     
MAX(CASE WHEN lo.lab_items_code = "1020" THEN lo.lab_order_result END) AS Monocyte,
MAX(CASE WHEN lo.lab_items_code = "1020" AND lo.abnormal_result = "N" THEN "ปกติ" 
WHEN lo.lab_items_code = "1020" AND lo.abnormal_result = "Y" THEN "ผิดปกติ" END) AS Monocyte_status, 
      
MAX(CASE WHEN lo.lab_items_code = "1021" THEN lo.lab_order_result END) AS Eosinophil,
MAX(CASE WHEN lo.lab_items_code = "1021" AND lo.abnormal_result = "N" THEN "ปกติ" 
WHEN lo.lab_items_code = "1021" AND lo.abnormal_result = "Y" THEN "ผิดปกติ" END) AS Eosinophil_status, 
      
MAX(CASE WHEN lo.lab_items_code = "1022" THEN lo.lab_order_result END) AS Basophil,
MAX(CASE WHEN lo.lab_items_code = "1022" AND lo.abnormal_result = "N" THEN "ปกติ" 
WHEN lo.lab_items_code = "1022" AND lo.abnormal_result = "Y" THEN "ผิดปกติ" END) AS Basophil_status,
      
MAX(CASE WHEN lo.lab_items_code = "1005" THEN lo.lab_order_result END) AS Platelet,
MAX(CASE WHEN lo.lab_items_code = "1005" AND lo.abnormal_result = "N" THEN "ปกติ" 
WHEN lo.lab_items_code = "1005" AND lo.abnormal_result = "Y" THEN "ผิดปกติ" END) AS Platelet_status,
      
MAX(CASE WHEN lo.lab_items_code = "1004" THEN lo.lab_order_result END) AS RBC,
MAX(CASE WHEN lo.lab_items_code = "1004" AND lo.abnormal_result = "N" THEN "ปกติ" 
WHEN lo.lab_items_code = "1004" AND lo.abnormal_result = "Y" THEN "ผิดปกติ" END) AS RBC_status,
      
MAX(CASE WHEN lo.lab_items_code = "1003" THEN lo.lab_order_result END) AS HCT,
MAX(CASE WHEN lo.lab_items_code = "1003" AND lo.abnormal_result = "N" THEN "ปกติ" 
WHEN lo.lab_items_code = "1003" AND lo.abnormal_result = "Y" THEN "ผิดปกติ" END) AS HCT_status,
      
MAX(CASE WHEN lo.lab_items_code = "1002" THEN lo.lab_order_result END) AS Hb,
MAX(CASE WHEN lo.lab_items_code = "1002" AND lo.abnormal_result = "N" THEN "ปกติ" 
WHEN lo.lab_items_code = "1002" AND lo.abnormal_result = "Y" THEN "ผิดปกติ" END) AS Hb_status,
      
MAX(CASE WHEN lo.lab_items_code = "1027" THEN lo.lab_order_result END) AS MCV,
MAX(CASE WHEN lo.lab_items_code = "1027" AND lo.abnormal_result = "N" THEN "ปกติ" 
WHEN lo.lab_items_code = "1027" AND lo.abnormal_result = "Y" THEN "ผิดปกติ" END) AS MCV_status,
      
MAX(CASE WHEN lo.lab_items_code = "1025" THEN lo.lab_order_result END) AS MCH,
MAX(CASE WHEN lo.lab_items_code = "1025" AND lo.abnormal_result = "N" THEN "ปกติ" 
WHEN lo.lab_items_code = "1025" AND lo.abnormal_result = "Y" THEN "ผิดปกติ" END) AS MCH_status,
      
MAX(CASE WHEN lo.lab_items_code = "1024" THEN lo.lab_order_result END) AS MCHC,
MAX(CASE WHEN lo.lab_items_code = "1024" AND lo.abnormal_result = "N" THEN "ปกติ" 
WHEN lo.lab_items_code = "1024" AND lo.abnormal_result = "Y" THEN "ผิดปกติ" END) AS MCHC_status,
      
MAX(CASE WHEN lo.lab_items_code = "3478" THEN lo.lab_order_result END) AS RDW,
MAX(CASE WHEN lo.lab_items_code = "3478" AND lo.abnormal_result = "N" THEN "ปกติ" 
WHEN lo.lab_items_code = "3478" AND lo.abnormal_result = "Y" THEN "ผิดปกติ" END) AS RDW_status,
      
MAX(CASE WHEN lo.lab_items_code = "1034" THEN lo.lab_order_result END) AS Nucleated,
MAX(CASE WHEN lo.lab_items_code = "1034" AND lo.abnormal_result = "N" THEN "ปกติ" 
WHEN lo.lab_items_code = "1034" AND lo.abnormal_result = "Y" THEN "ผิดปกติ" END) AS Nucleated_status,
      
MAX(CASE WHEN lo.lab_items_code = "3001" THEN lo.lab_order_result END) AS FBS,
MAX(CASE WHEN lo.lab_items_code = "3001" AND lo.abnormal_result = "N" THEN "ปกติ" 
WHEN lo.lab_items_code = "3001" AND lo.abnormal_result = "Y" THEN "ผิดปกติ" END) AS FBS_status,
      
MAX(CASE WHEN lo.lab_items_code = "74" THEN lo.lab_order_result END) AS BUN,
MAX(CASE WHEN lo.lab_items_code = "74" AND lo.abnormal_result = "N" THEN "ปกติ" 
WHEN lo.lab_items_code = "74" AND lo.abnormal_result = "Y" THEN "ผิดปกติ" END) AS BUN_status,
      
MAX(CASE WHEN lo.lab_items_code = "3003" THEN lo.lab_order_result END) AS Creatinine,
MAX(CASE WHEN lo.lab_items_code = "3003" AND lo.abnormal_result = "N" THEN "ปกติ" 
WHEN lo.lab_items_code = "3003" AND lo.abnormal_result = "Y" THEN "ผิดปกติ" END) AS Creatinine_status,
      
MAX(CASE WHEN lo.lab_items_code = "3424" THEN lo.lab_order_result END) AS eGFR,
MAX(CASE WHEN lo.lab_items_code = "3424" AND lo.abnormal_result = "N" THEN "ปกติ" 
WHEN lo.lab_items_code = "3424" AND lo.abnormal_result = "Y" THEN "ผิดปกติ" END) AS eGFR_status,
      
MAX(CASE WHEN lo.lab_items_code = "3004" THEN lo.lab_order_result END) AS URIC,
MAX(CASE WHEN lo.lab_items_code = "3004" AND lo.abnormal_result = "N" THEN "ปกติ" 
WHEN lo.lab_items_code = "3004" AND lo.abnormal_result = "Y" THEN "ผิดปกติ" END) AS URIC_status,
      
MAX(CASE WHEN lo.lab_items_code = "3005" THEN lo.lab_order_result END) AS Cholesterol,
MAX(CASE WHEN lo.lab_items_code = "3005" AND lo.abnormal_result = "N" THEN "ปกติ" 
WHEN lo.lab_items_code = "3005" AND lo.abnormal_result = "Y" THEN "ผิดปกติ" END) AS Cholesterol_status,
      
MAX(CASE WHEN lo.lab_items_code = "3006" THEN lo.lab_order_result END) AS Triglyceride, 
MAX(CASE WHEN lo.lab_items_code = "3006" AND lo.abnormal_result = "N" THEN "ปกติ" 
WHEN lo.lab_items_code = "3006" AND lo.abnormal_result = "Y" THEN "ผิดปกติ" END) AS Triglyceride_status,
      
MAX(CASE WHEN lo.lab_items_code = "3007" THEN lo.lab_order_result END) AS HDL,
MAX(CASE WHEN lo.lab_items_code = "3007" AND lo.abnormal_result = "N" THEN "ปกติ" 
WHEN lo.lab_items_code = "3007" AND lo.abnormal_result = "Y" THEN "ผิดปกติ" END) AS HDL_status,
      
MAX(CASE WHEN lo.lab_items_code = "3008" THEN lo.lab_order_result END) AS LDL,
MAX(CASE WHEN lo.lab_items_code = "3008" AND lo.abnormal_result = "N" THEN "ปกติ" 
WHEN lo.lab_items_code = "3008" AND lo.abnormal_result = "Y" THEN "ผิดปกติ" END) AS LDL_status,
      
MAX(CASE WHEN lo.lab_items_code = "3326" THEN lo.lab_order_result END) AS LDLDirect,
MAX(CASE WHEN lo.lab_items_code = "3326" AND lo.abnormal_result = "N" THEN "ปกติ" 
WHEN lo.lab_items_code = "3326" AND lo.abnormal_result = "Y" THEN "ผิดปกติ" END) AS LDLDirect_status,
      
MAX(CASE WHEN lo.lab_items_code = "3014" THEN lo.lab_order_result END) AS AST,
MAX(CASE WHEN lo.lab_items_code = "3014" AND lo.abnormal_result = "N" THEN "ปกติ" 
WHEN lo.lab_items_code = "3014" AND lo.abnormal_result = "Y" THEN "ผิดปกติ" END) AS AST_status,
      
MAX(CASE WHEN lo.lab_items_code = "3015" THEN lo.lab_order_result END) AS ALT,
MAX(CASE WHEN lo.lab_items_code = "3015" AND lo.abnormal_result = "N" THEN "ปกติ" 
WHEN lo.lab_items_code = "3015" AND lo.abnormal_result = "Y" THEN "ผิดปกติ" END) AS ALT_status,
      
MAX(CASE WHEN lo.lab_items_code = "3016" THEN lo.lab_order_result END) AS ALK,
MAX(CASE WHEN lo.lab_items_code = "3016" AND lo.abnormal_result = "N" THEN "ปกติ" 
WHEN lo.lab_items_code = "3016" AND lo.abnormal_result = "Y" THEN "ผิดปกติ" END) AS ALK_status,
      
MAX(CASE WHEN lo.lab_items_code = "3570" THEN lo.lab_order_result END) AS Volume,
      
MAX(CASE WHEN lo.lab_items_code = "56" THEN lo.lab_order_result END) AS Color,
MAX(CASE WHEN lo.lab_items_code = "56" AND lo.abnormal_result = "N" THEN "ปกติ" 
WHEN lo.lab_items_code = "56" AND lo.abnormal_result = "Y" THEN "ผิดปกติ" END) AS Color_status,
      
MAX(CASE WHEN lo.lab_items_code = "58" THEN lo.lab_order_result END) AS Transparancy,
MAX(CASE WHEN lo.lab_items_code = "58" AND lo.abnormal_result = "N" THEN "ปกติ" 
WHEN lo.lab_items_code = "58" AND lo.abnormal_result = "Y" THEN "ผิดปกติ" END) AS Transparancy_status,
      
MAX(CASE WHEN lo.lab_items_code = "66" THEN lo.lab_order_result END) AS Spgr, 
MAX(CASE WHEN lo.lab_items_code = "66" AND lo.abnormal_result = "N" THEN "ปกติ" 
WHEN lo.lab_items_code = "66" AND lo.abnormal_result = "Y" THEN "ผิดปกติ" END) AS Spgr_status,
      
MAX(CASE WHEN lo.lab_items_code = "60" THEN lo.lab_order_result END) AS pH, 
MAX(CASE WHEN lo.lab_items_code = "60" AND lo.abnormal_result = "N" THEN "ปกติ" 
WHEN lo.lab_items_code = "60" AND lo.abnormal_result = "Y" THEN "ผิดปกติ" END) AS pH_status,
      
MAX(CASE WHEN lo.lab_items_code = "68" THEN lo.lab_order_result END) AS RBC_Urine,
MAX(CASE WHEN lo.lab_items_code = "68" AND lo.abnormal_result = "N" THEN "ปกติ" 
WHEN lo.lab_items_code = "68" AND lo.abnormal_result = "Y" THEN "ผิดปกติ" END) AS RBC_Urine_status,
      
MAX(CASE WHEN lo.lab_items_code = "70" THEN lo.lab_order_result END) AS WBC_Urine,
MAX(CASE WHEN lo.lab_items_code = "70" AND lo.abnormal_result = "N" THEN "ปกติ" 
WHEN lo.lab_items_code = "70" AND lo.abnormal_result = "Y" THEN "ผิดปกติ" END) AS WBC_Urine_status,
      
MAX(CASE WHEN lo.lab_items_code = "62" THEN lo.lab_order_result END) AS Albumin, 
MAX(CASE WHEN lo.lab_items_code = "62" AND lo.abnormal_result = "N" THEN "ปกติ" 
WHEN lo.lab_items_code = "62" AND lo.abnormal_result = "Y" THEN "ผิดปกติ" END) AS Albumin_status,
      
MAX(CASE WHEN lo.lab_items_code = "64" THEN lo.lab_order_result END) AS Glucose,
MAX(CASE WHEN lo.lab_items_code = "64" AND lo.abnormal_result = "N" THEN "ปกติ" 
WHEN lo.lab_items_code = "64" AND lo.abnormal_result = "Y" THEN "ผิดปกติ" END) AS Glucose_status,
      
MAX(CASE WHEN lo.lab_items_code = "3291" THEN lo.lab_order_result END) AS Nitrite, 
MAX(CASE WHEN lo.lab_items_code = "3291" AND lo.abnormal_result = "N" THEN "ปกติ" 
WHEN lo.lab_items_code = "3291" AND lo.abnormal_result = "Y" THEN "ผิดปกติ" END) AS Nitrite_status,
      
MAX(CASE WHEN lo.lab_items_code = "3186" THEN lo.lab_order_result END) AS Ketone,
MAX(CASE WHEN lo.lab_items_code = "3186" AND lo.abnormal_result = "N" THEN "ปกติ" 
WHEN lo.lab_items_code = "3186" AND lo.abnormal_result = "Y" THEN "ผิดปกติ" END) AS Ketone_status,
      
MAX(CASE WHEN lo.lab_items_code = "3230" THEN lo.lab_order_result END) AS Bilirubin,
MAX(CASE WHEN lo.lab_items_code = "3230" AND lo.abnormal_result = "N" THEN "ปกติ" 
WHEN lo.lab_items_code = "3230" AND lo.abnormal_result = "Y" THEN "ผิดปกติ" END) AS Bilirubin_status,
      
MAX(CASE WHEN lo.lab_items_code = "72" THEN lo.lab_order_result END) AS Epithelial_Cell,
MAX(CASE WHEN lo.lab_items_code = "72" AND lo.abnormal_result = "N" THEN "ปกติ" 
WHEN lo.lab_items_code = "72" AND lo.abnormal_result = "Y" THEN "ผิดปกติ" END) AS Epithelial_Cell_status,
      
MAX(CASE WHEN lo.lab_items_code = "3085" THEN lo.lab_order_result END) AS Bacteria,
MAX(CASE WHEN lo.lab_items_code = "3085" AND lo.abnormal_result = "N" THEN "ปกติ" 
WHEN lo.lab_items_code = "3085" AND lo.abnormal_result = "Y" THEN "ผิดปกติ" END) AS Bacteria_status,
      
MAX(CASE WHEN lo.lab_items_code = "3070" THEN lo.lab_order_result END) AS Color_stool,
MAX(CASE WHEN lo.lab_items_code = "3070" AND lo.abnormal_result = "N" THEN "ปกติ" 
WHEN lo.lab_items_code = "3070" AND lo.abnormal_result = "Y" THEN "ผิดปกติ" END) AS Color_stool_status,
      
MAX(CASE WHEN lo.lab_items_code = "3069" THEN lo.lab_order_result END) AS Character,
MAX(CASE WHEN lo.lab_items_code = "3069" AND lo.abnormal_result = "N" THEN "ปกติ" 
WHEN lo.lab_items_code = "3069" AND lo.abnormal_result = "Y" THEN "ผิดปกติ" END) AS Character_status,
      
MAX(CASE WHEN lo.lab_items_code = "3078" THEN lo.lab_order_result END) AS WBCstool,
MAX(CASE WHEN lo.lab_items_code = "3078" AND lo.abnormal_result = "N" THEN "ปกติ" 
WHEN lo.lab_items_code = "3078" AND lo.abnormal_result = "Y" THEN "ผิดปกติ" END) AS WBCstool_status,
      
MAX(CASE WHEN lo.lab_items_code = "3079" THEN lo.lab_order_result END) AS RBCstool,
MAX(CASE WHEN lo.lab_items_code = "3079" AND lo.abnormal_result = "N" THEN "ปกติ" 
WHEN lo.lab_items_code = "3079" AND lo.abnormal_result = "Y" THEN "ผิดปกติ" END) AS RBCstool_status,
      
MAX(CASE WHEN lo.lab_items_code = "3289" THEN lo.lab_order_result END) AS OtherStool,
MAX(CASE WHEN lo.lab_items_code = "3289" AND lo.abnormal_result = "N" THEN "ปกติ" 
WHEN lo.lab_items_code = "3289" AND lo.abnormal_result = "Y" THEN "ผิดปกติ" END) AS OtherStool_status,
      
MAX(CASE WHEN lo.lab_items_code = "3071" THEN lo.lab_order_result END) AS Occultblood,
MAX(CASE WHEN lo.lab_items_code = "3071" AND lo.abnormal_result = "N" THEN "ปกติ" 
WHEN lo.lab_items_code = "3071" AND lo.abnormal_result = "Y" THEN "ผิดปกติ" END) AS Occultblood_status,
      
MAX(CASE WHEN lo.lab_items_code = "43" THEN lo.lab_order_result END) AS Methamphetamine,
MAX(CASE WHEN lo.lab_items_code = "1" THEN lo.lab_order_result END) AS HBsAg,
MAX(CASE WHEN lo.lab_items_code = "3185" THEN lo.lab_order_result END) AS antiHCV,
MAX(CASE WHEN lo.lab_items_code = "3377" THEN lo.lab_order_result END) AS antiHAV
      
FROM ovst o
INNER JOIN ckup_ovst co ON co.vn = o.vn
LEFT OUTER JOIN patient p ON p.hn = o.hn
LEFT OUTER JOIN opdscreen os ON os.vn = o.vn
LEFT OUTER JOIN lab_head lh ON lh.vn = o.vn 
LEFT OUTER JOIN lab_order lo ON lo.lab_order_number = lh.lab_order_number 
LEFT OUTER JOIN vn_stat vn ON vn.vn = o.vn
LEFT OUTER JOIN opd_ill_history oh ON oh.hn = p.hn 
LEFT OUTER JOIN opd_allergy ON opd_allergy.hn = p.hn
LEFT OUTER JOIN ckup_scr cs ON cs.vn = o.vn
WHERE co.vstdate BETWEEN '2024-12-09' AND '2024-12-09'
GROUP BY o.vstdate, o.vn, p.pname, p.fname, p.lname, p.sex, vn.age_y, vn.age_m, vn.age_d, os.bps, os.bpd, os.pulse, os.bw, os.height, os.bmi, os.waist, oh.cc_persist_disease, 
cs.ckup_scr_drink, cs.ckup_scr_smoke, cs.ckup_scr_bpd, cs.ckup_scr_bps, cs.ckup_scr_pulse, cs.ckup_scr_weight, cs.ckup_scr_height, cs.ckup_scr_waist, cs.ckup_scr_bmi,os.smoking_type_id,os.drinking_type_id
ORDER BY o.vstdate 
