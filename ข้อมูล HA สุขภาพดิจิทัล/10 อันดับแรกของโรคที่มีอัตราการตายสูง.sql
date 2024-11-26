SELECT DISTINCT hn,*
FROM death
WHERE death_date BETWEEN '2021-10-01' AND '2022-09-30' AND ( 
death_diag_icd10 LIKE 'J96%' OR 
death_diag_1 LIKE 'J96%' OR 
death_diag_2 LIKE 'J96%' OR 
death_diag_3 LIKE 'J96%' OR 
death_diag_4 LIKE 'J96%' OR 
death_diag_other LIKE 'J96%'   )