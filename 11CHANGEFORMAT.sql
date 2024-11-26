SELECT 
          CASE 
              WHEN an.age_y BETWEEN 10 AND 19 THEN '10 - 19' 
              WHEN an.age_y BETWEEN 20 AND 29 THEN '20 - 29' 
              WHEN an.age_y BETWEEN 30 AND 39 THEN '30 - 39' 
              WHEN an.age_y BETWEEN 40 AND 50 THEN '40 - 50' 
          END AS age_group, 
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
      FROM person_anc_service pas 
          LEFT JOIN person_anc anc ON anc.person_anc_id = pas.person_anc_id 
          LEFT JOIN person ps ON ps.person_id = anc.person_id 
          LEFT JOIN ovst ov ON ov.vn = pas.vn 
          LEFT JOIN ipt i ON i.an = ov.an 
          LEFT JOIN an_stat an ON an.an = i.an 
          LEFT JOIN ward w ON w.ward = i.ward 
          LEFT JOIN iptadm t ON t.an = i.an 
          LEFT JOIN patient p ON p.hn = ov.hn 
    WHERE w.ward = '33' AND t.roomno IN ('3301', '3302') AND an.age_y BETWEEN 10 AND 50 
          AND i.regdate BETWEEN '2024-09-01' AND '2024-09-30' 
      GROUP BY age_group 
      ORDER BY age_group
      -------------
SELECT 
CASE 
    WHEN an.age_d BETWEEN 0 AND 7 THEN '0 - 7 วัน'
    WHEN an.age_y BETWEEN 10 AND 19 THEN '10 - 19' 
    WHEN an.age_y BETWEEN 20 AND 29 THEN '20 - 29' 
    WHEN an.age_y BETWEEN 30 AND 39 THEN '30 - 39' 
    WHEN an.age_y BETWEEN 40 AND 50 THEN '40 - 50' 
END AS age_group,
i.regdate,
i.dchdate,
i.an,
an.age_y,
an.age_m,
an.age_d,
ip.preg_number,
im.oward,
im.obedno,
im.nward,
im.nbedno,
b.bedno,
b.roomno
FROM ipt i
LEFT OUTER JOIN ipt_pregnancy ip ON ip.an = i.an
LEFT OUTER JOIN iptbedmove im ON im.an = i.an
LEFT OUTER JOIN bedno b ON b.bedno = im.obedno
LEFT OUTER JOIN an_stat an ON an.an = i.an  
WHERE i.regdate BETWEEN '2024-09-01' AND '2024-09-30' AND im.oward = '33' AND b.roomno IN ('3301','3302') AND im.movereason = 'รับใหม่'

---------------
SELECT 
CASE 
    WHEN an.age_y = 0 AND an.age_d BETWEEN 0 AND 7 THEN '0 - 7 วัน'
    WHEN an.age_y BETWEEN 10 AND 19 THEN '10 - 19' 
    WHEN an.age_y BETWEEN 20 AND 29 THEN '20 - 29' 
    WHEN an.age_y BETWEEN 30 AND 39 THEN '30 - 39' 
    WHEN an.age_y BETWEEN 40 AND 50 THEN '40 - 50' 
END AS age_group,
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
LEFT OUTER JOIN iptbedmove im ON im.an = i.an
LEFT OUTER JOIN bedno b ON b.bedno = im.obedno
LEFT OUTER JOIN an_stat an ON an.an = i.an  
WHERE i.regdate BETWEEN '2024-09-01' AND '2024-09-30' AND im.oward = '33' AND b.roomno IN ('3301','3302') AND im.movereason = 'รับใหม่'
GROUP BY age_group 
ORDER BY age_group