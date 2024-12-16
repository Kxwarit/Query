SELECT *
FROM ovstdiag od
WHERE ((od.icd10 BETWEEN 'C00' AND 'C969') 
OR (od.icd10 BETWEEN 'D37' AND 'D489') 
OR (od.icd10 BETWEEN 'I60' AND 'I699') 
OR (od.icd10 BETWEEN 'B20' AND 'B249') 
OR (od.icd10 BETWEEN 'J440' AND 'J449') 
OR (od.icd10 BETWEEN 'I500' AND 'I509') 
OR (od.icd10 LIKE 'N185%') 
OR (od.icd10 LIKE 'K72%')
OR (od.icd10 LIKE 'K704%') 
OR (od.icd10 LIKE 'K717%') 
OR (od.icd10 LIKE 'R54%') )
AND ((od.icd10 LIKE 'Z515%')OR (od.icd10 LIKE 'Z718%')) 
LIMIT 100