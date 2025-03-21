--IPD Dischage by death แต่ใน DEATH ไม่ตาย
SELECT i.dchdate, p.hn, concat(p.pname,p.fname,' ',p.lname) as patient_name
FROM ipt i
LEFT OUTER JOIN patient p ON p.hn = i.hn
WHERE i.dchstts IN ('08','09') 
AND i.hn NOT IN (SELECT hn FROM death)
ORDER BY i.dchdate DESC

----------------------------------
--IPD Dischage by death แต่ใน clinicmember ไม่ตาย
SELECT i.dchdate, p.hn, concat(p.pname,p.fname,' ',p.lname) as patient_name, STRING_AGG(c.name, ', ') as clinic, d.death_date
FROM ipt i
LEFT OUTER JOIN patient p ON p.hn = i.hn
INNER JOIN clinicmember cm ON cm.hn = p.hn
LEFT OUTER JOIN clinic c ON c.clinic = cm.clinic
LEFT OUTER JOIN death d ON d.hn = p.hn 
WHERE i.dchstts IN ('08','09') 
AND i.hn NOT IN (SELECT hn FROM clinicmember WHERE clinic_member_status_id = '3')
GROUP BY i.dchdate, p.hn, p.pname, p.fname, p.lname, d.death_date
ORDER BY i.dchdate DESC

--------------------------------
--IPD Dischage by death โดยบันทึกการตายใน death แล้วว แต่ใน clinicmember ไม่ตาย
SELECT i.dchdate, p.hn, concat(p.pname,p.fname,' ',p.lname) as patient_name, STRING_AGG(c.name, ', ') as clinic, d.death_date
FROM ipt i
LEFT OUTER JOIN patient p ON p.hn = i.hn
INNER JOIN clinicmember cm ON cm.hn = p.hn
LEFT OUTER JOIN clinic c ON c.clinic = cm.clinic
LEFT OUTER JOIN death d ON d.hn = p.hn 
WHERE i.dchstts IN ('08','09') 
AND i.hn NOT IN (SELECT hn FROM clinicmember WHERE clinic_member_status_id = '3')
AND d.death_date IS NOT NULL 
GROUP BY i.dchdate, p.hn, p.pname, p.fname, p.lname, d.death_date
ORDER BY i.dchdate DESC

---------------------------------
--IPD Dischage by death โดยยังไม่บันทึกการตายใน death และใน clinicmember ไม่ตาย
SELECT i.dchdate, p.hn, concat(p.pname,p.fname,' ',p.lname) as patient_name, STRING_AGG(c.name, ', ') as clinic, d.death_date
FROM ipt i
LEFT OUTER JOIN patient p ON p.hn = i.hn
INNER JOIN clinicmember cm ON cm.hn = p.hn
LEFT OUTER JOIN clinic c ON c.clinic = cm.clinic
LEFT OUTER JOIN death d ON d.hn = p.hn 
WHERE i.dchstts IN ('08','09') 
AND i.hn NOT IN (SELECT hn FROM clinicmember WHERE clinic_member_status_id = '3')
AND d.death_date IS NULL 
GROUP BY i.dchdate, p.hn, p.pname, p.fname, p.lname, d.death_date
ORDER BY i.dchdate DESC
