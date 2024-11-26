SELECT 
    COUNT(CASE WHEN od.icd10 = 'I64' THEN 1 END) AS Ischemic_stroke,
    COUNT(CASE WHEN od.icd10 = 'J189' THEN 1 END) AS Pneumonia,
    COUNT(CASE WHEN od.icd10 = 'I639' THEN 1 END) AS hemorrhage,
    COUNT(CASE WHEN od.icd10 = 'G409' THEN 1 END) AS Epilepsy
FROM 
    ovst o
LEFT OUTER JOIN 
    ovstdiag od ON od.vn = o.vn
WHERE 
    o.vstdate BETWEEN '2021-10-01' AND '2022-09-30' 
    AND o.an IS NULL;
------------
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
------------
SELECT 
    COUNT(CASE WHEN id.icd10 LIKE 'A09%' THEN 1 END) AS s1,
    COUNT(CASE WHEN id.icd10 BETWEEN 'J12' AND 'J18999' THEN 1 END) AS s2,
    COUNT(CASE WHEN id.icd10 LIKE 'D56%' THEN 1 END) AS s3,
    COUNT(CASE WHEN id.icd10 LIKE 'J44%' THEN 1 END) AS s4,
    COUNT(CASE WHEN id.icd10 LIKE 'I50%' THEN 1 END) AS s5,
    COUNT(CASE WHEN id.icd10 LIKE 'A97%' OR id.icd10 LIKE 'A91%' OR id.icd10 = 'A90' THEN 1 END) AS s6,
    COUNT(CASE WHEN id.icd10 BETWEEN 'I60' AND 'I6999' THEN 1 END) AS s7,
    COUNT(CASE WHEN id.icd10 LIKE 'J20%' OR id.icd10 = 'J40' THEN 1 END) AS s8,
    COUNT(CASE WHEN id.icd10 LIKE 'L03%' THEN 1 END) AS s9,
    COUNT(CASE WHEN id.icd10 LIKE 'N39%' THEN 1 END) AS s10
FROM 
    ipt i
LEFT OUTER JOIN 
    iptdiag id ON id.an = i.an
WHERE 
    i.dchdate BETWEEN '2021-10-01' AND '2022-09-30' 
---------------
SELECT DISTINCT hn,*
FROM death
WHERE death_date BETWEEN '2021-10-01' AND '2022-09-30' AND ( 
death_diag_icd10 LIKE 'J96%' OR 
death_diag_1 LIKE 'J96%' OR 
death_diag_2 LIKE 'J96%' OR 
death_diag_3 LIKE 'J96%' OR 
death_diag_4 LIKE 'J96%' OR 
death_diag_other LIKE 'J96%'   )
