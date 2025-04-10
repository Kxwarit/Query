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

-----------------------------------------------------------------------------------------------------------------------------------------------------------------

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

-----------------------------------------------------------------------------------------------------------------------------------------------------------------

SELECT log.*
FROM officer_activity_log log
LEFT OUTER JOIN officer o ON o.officer_id = log.officer_id
LEFT OUTER JOIN doctor d ON d.code = o.officer_doctor_code  
WHERE log.officer_activity_log_date = '2025-02-01' AND log.officer_activity_log_datetime::time >= '08:30:00' AND log.officer_activity_log_datetime::time <= '16:00:00'
AND d.position_id = '1'
---
SELECT 
    log.officer_activity_log_id,
    d.code,
    d.name,
    log.officer_activity_log_datetime::date as dates,
    log.officer_activity_log_datetime::time as times,
    log.officer_activity_log_parent_kv,
    ROW_NUMBER() OVER (PARTITION BY log.officer_activity_log_datetime::date , d.name ORDER BY log.officer_activity_log_id ASC) AS rn_min,
    log.*
  FROM officer_activity_log log
  LEFT OUTER JOIN officer o ON o.officer_id = log.officer_id
  LEFT OUTER JOIN doctor d ON d.code = o.officer_doctor_code  
  WHERE log.officer_activity_log_date BETWEEN '2025-02-01' AND '2025-02-28' AND log.officer_activity_log_datetime::time >= '08:30:00' AND log.officer_activity_log_datetime::time <= '16:00:00'
  AND d.position_id = '1' AND log.officer_activity_log_parent_kv <> ''

