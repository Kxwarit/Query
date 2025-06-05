'SELECT '
      + '    CASE  '
      + '     WHEN s.spclty IN ("03", "04") THEN "03+04"'
      + '     WHEN s.spclty IN ("17", "18") THEN "17+18"'
      + '     ELSE s.spclty '
      + '   END AS spclty_group,'
      + '   CASE '
      + '     WHEN s.spclty IN ("03", "04") THEN "สูติ-นรีเวชกรรม"'
      + '     WHEN s.spclty IN ("17", "18") THEN "เวชศาสตร์ครอบครัว"'
      + '     ELSE s.name'
      + '   END AS name_group,'
      + '   COUNT(o.vn) AS visit_count '
      + ' FROM spclty s '
      + ' LEFT JOIN ovst o '
      + '   ON ('
      + '     (CASE WHEN o.spclty IS NULL OR o.spclty = "" THEN "99" ELSE o.spclty END) = s.spclty'
      + '     AND o.vstdate BETWEEN "'+ds1+'" AND "'+ds2+'" '
      + '     AND o.an IS NULL'
      + '   )'
      + ' WHERE s.active_status = "Y"'
      + '   AND s.spclty <> "27"'
      + ' GROUP BY '
      + '   CASE '
      + '     WHEN s.spclty IN ("03", "04") THEN "03+04"'
      + '     WHEN s.spclty IN ("17", "18") THEN "17+18"'
      + '     ELSE s.spclty '
      + '   END,'
      + '   CASE '
      + '     WHEN s.spclty IN ("03", "04") THEN "สูติ-นรีเวชกรรม"'
      + '     WHEN s.spclty IN ("17", "18") THEN "เวชศาสตร์ครอบครัว"'
      + '     ELSE s.name'
      + '   END'
      
      + ' UNION ALL '
      + ' SELECT "999" AS spclty_group ,"อื่นๆ" as name_group, COALESCE(COUNT(o.vn), 0) AS visit_count '
      + ' FROM spclty s '
      + ' LEFT OUTER JOIN ovst o ON (CASE WHEN o.spclty IS NULL OR o.spclty = "" THEN "99" ELSE o.spclty END) = s.spclty '
      + ' AND o.vstdate BETWEEN "'+ds1+'" AND "'+ds2+'" AND o.an IS NULL '
      + ' WHERE s.active_status = "N" OR s.spclty = "27"'


SELECT s.spclty, s.name, COALESCE(COUNT(o.vn), 0) AS visit_count 
FROM spclty s 
LEFT OUTER JOIN ovst o ON (CASE WHEN o.spclty IS NULL OR o.spclty = "" THEN "99" ELSE o.spclty END) = s.spclty AND o.vstdate BETWEEN "2025-05-01" AND "2025-05-31" AND o.an IS NULL 
WHERE s.active_status = "N" OR s.spclty = "27"
GROUP BY s.spclty
HAVING COUNT(o.vn)> 0 