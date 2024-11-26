ChangeReportSQL('SELECT '
      + '  Count(CASE WHEN p.sex = "1" AND a.age_y <= 5 AND  THEN i.an END) AS tmale1, '
      + '  Count(CASE WHEN p.sex = "2" AND a.age_y <= 5 AND  THEN i.an END) AS nfemale1,'
        
      + '  Count(CASE WHEN p.sex = "1" AND a.age_y BETWEEN 6 AND 10 AS tmale2,'
      + '  Count(CASE WHEN p.sex = "2" AND a.age_y BETWEEN 6 AND 10 THEN i.an END) AS nfemale2,'
        
      + '  Count(CASE WHEN p.sex = "1" AND a.age_y >= 11 AND (a.age_y <= 15 AND a.age_d = 0)  THEN i.an END) AS tmale3,'
      + '  Count(CASE WHEN p.sex = "2" AND a.age_y >= 11 AND (a.age_y <= 15 AND a.age_d = 0)  THEN i.an END) AS nfemale3,'
        
      + '  Count(CASE WHEN p.sex = "1" AND (a.age_y >= 15 AND a.age_d > 0) AND a.age_y <= 25  THEN i.an END) AS tmale4,'
      + '  Count(CASE WHEN p.sex = "2" AND (a.age_y >= 15 AND a.age_d > 0) AND a.age_y <= 25  THEN i.an END) AS nfemale4,'
      
      + '  Count(CASE WHEN p.sex = "1" AND a.age_y BETWEEN 26 AND 35  THEN i.an END) AS tmale5,'
      + '  Count(CASE WHEN p.sex = "2" AND a.age_y BETWEEN 26 AND 35  THEN i.an END) AS nfemale5,'
      
      + '  Count(CASE WHEN p.sex = "1" AND a.age_y BETWEEN 36 AND 45  THEN i.an END) AS tmale6,'
      + '  Count(CASE WHEN p.sex = "2" AND a.age_y BETWEEN 36 AND 45  THEN i.an END) AS nfemale6,'
      
      + '  Count(CASE WHEN p.sex = "1" AND a.age_y BETWEEN 46 AND 55  THEN i.an END) AS tmale7,'
      + '  Count(CASE WHEN p.sex = "2" AND a.age_y BETWEEN 46 AND 55  THEN i.an END) AS nfemale7,'
        
      + '  Count(CASE WHEN p.sex = "1" AND a.age_y BETWEEN 56 AND 65  THEN i.an END) AS tmale8,'
      + '  Count(CASE WHEN p.sex = "2" AND a.age_y BETWEEN 56 AND 65  THEN i.an END) AS nfemale8,'
      
      + '  Count(CASE WHEN p.sex = "1" AND a.age_y BETWEEN 66 AND 75  THEN i.an END) AS tmale9,'
      + '  Count(CASE WHEN p.sex = "2" AND a.age_y BETWEEN 66 AND 75  THEN i.an END) AS nfemale9,'
      
      + '  Count(CASE WHEN p.sex = "1" AND a.age_y BETWEEN 76 AND 85  THEN i.an END) AS tmale10,'
      + '  Count(CASE WHEN p.sex = "2" AND a.age_y BETWEEN 76 AND 85  THEN i.an END) AS nfemale10,'
      
      + '  Count(CASE WHEN p.sex = "1" AND a.age_y BETWEEN 86 AND 95  THEN i.an END) AS tmale11,'
      + '  Count(CASE WHEN p.sex = "2" AND a.age_y BETWEEN 86 AND 95  THEN i.an END) AS nfemale11,'
      
      + '  Count(CASE WHEN p.sex = "1" AND a.age_y BETWEEN 96 AND 105  THEN i.an END) AS tmale12,'
      + '  Count(CASE WHEN p.sex = "2" AND a.age_y BETWEEN 96 AND 105  THEN i.an END) AS nfemale12,'
      
      + '  Count(CASE WHEN p.sex = "1" AND a.age_y BETWEEN 106 AND 115  THEN i.an END) AS tmale13,'
      + '  Count(CASE WHEN p.sex = "2" AND a.age_y BETWEEN 106 AND 115  THEN i.an END) AS nfemale13'