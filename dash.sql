----1.1
CASE 
    WHEN MAX(buddha_year) > 2567 THEN  
        (SUM(admdate_plus) * 100) / (160 * (DATEDIFF('day', MIN(min_dchdate2), MAX(max_dchdate)) + 1))
    ELSE 
        (SUM(admdate_plus) * 100) / (120 * (DATEDIFF('day', MIN(min_dchdate2), MAX(max_dchdate)) + 1))
END
--- 1.2
CASE 
    WHEN MAX(buddha_year) > 2567 THEN  
        (SUM(admdate_plus)*100)/(160*(DATEDIFF('day',min(min_dchdate2), max(max_dchdate))+1))
    ELSE 
        (SUM(admdate_plus)*100)/(120*(DATEDIFF('day',min(min_dchdate2), max(max_dchdate))+1))
END
---1.3
CASE 
    WHEN MAX(buddha_year) > 2567 THEN  
        (SUM(admdate_plus)*100)/(160*max(diff_days))
    ELSE 
        (SUM(admdate_plus)*100)/(120*max(diff_days))
END
------
WITH os AS (
    SELECT  
        os.officer_name AS officer_name_1
    FROM officer os
    INNER JOIN officer_signature osig ON os.officer_id = osig.officer_id
), ds AS (
    SELECT 
        od.officer_name AS officer_name_2
    FROM officer od
    INNER JOIN doctor_signature d ON od.officer_doctor_code = d.doctor_code
)
SELECT *
FROM os
LEFT JOIN ds ON ds.officer_name_2 = os.officer_name_1
--------


