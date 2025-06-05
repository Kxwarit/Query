WITH ch AS(SELECT  idd.an, idd.audit_doctor_code, idd.doctor_code, idd.inspect_doctor_code, idd.diag_datetime, i.dchdate
FROM officer_activity_log log
LEFT OUTER JOIN officer o ON o.officer_id = log.officer_id
LEFT OUTER JOIN doctor d ON d.code = o.officer_doctor_code
INNER JOIN ipt_doctor_diag idd ON idd.ipt_doctor_diag_id::TEXT = log.officer_activity_log_key_value
LEFT OUTER JOIN ipt i ON i.an = idd.an
WHERE d.code = '0219' AND log.officer_activity_log_date BETWEEN "2025-04-01" AND "2025-04-30" AND i.dchdate BETWEEN "2025-04-01" AND "2025-04-30" --AND idd.audit_doctor_code = "0219"
)
SELECT DISTINCT an, dchdate, 
    STRING_AGG(DISTINCT audit_doctor_code,', ') AS audit_doctor_code, 
    STRING_AGG(DISTINCT doctor_code,', ') AS doctor_code, 
    STRING_AGG(DISTINCT inspect_doctor_code,', ') AS inspect_doctor_code
FROM ch
GROUP BY an, dchdate
ORDER BY dchdate
--------
SELECT i.an, i.dchdate, p.hn, concat(p.pname," ",p.fname," ",p.lname) as patient_name, 
(SELECT name FROM doctor WHERE code = i.dch_doctor) as dn,  
an_stat.income, idd.audit_doctor_code, idd.inspect_doctor_code
FROM ipt i 
INNER JOIN ipt_doctor_diag idd ON idd.an = i.an
INNER JOIN patient p ON p.hn = i.hn 
INNER JOIN an_stat ON an_stat.an = idd.an
WHERE i.dchdate BETWEEN "2025-04-01" AND "2025-04-30" AND (idd.audit_doctor_code = "0219" OR idd.inspect_doctor_code = "0219") AND an_stat.income >= 6000 
GROUP BY i.an, p.hn, i.dchdate, p.pname, p.fname, p.lname, an_stat.income, idd.audit_doctor_code, idd.inspect_doctor_code
ORDER BY i.dchdate, i.dchtime