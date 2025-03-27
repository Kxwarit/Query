SELECT d.death_date, p.hn, p.cid, concat(p.pname, p.fname, ' ', p.lname) as patient_name, l.cc_persist_disease, d.last_update
FROM death d
LEFT OUTER JOIN opd_ill_history l ON l.hn = d.hn
LEFT OUTER JOIN patient p ON p.hn = d.hn
WHERE d.death_date BETWEEN '2024-10-01' AND '2025-03-31'
ORDER BY d.death_date
