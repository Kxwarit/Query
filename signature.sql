WITH os AS (
    SELECT 
        os.officer_id AS dc1, 
        os.officer_name AS officer_name_1
    FROM officer_signature osig
    INNER JOIN officer os ON os.officer_id = osig.officer_id
), 
ds AS (
    SELECT
        od.officer_id AS dc2, 
        od.officer_name AS officer_name_2
    FROM doctor_signature d
    INNER JOIN officer od ON od.officer_doctor_code = d.doctor_code
)
SELECT 
    o.officer_id,
    o.officer_name, 
    CASE WHEN os.dc1 IS NOT NULL THEN 1 ELSE NULL END AS opduser, 
    CASE WHEN ds.dc2 IS NOT NULL THEN 1 ELSE NULL END AS doctor
FROM officer o
LEFT JOIN os ON os.dc1 = o.officer_id
LEFT JOIN ds ON ds.dc2 = o.officer_id
WHERE (os.dc1 IS NOT NULL OR ds.dc2 IS NOT NULL) -- กรองเฉพาะแถวที่ opduser หรือ doctor มีค่า
ORDER BY o.officer_id;
------





WITH os AS (
    SELECT 
        os.officer_id AS dc1, 
        os.officer_name AS officer_name_1
    FROM officer_signature osig
    INNER JOIN officer os ON os.officer_id = osig.officer_id
), 
ds AS (
    SELECT
        od.officer_id AS dc2, 
        od.officer_name AS officer_name_2
    FROM doctor_signature d
    INNER JOIN officer od ON od.officer_doctor_code = d.doctor_code
)
SELECT 
    o.officer_id,
    o.officer_login_name,
    o.officer_name, 
    CASE WHEN os.dc1 IS NOT NULL THEN 1 ELSE NULL END AS opduser, 
    CASE WHEN ds.dc2 IS NOT NULL THEN 1 ELSE NULL END AS doctor
FROM officer o
LEFT JOIN os ON os.dc1 = o.officer_id
LEFT JOIN ds ON ds.dc2 = o.officer_id
LEFT JOIN doctor d ON d.code = o.officer_doctor_code::TEXT
WHERE d.position_id = '1' 
--(os.dc1 IS NOT NULL OR ds.dc2 IS NOT NULL) 
ORDER BY o.officer_name,o.officer_id;