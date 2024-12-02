WITH age_groups AS (
    SELECT 
        '0-12 ปี' AS age_group
    UNION ALL
    SELECT '13-24 ปี'
    UNION ALL
    SELECT '25-29 ปี'
    UNION ALL
    SELECT '60 ปีขึ้นไป'
),
icd_groups AS (
    SELECT 'ซิฟิลิส' AS name, 'A539' AS icd10
    UNION ALL
    SELECT 'กามโรค', 'A64'
    UNION ALL
    SELECT 'หนองใน', 'A549'
    UNION ALL
    SELECT 'แผลริมอ่อน', 'A57'
    UNION ALL
    SELECT 'HIV', 'B20'
    UNION ALL
    SELECT 'หนองในเทียม', 'A562'
    UNION ALL
    SELECT 'หูด', 'A630'
    UNION ALL
    SELECT 'เริม', 'A601'
),
patient_counts AS (
    SELECT 
        CASE 
            WHEN od.icd10 IN ('A539') THEN 'ซิฟิลิส'
            WHEN od.icd10 IN ('A64') THEN 'กามโรค'
            WHEN od.icd10 IN ('A549') THEN 'หนองใน'
            WHEN od.icd10 IN ('A57') THEN 'แผลริมอ่อน'
            WHEN od.icd10 BETWEEN 'B20' AND 'B24' THEN 'HIV'
            WHEN od.icd10 IN ('A562', 'A560') THEN 'หนองในเทียม'
            WHEN od.icd10 IN ('A630') THEN 'หูด'
            WHEN od.icd10 IN ('A601', 'A600') THEN 'เริม'
        END AS name,
        CASE 
            WHEN EXTRACT(YEAR FROM AGE(o.vstdate, p.birthday)) BETWEEN 0 AND 12 THEN '0-12 ปี'
            WHEN EXTRACT(YEAR FROM AGE(o.vstdate, p.birthday)) BETWEEN 13 AND 24 THEN '13-24 ปี'
            WHEN EXTRACT(YEAR FROM AGE(o.vstdate, p.birthday)) BETWEEN 25 AND 59 THEN '25-29 ปี'
            WHEN EXTRACT(YEAR FROM AGE(o.vstdate, p.birthday)) >= 60 THEN '60 ปีขึ้นไป'
        END AS age,
        COUNT(DISTINCT CASE WHEN p.sex = '1' THEN o.hn END) AS ชาย_คน,
        COUNT(CASE WHEN p.sex = '1' THEN o.vn END) AS ชาย_ครั้ง,
        COUNT(DISTINCT CASE WHEN p.sex = '2' THEN o.hn END) AS หญิง_คน,
        COUNT(CASE WHEN p.sex = '2' THEN o.vn END) AS หญิง_ครั้ง
    FROM ovst o
    LEFT OUTER JOIN ovstdiag od ON od.vn = o.vn
    LEFT OUTER JOIN patient p ON p.hn = o.hn
    LEFT OUTER JOIN vn_stat vn ON vn.vn = o.vn
    WHERE o.vstdate BETWEEN '2023-10-01' AND '2024-09-30' 
    AND o.an IS NULL
    AND (od.icd10 IN ('A539','A64','A549','A57','A562','A560','A630','A601','A600') 
         OR od.icd10 BETWEEN 'B20' AND 'B24')
    GROUP BY name, age
)
SELECT 
    icd_groups.name,
    age_groups.age_group,
    COALESCE(pc.ชาย_คน, 0) AS ชาย_คน,
    COALESCE(pc.ชาย_ครั้ง, 0) AS ชาย_ครั้ง,
    COALESCE(pc.หญิง_คน, 0) AS หญิง_คน,
    COALESCE(pc.หญิง_ครั้ง, 0) AS หญิง_ครั้ง
FROM age_groups
CROSS JOIN icd_groups
LEFT JOIN patient_counts pc 
    ON pc.name = icd_groups.name 
    AND pc.age = age_groups.age_group
ORDER BY icd_groups.name, age_groups.age_group;
