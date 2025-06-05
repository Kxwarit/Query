---จำนวนผู้ป่วยจิตเวช Refer-in จาก รพช. มา รพ.สุราษฎร์ธานี (11357 refer to 10681)
SELECT count(reout.vn)
FROM referout reout 
WHERE reout.refer_date BETWEEN '2024-01-01' AND '2025-06-04' 
AND reout.pdx BETWEEN 'F00' AND 'F999'
AND reout.refer_hospcode LIKE '%10681%'

---จำนวนผู้ป่วยจิตเวช Refer-in จาก รพช. มา รพ.Node (11358 refer to 11357)
SELECT count(rein.vn) 
FROM referin rein 
WHERE rein.refer_date BETWEEN '2024-01-01' AND '2025-06-04'  
AND rein.icd10 BETWEEN 'F00' AND 'F999' 
AND rein.refer_hospcode LIKE '%11358%'

---ร้อยละของการ Refer-out ของ รพ.Node ( จำนวนผู้ป่วยจิตเวช 11357 Refer-Out / จำนวนผู้ป่วยจิตเวช 11357)

WITH reout AS (
    SELECT count(reout.vn) as visit_out
    FROM referout reout 
    WHERE reout.refer_date BETWEEN '2024-01-01' AND '2025-06-04' 
    AND reout.pdx BETWEEN 'F00' AND 'F999'
), visits AS(
    SELECT COUNT(DISTINCT o.vn) as visit_total
    FROM ovst o
    LEFT OUTER JOIN ipt i ON i.an = o.an OR i.vn = o.vn
    LEFT OUTER JOIN ovstdiag od ON od.vn = o.vn
    LEFT OUTER JOIN iptdiag id ON id.an = o.an
    WHERE ((i.an IS NULL AND o.vstdate BETWEEN '2024-01-01' AND '2025-06-04') OR (i.an IS NOT NULL AND i.dchdate BETWEEN '2024-01-01' AND '2025-06-04'))
    AND (od.icd10 BETWEEN 'F00' AND 'F999' OR id.icd10 BETWEEN 'F00' AND 'F999') 
)
SELECT (reout.visit_out::numeric / visits.visit_total::numeric) as percent
FROM reout, visits 

---ร้อยละของการ Refer-Back จาก รพ.สุราษฎร์ธานี ไปยัง รพช./Node  
---(จำนวนผู้ป่วยจิตเวช OPD Refer Back ไป รพช. , รพ. Node / จำนวนผู้ป่วยจิตเวช OPD จาก รพช. , รพ. Node ) --> ( referin OPD from 10681 /  จำนวนผู้ป่วยจิตเวช 11357 OPD)
WITH rein AS (
    SELECT count(rein.vn) as visit_in 
    FROM referin rein
    LEFT OUTER JOIN ovst o ON o.vn = rein.vn 
    WHERE rein.refer_date BETWEEN '2024-01-01' AND '2025-06-04'  
    AND rein.icd10 BETWEEN 'F00' AND 'F999' 
    AND rein.refer_hospcode LIKE '%10681%'
    AND o.an IS NULL
), visits AS(
    SELECT COUNT(DISTINCT o.vn) as visit_total
    FROM ovst o
    LEFT OUTER JOIN ipt i ON i.an = o.an OR i.vn = o.vn
    LEFT OUTER JOIN ovstdiag od ON od.vn = o.vn
    LEFT OUTER JOIN iptdiag id ON id.an = o.an
    WHERE ((i.an IS NULL AND o.vstdate BETWEEN '2024-01-01' AND '2025-06-04') OR (i.an IS NOT NULL AND i.dchdate BETWEEN '2024-01-01' AND '2025-06-04'))
    AND (od.icd10 BETWEEN 'F00' AND 'F999' OR id.icd10 BETWEEN 'F00' AND 'F999')
    AND o.an IS NULL 
)
SELECT (rein.visit_in::numeric / visits.visit_total::numeric) as percent
FROM rein, visits 

---(จำนวนผู้ป่วยจิตเวช IPD Refer Back ไป รพช. , รพ. Node / จำนวนผู้ป่วยจิตเวช IPD จาก รพช. , รพ. Node ) --> ( referin IPD from 10681 /  จำนวนผู้ป่วยจิตเวช 11357 IPD)
WITH rein AS (
    SELECT count(rein.vn) as visit_in 
    FROM referin rein
    LEFT OUTER JOIN ovst o ON o.vn = rein.vn 
    WHERE rein.refer_date BETWEEN '2024-01-01' AND '2025-06-04'  
    AND rein.icd10 BETWEEN 'F00' AND 'F999' 
    AND rein.refer_hospcode LIKE '%10681%'
    AND o.an IS NOT NULL
), visits AS(
    SELECT COUNT(DISTINCT o.vn) as visit_total
    FROM ovst o
    LEFT OUTER JOIN ipt i ON i.an = o.an OR i.vn = o.vn
    LEFT OUTER JOIN ovstdiag od ON od.vn = o.vn
    LEFT OUTER JOIN iptdiag id ON id.an = o.an
    WHERE ((i.an IS NULL AND o.vstdate BETWEEN '2024-01-01' AND '2025-06-04') OR (i.an IS NOT NULL AND i.dchdate BETWEEN '2024-01-01' AND '2025-06-04'))
    AND (od.icd10 BETWEEN 'F00' AND 'F999' OR id.icd10 BETWEEN 'F00' AND 'F999')
    AND o.an IS NOT NULL 
)
SELECT (rein.visit_in::numeric / visits.visit_total::numeric) as percent
FROM rein, visits 