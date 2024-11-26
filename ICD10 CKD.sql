SELECT 
    o.vstdate, 
    p.hn, 
    concat(p.pname, p.fname, ' ', p.lname) AS patient_name, 
    lo.lab_order_result, 
    STRING_AGG(DISTINCT CASE 
        WHEN ovstdiag.icd10 BETWEEN 'N181' AND 'N185' THEN ovstdiag.icd10
        WHEN iptdiag.icd10 BETWEEN 'N181' AND 'N185' THEN iptdiag.icd10
        ELSE NULL 
    END, ', ') AS icd_code, 

    
    STRING_AGG(DISTINCT CASE 
        WHEN ovstdiag.icd10 BETWEEN 'N181' AND 'N185' THEN d1.name
        WHEN iptdiag.icd10 BETWEEN 'N181' AND 'N185' THEN d2.name
        ELSE NULL 
    END, ', ') AS doctor_name
FROM ovst o
INNER JOIN patient p ON p.hn = o.hn
INNER JOIN lab_head lh ON lh.vn = o.vn
INNER JOIN lab_order lo ON lo.lab_order_number = lh.lab_order_number
INNER JOIN lab_items li ON li.lab_items_code = lo.lab_items_code
LEFT JOIN ovstdiag ON ovstdiag.vn = o.vn
LEFT JOIN iptdiag ON iptdiag.an = o.an
LEFT JOIN doctor d1 ON d1.code = ovstdiag.doctor
LEFT JOIN doctor d2 ON d2.code = iptdiag.doctor
WHERE o.vstdate >= '2024-01-01'
  AND li.lab_items_code = '3424' 
  AND lo.lab_order_result <> '' 
  AND lo.lab_order_result ~ '^[0-9]+(\.[0-9]+)?$'
GROUP BY o.vstdate, p.hn, patient_name, lo.lab_order_result
ORDER BY doctor_name;
