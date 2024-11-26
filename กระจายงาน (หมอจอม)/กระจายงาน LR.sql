WITH min_bedmove AS (  
    SELECT im.an,
    Min(im.iptbedmove_id) AS min_iptbedmove_id,  
    im.movereason    
    FROM iptbedmove im 
    WHERE im.oward = '33'   
    GROUP BY im.an, im.movereason 
    )
    SELECT 
        CASE 
            WHEN an.age_y = 0 AND an.age_d BETWEEN 0 AND 7 THEN '0 - 7 วัน' 
            WHEN an.age_y BETWEEN 10 AND 19 THEN '10 - 19' 
            WHEN an.age_y BETWEEN 20 AND 29 THEN '20 - 29'  
            WHEN an.age_y BETWEEN 30 AND 39 THEN '30 - 39'  
            WHEN an.age_y BETWEEN 40 AND 50 THEN '40 - 50'  
        END AS age_group,     
        COUNT(CASE   
            WHEN (ip.preg_number = 0 OR ip.preg_number IS NULL)   
                AND an.age_y = 0 AND an.age_d BETWEEN 0 AND 7 THEN 1  
            ELSE NULL 
        END) AS เด็ก, 
        COUNT(CASE WHEN ip.preg_number = 1 THEN 1 END) AS case_1, 
        COUNT(CASE WHEN ip.preg_number = 2 THEN 1 END) AS case_2, 
        COUNT(CASE WHEN ip.preg_number = 3 THEN 1 END) AS case_3, 
        COUNT(CASE WHEN ip.preg_number = 4 THEN 1 END) AS case_4, 
        COUNT(CASE WHEN ip.preg_number = 5 THEN 1 END) AS case_5,  
        COUNT(CASE WHEN ip.preg_number = 6 THEN 1 END) AS case_6, 
        COUNT(CASE WHEN ip.preg_number = 7 THEN 1 END) AS case_7, 
        COUNT(CASE WHEN ip.preg_number = 8 THEN 1 END) AS case_8, 
        COUNT(CASE WHEN ip.preg_number = 9 THEN 1 END) AS case_9, 
        COUNT(CASE WHEN ip.preg_number = 10 THEN 1 END) AS case_10, 
        COUNT(CASE WHEN ip.preg_number = 11 THEN 1 END) AS case_11, 
        COUNT(CASE WHEN ip.preg_number = 12 THEN 1 END) AS case_12   
    FROM ipt i 
    LEFT OUTER JOIN ipt_pregnancy ip ON ip.an = i.an  
    LEFT OUTER JOIN min_bedmove mb ON mb.an = i.an
    LEFT OUTER JOIN iptbedmove im ON im.iptbedmove_id = mb.min_iptbedmove_id    
    LEFT OUTER JOIN bedno b ON b.bedno = im.obedno  
    LEFT OUTER JOIN an_stat an ON an.an = i.an       
    LEFT OUTER JOIN iptadm t ON t.an = i.an
    WHERE i.regdate BETWEEN '2023-10-01' AND '2024-09-30'
    AND ((an.age_y BETWEEN 10 AND 50) OR (an.age_y = 0 AND an.age_d BETWEEN 0 AND 7)) 
    AND ((im.oward = '33' AND b.roomno IN ('3301', '3302') AND mb.min_iptbedmove_id IS NOT NULL) OR (im.an IS NULL AND i.ward = '33' AND t.roomno IN ('3301', '3302')))
    GROUP BY age_group 
    ORDER BY age_group