SELECT *
FROM officer_activity_log log
INNER JOIN doctor d ON d.code = log.officer_id 
WHERE d.code = '1292' 
limit 100

SELECT *
FROM officer_activity_log log
INNER JOIN doctor d ON d.code = CAST(log.officer_id AS VARCHAR)
WHERE d.code = '1283'
limit 100 

SELECT log.officer_activity_log_date, log.officer_activity_log_datetime
FROM officer_activity_log log
LEFT OUTER JOIN officer o ON o.officer_id = log.officer_id
LEFT OUTER JOIN doctor d ON d.code = o.officer_doctor_code
WHERE d.code = '1283' 
ORDER BY log.officer_activity_log_date

WITH ranked_logs AS (
    SELECT 
        log.officer_activity_log_id, 
        log.officer_activity_log_date,
        log.officer_activity_log_datetime, 
        log.officer_id,
        ROW_NUMBER() OVER (PARTITION BY log.officer_activity_log_date ORDER BY log.officer_activity_log_id) AS rn
    FROM officer_activity_log log
    INNER JOIN officer o ON o.officer_id = log.officer_id
    INNER JOIN doctor d ON d.code = o.officer_doctor_code
    WHERE d.code = '1283'
)
SELECT officer_activity_log_id, officer_activity_log_date, officer_activity_log_datetime, officer_id
FROM ranked_logs
WHERE rn = 1;

SELECT log.officer_activity_log_date, log.officer_activity_log_datetime
FROM officer_activity_log log
LEFT OUTER JOIN officer o ON o.officer_id = log.officer_id
LEFT OUTER JOIN doctor d ON d.code = o.officer_doctor_code
WHERE d.code = '1283' 
ORDER BY log.officer_activity_log_date

อยากรู้ว่าในแต่ละวันของ log.officer_activity_log_date นั้นมี log.officer_activity_log_id น้อยสุดและมากสุดอันไหนให้แต่ log.officer_activity_log_datetime ด้วย


WITH ranked_logs AS (
    SELECT 
        log.officer_activity_log_date,
        COALESCE(d.name, 'ไม่ระบุ') AS name,
        d.code as doctor, 
        log.officer_activity_log_id, 
        log.officer_activity_log_datetime,
        ROW_NUMBER() OVER (PARTITION BY log.officer_activity_log_date, d.name ORDER BY log.officer_activity_log_id ASC) AS rn_min,
        ROW_NUMBER() OVER (PARTITION BY log.officer_activity_log_date, d.name ORDER BY log.officer_activity_log_id DESC) AS rn_max,
    FROM officer_activity_log log
    INNER JOIN officer o ON o.officer_id = log.officer_id
    INNER JOIN doctor d ON d.code = o.officer_doctor_code AND d.position_id = '1'
    WHERE log.officer_activity_log_date BETWEEN '2025-01-01' AND '2025-01-31' 
)
SELECT 
    officer_activity_log_date,
    doctor,
    name,
    MAX(CASE WHEN rn_min = 1 THEN TO_CHAR(officer_activity_log_datetime, 'HH24:MI:SS') END) AS min_datetime,
    MAX(CASE WHEN rn_max = 1 THEN TO_CHAR(officer_activity_log_datetime, 'HH24:MI:SS') END) AS max_datetime,
    count(o.vn) as patient
FROM ranked_logs
LEFT JOIN ovst ov ON ov.doctor = d.code AND ov.vstdate = officer_activity_log_date
GROUP BY officer_activity_log_date, doctor, name
ORDER BY doctor;
-------
WITH ranked_logs AS (
    SELECT 
        os.sign_date, 
        d.code as doctor,
        COALESCE(d.name, 'ไม่ระบุ') AS name,
        os.sign_datetime,
        ROW_NUMBER() OVER (PARTITION BY os.sign_date, d.name ORDER BY os.ovst_doctor_sign_id ASC) AS rn_min
    FROM doctor d
    LEFT OUTER JOIN ovst_doctor_sign os ON os.doctor = d.code
    WHERE d.position_id = '1' AND os.sign_date = '2025-02-04' 
)
SELECT 
    sign_date,
    doctor,
    name,
    MAX(CASE WHEN rn_min = 1 THEN TO_CHAR(sign_datetime, 'HH24:MI:SS') END) AS min_datetime
    count(o.vn) as patient
FROM ranked_logs
GROUP BY sign_date, doctor, name
ORDER BY doctor;