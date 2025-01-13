SELECT o.vstdate, 
       p.hn, 
       CONCAT(p.pname, p.fname, ' ', p.lname) AS patient_name,
       os.cc,
       o.main_dep,
       STRING_AGG(CASE WHEN cm.clinic NOT IN ('077', '001') THEN c.name END, ', ') AS others
FROM ovst o
LEFT JOIN clinicmember cm ON cm.hn = o.hn 
LEFT OUTER JOIN patient p ON p.hn = cm.hn
LEFT OUTER JOIN opdscreen os ON os.vn = o.vn
LEFT OUTER JOIN clinic c ON c.clinic = cm.clinic
WHERE EXISTS (
      SELECT 1 
      FROM clinicmember cm2
      WHERE cm2.hn = cm.hn
        AND cm2.clinic = '077' 
  )
  AND o.vstdate = (
      SELECT MAX(o2.vstdate)
      FROM ovst o2
      WHERE o2.hn = o.hn
        AND o2.main_dep = '053'
  )
GROUP BY o.vstdate, p.hn, p.pname, p.fname, p.lname, os.cc, o.main_dep
ORDER BY vstdate;
---------
SELECT o.vstdate, 
       p.hn, 
       CONCAT(p.pname, p.fname, ' ', p.lname) AS patient_name,
       os.cc,
       STRING_AGG(CASE WHEN cm.clinic NOT IN ('077', '001') THEN c.name END, ', ') AS others
FROM ovst o
INNER JOIN clinicmember cm ON cm.hn = o.hn
LEFT OUTER JOIN patient p ON p.hn = cm.hn
LEFT OUTER JOIN opdscreen os ON os.vn = o.vn
LEFT OUTER JOIN clinic c ON c.clinic = cm.clinic
WHERE o.vstdate = (
    SELECT MAX(o2.vstdate)
    FROM ovst o2
    WHERE o2.hn = o.hn AND o2.main_dep = '053'
)
AND o.vn = (
    SELECT MAX(o2.vn)
    FROM ovst o2
    WHERE o2.hn = o.hn AND o2.main_dep = '053'
)
AND EXISTS (
    SELECT 1
    FROM clinicmember cm1
    WHERE cm1.hn = o.hn
      AND cm1.clinic = '077'
)
AND EXISTS (
    SELECT 1
    FROM clinicmember cm2
    WHERE cm2.hn = o.hn
      AND cm2.clinic = '001'
)
GROUP BY o.vstdate, p.hn, p.pname, p.fname, p.lname, os.cc
ORDER BY o.vstdate DESC;
-------
