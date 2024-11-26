SELECT 
    o.vstdate,
    o.vn, 
    CONCAT(p.pname, ' ', p.fname, ' ', p.lname) AS patient_name,
    CASE WHEN p.sex = '1' THEN 'ชาย' ELSE 'หญิง' END AS sex,
    CONCAT(vn.age_y, ' ปี ', vn.age_m, ' เดือน ', vn.age_d, ' วัน ') AS age,
    os.bps,  
    os.bpd,
    os.pulse,
    os.bw,
    os.height,
    os.bmi,
    os.waist,
    STRING_AGG(DISTINCT opd_allergy.agent, ', ') AS opd_allergy,
    oh.cc_persist_disease,
    os.smoking_type_id,
    os.drinking_type_id,
    CASE WHEN lo.lab_items_code = '1016' THEN lo.lab_order_result END AS WBC,
    CASE WHEN lo.lab_items_code = '1018' THEN lo.lab_order_result END AS Neutrophil,
    CASE WHEN lo.lab_items_code = '1019' THEN lo.lab_order_result END AS Lymphocyte,
    CASE WHEN lo.lab_items_code = '1020' THEN lo.lab_order_result END AS Monocyte,
    CASE WHEN lo.lab_items_code = '1021' THEN lo.lab_order_result END AS Eosinophil,
    CASE WHEN lo.lab_items_code = '1022' THEN lo.lab_order_result END AS Basophil,
    CASE WHEN lo.lab_items_code = '1005' THEN lo.lab_order_result END AS Platelet,
    CASE WHEN lo.lab_items_code = '1004' THEN lo.lab_order_result END AS RBC,
    CASE WHEN lo.lab_items_code = '1003' THEN lo.lab_order_result END AS HCT,
    CASE WHEN lo.lab_items_code = '1002' THEN lo.lab_order_result END AS Hb,
    CASE WHEN lo.lab_items_code = '1027' THEN lo.lab_order_result END AS MCV,
    CASE WHEN lo.lab_items_code = '1025' THEN lo.lab_order_result END AS MCH,
    CASE WHEN lo.lab_items_code = '1024' THEN lo.lab_order_result END AS MCHC,
    CASE WHEN lo.lab_items_code = '3001' THEN lo.lab_order_result END AS FBS,
    CASE WHEN lo.lab_items_code = '74' THEN lo.lab_order_result END AS BUN,
    CASE WHEN lo.lab_items_code = '3003' THEN lo.lab_order_result END AS Creatinine ,
    CASE WHEN lo.lab_items_code = '3424' THEN lo.lab_order_result END AS eGFR,
    CASE WHEN lo.lab_items_code = '3004' THEN lo.lab_order_result END AS URIC,
    CASE WHEN lo.lab_items_code = '3005' THEN lo.lab_order_result END AS Cholesterol,
    CASE WHEN lo.lab_items_code = '3006' THEN lo.lab_order_result END AS Triglyceride, 
    CASE WHEN lo.lab_items_code = '3007' THEN lo.lab_order_result END AS HDL,
    CASE WHEN lo.lab_items_code = '3008' THEN lo.lab_order_result END AS LDL,
    CASE WHEN lo.lab_items_code = '56' THEN lo.lab_order_result END AS Color,
    CASE WHEN lo.lab_items_code = '58' THEN lo.lab_order_result END AS Transparancy,
    CASE WHEN lo.lab_items_code = '66' THEN lo.lab_order_result END AS Spgr, 
    CASE WHEN lo.lab_items_code = '60' THEN lo.lab_order_result END AS pH, 
    CASE WHEN lo.lab_items_code = '68' THEN lo.lab_order_result END AS RBC,
    CASE WHEN lo.lab_items_code = '70' THEN lo.lab_order_result END AS WBC,
    CASE WHEN lo.lab_items_code = '3104' THEN lo.lab_order_result END AS Albumin, 
    CASE WHEN lo.lab_items_code = '64' THEN lo.lab_order_result END AS Glucose,
    CASE WHEN lo.lab_items_code = '3291' THEN lo.lab_order_result END AS Nitrite, 
    CASE WHEN lo.lab_items_code = '3186' THEN lo.lab_order_result END AS Ketone,
    CASE WHEN lo.lab_items_code = '3230' THEN lo.lab_order_result END AS Bilirubin,
    CASE WHEN lo.lab_items_code = '72' THEN lo.lab_order_result END AS Epithelial_Cell,
    CASE WHEN lo.lab_items_code = '3085' THEN lo.lab_order_result END AS Bacteria,
    CASE WHEN lo.lab_items_code = '43' THEN lo.lab_order_result END AS Methamphetmin     
FROM ovst o
LEFT OUTER JOIN patient p ON p.hn = o.hn
LEFT OUTER JOIN opdscreen os ON os.vn = o.vn
LEFT OUTER JOIN lab_head lh ON lh.vn = o.vn 
LEFT OUTER JOIN lab_order lo ON lo.lab_order_number = lh.lab_order_number 
LEFT OUTER JOIN lab_items li ON li.lab_items_code = lo.lab_items_code
LEFT OUTER JOIN vn_stat vn ON vn.vn = o.vn
LEFT OUTER JOIN opd_ill_history oh ON oh.hn = p.hn 
LEFT OUTER JOIN opd_allergy ON opd_allergy.hn = p.hn
WHERE o.vstdate BETWEEN '2024-09-01' AND '2024-09-30' AND o.vn = '670901053713'
AND lo.lab_items_code IN (
    '1016', '1018', '1019', '1020', '1021', '1022', 
    '1005', '1004', '1003', '1002', '1027', '1025', 
    '1024', '3001', '3003', '3424', '3005', '3007', 
    '66', '60', '68', '70', '64', '3186', '72',
    '74','3004','3006','3008','56','58','3104','3291','3230','3085','43'
)

GROUP BY 
    o.vstdate,
    o.vn,
    p.pname,
    p.fname,
    p.lname,
    p.sex,
    vn.age_y,
    vn.age_m,
    vn.age_d,
    os.bps,
    os.bpd,
    os.pulse,
    os.bw,
    os.height,
    os.bmi,
    os.waist,
    oh.cc_persist_disease,
    os.smoking_type_id,
    os.drinking_type_id,
    lo.lab_items_code,
    lo.lab_order_result
ORDER BY o.vstdate


