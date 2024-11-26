SELECT 
    COUNT(CASE WHEN od.icd10 LIKE 'M62%' THEN 1 END) AS muscle_strain,
    COUNT(CASE WHEN od.icd10 = 'I10' OR od.icd10 LIKE 'I11%' OR od.icd10 LIKE 'I12%' OR od.icd10 LIKE 'I13%' OR od.icd10 LIKE 'I15%' THEN 1 END) AS essential_hypertension,
    COUNT(CASE WHEN od.icd10 = 'J00' OR od.icd10 LIKE 'J01%' OR od.icd10 LIKE 'J02%' OR od.icd10 LIKE 'J03%' OR od.icd10 LIKE 'J04%' OR od.icd10 LIKE 'J05%' OR od.icd10 LIKE 'J06%' THEN 1 END) AS upper_respiratory_tract_infection,
    COUNT(CASE WHEN od.icd10 LIKE 'E10%' OR od.icd10 LIKE 'E11%' OR od.icd10 LIKE 'E12%' OR od.icd10 LIKE 'E13%' OR od.icd10 LIKE 'E14%' THEN 1 END) AS type_2_diabetic_mellitus,
    COUNT(CASE WHEN od.icd10 LIKE 'R10%' OR od.icd10 = 'K30' THEN 1 END) AS dyspepsia,
    COUNT(CASE WHEN od.icd10 = 'M45' OR od.icd10 LIKE 'M46%' OR od.icd10 LIKE 'M47%' OR od.icd10 LIKE 'M48%' OR od.icd10 LIKE 'M49%' THEN 1 END) AS spinal_stenosis,
    COUNT(CASE WHEN od.icd10 LIKE 'B20%' OR od.icd10 LIKE 'B21%' OR od.icd10 LIKE 'B22%' OR od.icd10 LIKE 'B23%' OR od.icd10 = 'B24' THEN 1 END) AS hiv_infection,
    COUNT(CASE WHEN od.icd10 LIKE 'I63%' OR od.icd10 = 'I64' THEN 1 END) AS stroke,
    COUNT(CASE WHEN od.icd10 LIKE 'J20%' OR od.icd10 LIKE 'J40' THEN 1 END) AS acute_bronchitis,
    COUNT(CASE WHEN od.icd10 LIKE 'K02%' THEN 1 END) AS caries_of_dentine
FROM 
    ovst o
LEFT OUTER JOIN 
    ovstdiag od ON od.vn = o.vn
WHERE 
    o.vstdate BETWEEN '2021-10-01' AND '2022-09-30' 
    AND o.an IS NULL;