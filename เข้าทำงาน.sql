SELECT 
    service_begin_datetime::date,
    d.name,
    d.code, 

    COUNT(CASE WHEN service_begin_datetime::time >= "08:30:00" AND service_begin_datetime::time <= "09:10:00" THEN k.vn END)  as a,
    COUNT(CASE WHEN service_begin_datetime::time >  "09:10:00" AND service_begin_datetime::time <= "10:00:00" THEN k.vn END)  as b,
    COUNT(CASE WHEN service_begin_datetime::time > "10:00:00" AND service_begin_datetime::time <= "16:00:00" THEN k.vn END)  as c
    
FROM ovst_service_time k
LEFT OUTER JOIN ovst o ON o.vn = k.vn
LEFT OUTER JOIN opduser u ON u.loginname = k.staff
INNER JOIN doctor d ON d.code = u.doctorcode AND d.position_id = "1" 
WHERE ovst_service_time_type_code= "OPD-DOCTOR"
AND service_begin_datetime::date BETWEEN "2025-02-10" AND "2025-02-10"
--AND service_begin_datetime::time >= "07:00:00" AND service_begin_datetime::time <= "16:30:00"  
GROUP BY service_begin_datetime::date, d.code, d.name
ORDER BY d.code, service_begin_datetime::date



SELECT 
    service_begin_datetime::date,
    d.name,
    d.code, 

    COUNT(CASE WHEN service_begin_datetime::time >= "08:30:00" AND service_begin_datetime::time <= "09:10:00" THEN o.vn END)  as TIME1,
    COUNT(CASE WHEN service_begin_datetime::time >  "09:10:00" AND service_begin_datetime::time <= "10:00:00" THEN o.vn END)  as TIME2,
    COUNT(CASE WHEN service_begin_datetime::time > "10:00:00" AND service_begin_datetime::time <= "16:00:00" THEN o.vn END)  as TIME3
    
FROM ovst_service_time k
LEFT OUTER JOIN ovst o ON o.vn = k.vn
LEFT OUTER JOIN opduser u ON u.loginname = k.staff
INNER JOIN doctor d ON d.code = u.doctorcode AND d.position_id = "1" 
WHERE ovst_service_time_type_code= "OPD-DOCTOR"
AND service_begin_datetime::date BETWEEN "2025-02-10" AND "2025-03-10" 
AND service_begin_datetime::time >= "08:30:00" AND service_begin_datetime::time <= "16:00:00"  
GROUP BY service_begin_datetime::date, d.code, d.name
ORDER BY d.code, service_begin_datetime::date


-----------

WITH ranked_logs AS (
    SELECT 
        service_begin_datetime::date AS dates,
        service_begin_datetime::time AS times,
        k.ovst_service_time_id,
        d.code,
        d.name,
        o.vn,
        ROW_NUMBER() OVER (PARTITION BY service_begin_datetime::time, d.name ORDER BY k.ovst_service_time_id ASC) AS rn_min
        
    FROM ovst_service_time k
    LEFT OUTER JOIN ovst o ON o.vn = k.vn
    LEFT OUTER JOIN opduser u ON u.loginname = k.staff
    INNER JOIN doctor d ON d.code = u.doctorcode AND d.position_id = "1" 
    WHERE ovst_service_time_type_code= "OPD-DOCTOR"
    AND service_begin_datetime::date BETWEEN "2025-02-10" AND "2025-02-10" 
    AND service_begin_datetime::time >= "08:30:00" AND service_begin_datetime::time <= "16:00:00"  
    ORDER BY d.code, service_begin_datetime::date
)
SELECT 
    dates,
    code,
    name,
    COUNT(CASE WHEN rn_min = 1 AND times::time >= "08:30:00" AND times::time <= "09:10:00" THEN vn END)  as TIME1,
    COUNT(CASE WHEN rn_min = 1 AND times::time >  "09:10:00" AND times::time <= "10:00:00" THEN vn END)  as TIME2,
    COUNT(CASE WHEN rn_min = 1 AND times::time > "10:00:00" AND times::time <= "16:00:00" THEN vn END)  as TIME3
FROM ranked_logs
GROUP BY dates, name, code
ORDER BY code, dates
    
--------
WITH ranked_logs AS (
    SELECT 
        service_begin_datetime::date AS dates,
        service_begin_datetime::time AS times,
        k.ovst_service_time_id,
        d.code,
        d.name,
        ROW_NUMBER() OVER (PARTITION BY service_begin_datetime::date, d.name ORDER BY k.ovst_service_time_id ASC) AS rn_min
    FROM ovst_service_time k
    LEFT JOIN opduser u ON u.loginname = k.staff
    INNER JOIN doctor d ON d.code = u.doctorcode AND d.position_id = "1" 
    WHERE ovst_service_time_type_code = "OPD-DOCTOR"
    AND service_begin_datetime::date BETWEEN "2025-02-01" AND "2025-02-28"
    AND service_begin_datetime::time BETWEEN "08:30:00" AND "16:00:00"
)
SELECT 
    code,
    name,
    COUNT(DISTINCT CASE WHEN rn_min = 1 AND times BETWEEN "08:30:00" AND "09:10:00" THEN dates END) AS days_in_A,
    COUNT(DISTINCT CASE WHEN rn_min = 1 AND times BETWEEN "09:10:01" AND "10:00:00" THEN dates END) AS days_in_B,
    COUNT(DISTINCT CASE WHEN rn_min = 1 AND times BETWEEN "10:00:01" AND "16:00:00" THEN dates END) AS days_in_C
FROM ranked_logs
WHERE rn_min = 1  
GROUP BY code, name
ORDER BY code;


