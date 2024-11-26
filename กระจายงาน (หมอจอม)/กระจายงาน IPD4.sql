SELECT 
  Count(CASE WHEN p.sex = '1' AND a.age_y <= 5 AND i.ipt_admit_type_id IN ('2') THEN i.an END) AS tmale1,
  Count(CASE WHEN p.sex = '2' AND a.age_y <= 5 AND i.ipt_admit_type_id IN ('2') THEN i.an END) AS tfemale1,
  Count(CASE WHEN p.sex = '1' AND a.age_y <= 5 AND i.ipt_admit_type_id IN ("1","3","4","5") THEN i.an END) AS nmale1,
  Count(CASE WHEN p.sex = '2' AND a.age_y <= 5 AND i.ipt_admit_type_id IN ("1","3","4","5") THEN i.an END) AS nfemale1,
  
  Count(CASE WHEN p.sex = '1' AND a.age_y BETWEEN 6 AND 10 AND i.ipt_admit_type_id IN ('2') THEN i.an END) AS tmale2,
  Count(CASE WHEN p.sex = '2' AND a.age_y BETWEEN 6 AND 10 AND i.ipt_admit_type_id IN ('2') THEN i.an END) AS tfemale2,
  Count(CASE WHEN p.sex = '1' AND a.age_y BETWEEN 6 AND 10 AND i.ipt_admit_type_id IN ("1","3","4","5") THEN i.an END) AS nmale2,
  Count(CASE WHEN p.sex = '2' AND a.age_y BETWEEN 6 AND 10 AND i.ipt_admit_type_id IN ("1","3","4","5") THEN i.an END) AS nfemale2,
  
  Count(CASE WHEN p.sex = '1' AND a.age_y >= 11 AND (a.age_y <= 15 AND a.age_d = 0) AND i.ipt_admit_type_id IN ('2') THEN i.an END) AS tmale3,
  Count(CASE WHEN p.sex = '2' AND a.age_y >= 11 AND (a.age_y <= 15 AND a.age_d = 0) AND i.ipt_admit_type_id IN ('2') THEN i.an END) AS tfemale3,
  Count(CASE WHEN p.sex = '1' AND a.age_y >= 11 AND (a.age_y <= 15 AND a.age_d = 0) AND i.ipt_admit_type_id IN ("1","3","4","5") THEN i.an END) AS nmale3,
  Count(CASE WHEN p.sex = '2' AND a.age_y >= 11 AND (a.age_y <= 15 AND a.age_d = 0) AND i.ipt_admit_type_id IN ("1","3","4","5") THEN i.an END) AS nfemale3,
  
  Count(CASE WHEN p.sex = '1' AND (a.age_y >= 15 AND a.age_d > 0) AND a.age_y <= 25 AND i.ipt_admit_type_id IN ('2') THEN i.an END) AS tmale4,
  Count(CASE WHEN p.sex = '2' AND (a.age_y >= 15 AND a.age_d > 0) AND a.age_y <= 25 AND i.ipt_admit_type_id IN ('2') THEN i.an END) AS tfemale4,
  Count(CASE WHEN p.sex = '1' AND (a.age_y >= 15 AND a.age_d > 0) AND a.age_y <= 25 AND i.ipt_admit_type_id IN ("1","3","4","5") THEN i.an END) AS nmale4,
  Count(CASE WHEN p.sex = '2' AND (a.age_y >= 15 AND a.age_d > 0) AND a.age_y <= 25 AND i.ipt_admit_type_id IN ("1","3","4","5") THEN i.an END) AS nfemale4,

  Count(CASE WHEN p.sex = '1' AND a.age_y BETWEEN 26 AND 35 AND i.ipt_admit_type_id IN ('2') THEN i.an END) AS tmale5,
  Count(CASE WHEN p.sex = '2' AND a.age_y BETWEEN 26 AND 35 AND i.ipt_admit_type_id IN ('2') THEN i.an END) AS tfemale5,
  Count(CASE WHEN p.sex = '1' AND a.age_y BETWEEN 26 AND 35 AND i.ipt_admit_type_id IN ("1","3","4","5") THEN i.an END) AS nmale5,
  Count(CASE WHEN p.sex = '2' AND a.age_y BETWEEN 26 AND 35 AND i.ipt_admit_type_id IN ("1","3","4","5") THEN i.an END) AS nfemale5,

  Count(CASE WHEN p.sex = '1' AND a.age_y BETWEEN 36 AND 45 AND i.ipt_admit_type_id IN ('2') THEN i.an END) AS tmale6,
  Count(CASE WHEN p.sex = '2' AND a.age_y BETWEEN 36 AND 45 AND i.ipt_admit_type_id IN ('2') THEN i.an END) AS tfemale6,
  Count(CASE WHEN p.sex = '1' AND a.age_y BETWEEN 36 AND 45 AND i.ipt_admit_type_id IN ("1","3","4","5") THEN i.an END) AS nmale6,
  Count(CASE WHEN p.sex = '2' AND a.age_y BETWEEN 36 AND 45 AND i.ipt_admit_type_id IN ("1","3","4","5") THEN i.an END) AS nfemale6,

  Count(CASE WHEN p.sex = '1' AND a.age_y BETWEEN 46 AND 55 AND i.ipt_admit_type_id IN ('2') THEN i.an END) AS tmale7,
  Count(CASE WHEN p.sex = '2' AND a.age_y BETWEEN 46 AND 55 AND i.ipt_admit_type_id IN ('2') THEN i.an END) AS tfemale7,
  Count(CASE WHEN p.sex = '1' AND a.age_y BETWEEN 46 AND 55 AND i.ipt_admit_type_id IN ("1","3","4","5") THEN i.an END) AS nmale7,
  Count(CASE WHEN p.sex = '2' AND a.age_y BETWEEN 46 AND 55 AND i.ipt_admit_type_id IN ("1","3","4","5") THEN i.an END) AS nfemale7,
  
  Count(CASE WHEN p.sex = '1' AND a.age_y BETWEEN 56 AND 65 AND i.ipt_admit_type_id IN ('2') THEN i.an END) AS tmale8,
  Count(CASE WHEN p.sex = '2' AND a.age_y BETWEEN 56 AND 65 AND i.ipt_admit_type_id IN ('2') THEN i.an END) AS tfemale8,
  Count(CASE WHEN p.sex = '1' AND a.age_y BETWEEN 56 AND 65 AND i.ipt_admit_type_id IN ("1","3","4","5") THEN i.an END) AS nmale8,
  Count(CASE WHEN p.sex = '2' AND a.age_y BETWEEN 56 AND 65 AND i.ipt_admit_type_id IN ("1","3","4","5") THEN i.an END) AS nfemale8,

  Count(CASE WHEN p.sex = '1' AND a.age_y BETWEEN 66 AND 75 AND i.ipt_admit_type_id IN ('2') THEN i.an END) AS tmale9,
  Count(CASE WHEN p.sex = '2' AND a.age_y BETWEEN 66 AND 75 AND i.ipt_admit_type_id IN ('2') THEN i.an END) AS tfemale9,
  Count(CASE WHEN p.sex = '1' AND a.age_y BETWEEN 66 AND 75 AND i.ipt_admit_type_id IN ("1","3","4","5") THEN i.an END) AS nmale9,
  Count(CASE WHEN p.sex = '2' AND a.age_y BETWEEN 66 AND 75 AND i.ipt_admit_type_id IN ("1","3","4","5") THEN i.an END) AS nfemale9,

  Count(CASE WHEN p.sex = '1' AND a.age_y BETWEEN 76 AND 85 AND i.ipt_admit_type_id IN ('2') THEN i.an END) AS tmale10,
  Count(CASE WHEN p.sex = '2' AND a.age_y BETWEEN 76 AND 85 AND i.ipt_admit_type_id IN ('2') THEN i.an END) AS tfemale10,
  Count(CASE WHEN p.sex = '1' AND a.age_y BETWEEN 76 AND 85 AND i.ipt_admit_type_id IN ("1","3","4","5") THEN i.an END) AS nmale10,
  Count(CASE WHEN p.sex = '2' AND a.age_y BETWEEN 76 AND 85 AND i.ipt_admit_type_id IN ("1","3","4","5") THEN i.an END) AS nfemale10,

  Count(CASE WHEN p.sex = '1' AND a.age_y BETWEEN 86 AND 95 AND i.ipt_admit_type_id IN ('2') THEN i.an END) AS tmale11,
  Count(CASE WHEN p.sex = '2' AND a.age_y BETWEEN 86 AND 95 AND i.ipt_admit_type_id IN ('2') THEN i.an END) AS tfemale11,
  Count(CASE WHEN p.sex = '1' AND a.age_y BETWEEN 86 AND 95 AND i.ipt_admit_type_id IN ("1","3","4","5") THEN i.an END) AS nmale11,
  Count(CASE WHEN p.sex = '2' AND a.age_y BETWEEN 86 AND 95 AND i.ipt_admit_type_id IN ("1","3","4","5") THEN i.an END) AS nfemale11,

  Count(CASE WHEN p.sex = '1' AND a.age_y BETWEEN 96 AND 105 AND i.ipt_admit_type_id IN ('2') THEN i.an END) AS tmale12,
  Count(CASE WHEN p.sex = '2' AND a.age_y BETWEEN 96 AND 105 AND i.ipt_admit_type_id IN ('2') THEN i.an END) AS tfemale12,
  Count(CASE WHEN p.sex = '1' AND a.age_y BETWEEN 96 AND 105 AND i.ipt_admit_type_id IN ("1","3","4","5") THEN i.an END) AS nmale12,
  Count(CASE WHEN p.sex = '2' AND a.age_y BETWEEN 96 AND 105 AND i.ipt_admit_type_id IN ("1","3","4","5") THEN i.an END) AS nfemale12,

  Count(CASE WHEN p.sex = '1' AND a.age_y BETWEEN 106 AND 115 AND i.ipt_admit_type_id IN ('2') THEN i.an END) AS tmale13,
  Count(CASE WHEN p.sex = '2' AND a.age_y BETWEEN 106 AND 115 AND i.ipt_admit_type_id IN ('2') THEN i.an END) AS tfemale13,
  Count(CASE WHEN p.sex = '1' AND a.age_y BETWEEN 106 AND 115 AND i.ipt_admit_type_id IN ("1","3","4","5") THEN i.an END) AS nmale13,
  Count(CASE WHEN p.sex = '2' AND a.age_y BETWEEN 106 AND 115 AND i.ipt_admit_type_id IN ("1","3","4","5") THEN i.an END) AS nfemale13

FROM ipt i
  LEFT OUTER JOIN patient p ON p.hn = i.hn
  LEFT OUTER JOIN an_stat a ON a.an = i.an
WHERE i.dchdate BETWEEN '2024-09-01' AND '2024-09-30' AND i.spclty = '02';


ChangeReportSQL('SELECT '
      + '  Count(CASE WHEN p.sex = "1" AND a.age_y <= 5 AND i.ipt_admit_type_id IN ("2") THEN i.an END) AS tmale1, '
      + '  Count(CASE WHEN p.sex = "2" AND a.age_y <= 5 AND i.ipt_admit_type_id IN ("2") THEN i.an END) AS tfemale1,'
      + '  Count(CASE WHEN p.sex = "1" AND a.age_y <= 5 AND i.ipt_admit_type_id IN ("1","3","4","5") THEN i.an END) AS nmale1,'
      + '  Count(CASE WHEN p.sex = "2" AND a.age_y <= 5 AND i.ipt_admit_type_id IN ("1","3","4","5") THEN i.an END) AS nfemale1,'
        
      + '  Count(CASE WHEN p.sex = "1" AND a.age_y BETWEEN 6 AND 10 AND i.ipt_admit_type_id IN ("2") THEN i.an END) AS tmale2,'
      + '  Count(CASE WHEN p.sex = "2" AND a.age_y BETWEEN 6 AND 10 AND i.ipt_admit_type_id IN ("2") THEN i.an END) AS tfemale2,'
      + '  Count(CASE WHEN p.sex = "1" AND a.age_y BETWEEN 6 AND 10 AND i.ipt_admit_type_id IN ("1","3","4","5") THEN i.an END) AS nmale2,'
      + '  Count(CASE WHEN p.sex = "2" AND a.age_y BETWEEN 6 AND 10 AND i.ipt_admit_type_id IN ("1","3","4","5") THEN i.an END) AS nfemale2,'
        
      + '  Count(CASE WHEN p.sex = "1" AND a.age_y >= 11 AND (a.age_y <= 15 AND a.age_d = 0) AND i.ipt_admit_type_id IN ("2") THEN i.an END) AS tmale3,'
      + '  Count(CASE WHEN p.sex = "2" AND a.age_y >= 11 AND (a.age_y <= 15 AND a.age_d = 0) AND i.ipt_admit_type_id IN ("2") THEN i.an END) AS tfemale3,'
      + '  Count(CASE WHEN p.sex = "1" AND a.age_y >= 11 AND (a.age_y <= 15 AND a.age_d = 0) AND i.ipt_admit_type_id IN ("1","3","4","5") THEN i.an END) AS nmale3,'
      + '  Count(CASE WHEN p.sex = "2" AND a.age_y >= 11 AND (a.age_y <= 15 AND a.age_d = 0) AND i.ipt_admit_type_id IN ("1","3","4","5") THEN i.an END) AS nfemale3,'
        
      + '  Count(CASE WHEN p.sex = "1" AND (a.age_y >= 15 AND a.age_d > 0) AND a.age_y <= 25 AND i.ipt_admit_type_id IN ("2") THEN i.an END) AS tmale4,'
      + '  Count(CASE WHEN p.sex = "2" AND (a.age_y >= 15 AND a.age_d > 0) AND a.age_y <= 25 AND i.ipt_admit_type_id IN ("2") THEN i.an END) AS tfemale4,'
      + '  Count(CASE WHEN p.sex = "1" AND (a.age_y >= 15 AND a.age_d > 0) AND a.age_y <= 25 AND i.ipt_admit_type_id IN ("1","3","4","5") THEN i.an END) AS nmale4,'
      + '  Count(CASE WHEN p.sex = "2" AND (a.age_y >= 15 AND a.age_d > 0) AND a.age_y <= 25 AND i.ipt_admit_type_id IN ("1","3","4","5") THEN i.an END) AS nfemale4,'
      
      + '  Count(CASE WHEN p.sex = "1" AND a.age_y BETWEEN 26 AND 35 AND i.ipt_admit_type_id IN ("2") THEN i.an END) AS tmale5,'
      + '  Count(CASE WHEN p.sex = "2" AND a.age_y BETWEEN 26 AND 35 AND i.ipt_admit_type_id IN ("2") THEN i.an END) AS tfemale5,'
      + '  Count(CASE WHEN p.sex = "1" AND a.age_y BETWEEN 26 AND 35 AND i.ipt_admit_type_id IN ("1","3","4","5") THEN i.an END) AS nmale5,'
      + '  Count(CASE WHEN p.sex = "2" AND a.age_y BETWEEN 26 AND 35 AND i.ipt_admit_type_id IN ("1","3","4","5") THEN i.an END) AS nfemale5,'
      
      + '  Count(CASE WHEN p.sex = "1" AND a.age_y BETWEEN 36 AND 45 AND i.ipt_admit_type_id IN ("2") THEN i.an END) AS tmale6,'
      + '  Count(CASE WHEN p.sex = "2" AND a.age_y BETWEEN 36 AND 45 AND i.ipt_admit_type_id IN ("2") THEN i.an END) AS tfemale6,'
      + '  Count(CASE WHEN p.sex = "1" AND a.age_y BETWEEN 36 AND 45 AND i.ipt_admit_type_id IN ("1","3","4","5") THEN i.an END) AS nmale6,'
      + '  Count(CASE WHEN p.sex = "2" AND a.age_y BETWEEN 36 AND 45 AND i.ipt_admit_type_id IN ("1","3","4","5") THEN i.an END) AS nfemale6,'
      
      + '  Count(CASE WHEN p.sex = "1" AND a.age_y BETWEEN 46 AND 55 AND i.ipt_admit_type_id IN ("2") THEN i.an END) AS tmale7,'
      + '  Count(CASE WHEN p.sex = "2" AND a.age_y BETWEEN 46 AND 55 AND i.ipt_admit_type_id IN ("2") THEN i.an END) AS tfemale7,'
      + '  Count(CASE WHEN p.sex = "1" AND a.age_y BETWEEN 46 AND 55 AND i.ipt_admit_type_id IN ("1","3","4","5") THEN i.an END) AS nmale7,'
      + '  Count(CASE WHEN p.sex = "2" AND a.age_y BETWEEN 46 AND 55 AND i.ipt_admit_type_id IN ("1","3","4","5") THEN i.an END) AS nfemale7,'
        
      + '  Count(CASE WHEN p.sex = "1" AND a.age_y BETWEEN 56 AND 65 AND i.ipt_admit_type_id IN ("2") THEN i.an END) AS tmale8,'
      + '  Count(CASE WHEN p.sex = "2" AND a.age_y BETWEEN 56 AND 65 AND i.ipt_admit_type_id IN ("2") THEN i.an END) AS tfemale8,'
      + '  Count(CASE WHEN p.sex = "1" AND a.age_y BETWEEN 56 AND 65 AND i.ipt_admit_type_id IN ("1","3","4","5") THEN i.an END) AS nmale8,'
      + '  Count(CASE WHEN p.sex = "2" AND a.age_y BETWEEN 56 AND 65 AND i.ipt_admit_type_id IN ("1","3","4","5") THEN i.an END) AS nfemale8,'
      
      + '  Count(CASE WHEN p.sex = "1" AND a.age_y BETWEEN 66 AND 75 AND i.ipt_admit_type_id IN ("2") THEN i.an END) AS tmale9,'
      + '  Count(CASE WHEN p.sex = "2" AND a.age_y BETWEEN 66 AND 75 AND i.ipt_admit_type_id IN ("2") THEN i.an END) AS tfemale9,'
      + '  Count(CASE WHEN p.sex = "1" AND a.age_y BETWEEN 66 AND 75 AND i.ipt_admit_type_id IN ("1","3","4","5") THEN i.an END) AS nmale9,'
      + '  Count(CASE WHEN p.sex = "2" AND a.age_y BETWEEN 66 AND 75 AND i.ipt_admit_type_id IN ("1","3","4","5") THEN i.an END) AS nfemale9,'
      
      + '  Count(CASE WHEN p.sex = "1" AND a.age_y BETWEEN 76 AND 85 AND i.ipt_admit_type_id IN ("2") THEN i.an END) AS tmale10,'
      + '  Count(CASE WHEN p.sex = "2" AND a.age_y BETWEEN 76 AND 85 AND i.ipt_admit_type_id IN ("2") THEN i.an END) AS tfemale10,'
      + '  Count(CASE WHEN p.sex = "1" AND a.age_y BETWEEN 76 AND 85 AND i.ipt_admit_type_id IN ("1","3","4","5") THEN i.an END) AS nmale10,'
      + '  Count(CASE WHEN p.sex = "2" AND a.age_y BETWEEN 76 AND 85 AND i.ipt_admit_type_id IN ("1","3","4","5") THEN i.an END) AS nfemale10,'
      
      + '  Count(CASE WHEN p.sex = "1" AND a.age_y BETWEEN 86 AND 95 AND i.ipt_admit_type_id IN ("2") THEN i.an END) AS tmale11,'
      + '  Count(CASE WHEN p.sex = "2" AND a.age_y BETWEEN 86 AND 95 AND i.ipt_admit_type_id IN ("2") THEN i.an END) AS tfemale11,'
      + '  Count(CASE WHEN p.sex = "1" AND a.age_y BETWEEN 86 AND 95 AND i.ipt_admit_type_id IN ("1","3","4","5") THEN i.an END) AS nmale11,'
      + '  Count(CASE WHEN p.sex = "2" AND a.age_y BETWEEN 86 AND 95 AND i.ipt_admit_type_id IN ("1","3","4","5") THEN i.an END) AS nfemale11,'
      
      + '  Count(CASE WHEN p.sex = "1" AND a.age_y BETWEEN 96 AND 105 AND i.ipt_admit_type_id IN ("2") THEN i.an END) AS tmale12,'
      + '  Count(CASE WHEN p.sex = "2" AND a.age_y BETWEEN 96 AND 105 AND i.ipt_admit_type_id IN ("2") THEN i.an END) AS tfemale12,'
      + '  Count(CASE WHEN p.sex = "1" AND a.age_y BETWEEN 96 AND 105 AND i.ipt_admit_type_id IN ("1","3","4","5") THEN i.an END) AS nmale12,'
      + '  Count(CASE WHEN p.sex = "2" AND a.age_y BETWEEN 96 AND 105 AND i.ipt_admit_type_id IN ("1","3","4","5") THEN i.an END) AS nfemale12,'
      
      + '  Count(CASE WHEN p.sex = "1" AND a.age_y BETWEEN 106 AND 115 AND i.ipt_admit_type_id IN ("2") THEN i.an END) AS tmale13,'
      + '  Count(CASE WHEN p.sex = "2" AND a.age_y BETWEEN 106 AND 115 AND i.ipt_admit_type_id IN ("2") THEN i.an END) AS tfemale13,'
      + '  Count(CASE WHEN p.sex = "1" AND a.age_y BETWEEN 106 AND 115 AND i.ipt_admit_type_id IN ("1","3","4","5") THEN i.an END) AS nmale13,'
      + '  Count(CASE WHEN p.sex = "2" AND a.age_y BETWEEN 106 AND 115 AND i.ipt_admit_type_id IN ("1","3","4","5") THEN i.an END) AS nfemale13'
      
      + ' FROM ipt i '
      + ' LEFT OUTER JOIN patient p ON p.hn = i.hn '
      + ' LEFT OUTER JOIN an_stat a ON a.an = i.an '
      + ' WHERE i.dchdate BETWEEN "'+ds1+'" AND "'+ds2+'" AND i.spclty = "02"');
