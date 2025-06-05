WITH patients AS (
    SELECT p.*, od.icd10
    FROM ovst o
    LEFT JOIN ovstdiag od ON od.vn = o.vn 
    LEFT JOIN patient p ON p.hn = o.hn
    WHERE o.vstdate BETWEEN '2015-10-01' AND '2025-09-30' AND od.icd10 BETWEEN 'C500' AND 'C509'

    UNION ALL

    SELECT p.*, id.icd10
    FROM ovst o
    LEFT JOIN ipt i ON i.an = o.an OR i.vn = o.vn
    LEFT JOIN iptdiag id ON id.an = o.an
    LEFT JOIN patient p ON p.hn = o.hn
    WHERE i.dchdate BETWEEN '2015-10-01' AND '2025-09-30' AND id.icd10 BETWEEN 'C500' AND 'C509'
)
SELECT DISTINCT 
    ps.cid,
    ps.hn, 
    concat(ps.pname, ps.fname, ' ', ps.lname) as patient_name, 
    CASE WHEN ps.informaddr IS NOT NULL AND TRIM(ps.informaddr) <> '' THEN ps.informaddr 
         ELSE CONCAT_WS(' ', ps.addrpart, CASE WHEN ps.moopart IS NOT NULL AND TRIM(ps.moopart) <> '' THEN CONCAT('หมู่ ', ps.moopart)  END,  th.full_name)END AS addr,
    STRING_AGG(DISTINCT icd10,', ') as icd10
FROM patients ps 
LEFT JOIN thaiaddress th ON th.chwpart = ps.chwpart AND th.amppart = ps.amppart AND th.tmbpart = ps.tmbpart
GROUP BY ps.cid, ps.hn, ps.pname, ps.fname, ps.lname, ps.informaddr, ps.addrpart, ps.moopart, th.full_name
--------------
WITH patients AS (
    SELECT p.*, od.icd10
    FROM ovst o
    LEFT JOIN ovstdiag od ON od.vn = o.vn 
    LEFT JOIN patient p ON p.hn = o.hn
    WHERE o.vstdate BETWEEN '2015-10-01' AND '2025-09-30' AND od.icd10 BETWEEN 'C500' AND 'C509'

    UNION ALL

    SELECT p.*, id.icd10
    FROM ovst o
    LEFT JOIN ipt i ON i.an = o.an OR i.vn = o.vn
    LEFT JOIN iptdiag id ON id.an = o.an
    LEFT JOIN patient p ON p.hn = o.hn
    WHERE i.dchdate BETWEEN '2015-10-01' AND '2025-09-30' AND id.icd10 BETWEEN 'C500' AND 'C509'
)
SELECT 
    ROW_NUMBER() OVER (ORDER BY ps.cid) AS ลำดับ,
    ps.cid,
    ps.hn, 
    CONCAT(ps.pname, ps.fname, ' ', ps.lname) AS patient_name, 
    CASE 
        WHEN ps.informaddr IS NOT NULL AND TRIM(ps.informaddr) <> '' 
        THEN ps.informaddr 
        ELSE CONCAT_WS(' ', ps.addrpart, 
            CASE 
                WHEN ps.moopart IS NOT NULL AND TRIM(ps.moopart) <> '' 
                THEN CONCAT('หมู่ ', ps.moopart)  
            END,  
            th.full_name)
    END AS addr,
    STRING_AGG(DISTINCT icd10, ', ') AS icd10
FROM patients ps 
LEFT JOIN thaiaddress th 
    ON th.chwpart = ps.chwpart 
    AND th.amppart = ps.amppart 
    AND th.tmbpart = ps.tmbpart
GROUP BY 
    ps.cid, ps.hn, ps.pname, ps.fname, ps.lname, 
    ps.informaddr, ps.addrpart, ps.moopart, th.full_name
