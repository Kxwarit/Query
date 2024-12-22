SELECT 
    O.vn,
    '11357' AS HCODE,
    'โรงพยาบาลกาญจนดิษฐ์' AS HOSP,
    p.cid AS PATIENT_PID, 
    CONCAT(p.pname, p.fname, ' ', p.lname) AS patient_name,
    STRING_AGG(
        DISTINCT CASE 
            WHEN p.hometel <> '' AND p.hometel ~ '^[0-9-]+$' AND p.hometel !~ '^(.)\1*$' THEN p.hometel 
            WHEN p.mobile_phone_number <> '' AND p.mobile_phone_number ~ '^[0-9-]+$' AND p.mobile_phone_number !~ '^(.)\1*$' THEN p.mobile_phone_number 
            WHEN p.informtel <> '' AND p.informtel ~ '^[0-9-]+$' AND p.informtel !~ '^(.)\1*$' THEN p.informtel 
            ELSE NULL 
        END, ', '
    ) AS PATIENT_TEL,
    o.vstdate AS DATE_OF_TREATMENT,
    CASE 
        WHEN op.icode = '3004807' THEN REPLACE(du.code, 'รับยา', '')  -- แสดง REPLACE สำหรับ icode = '3004807'
        ELSE (
            SELECT REPLACE(du2.code, 'รับยา', '')  -- แสดง REPLACE สำหรับ icode = '3004807' จากบรรทัดอื่น ๆ
            FROM opitemrece op2
            INNER JOIN drugusage du2 ON du2.drugusage = op2.drugusage
            WHERE op2.vn = o.vn AND op2.icode = '3004807'
            LIMIT 1
        )
    END AS STATION,  -- ตรวจสอบค่าของ icode = '3004807'
    vn.pdx AS ICD10,
    d.name AS DRUG_NAME,
    du.code AS USAGE,
    op.qty,
    d.dosageform
FROM ovst o
LEFT OUTER JOIN patient p ON p.hn = o.hn
LEFT OUTER JOIN opitemrece op ON op.vn = o.vn
LEFT OUTER JOIN vn_stat vn ON vn.vn = o.vn
LEFT JOIN drugitems d ON d.icode = op.icode -- รายการยา
INNER JOIN drugusage du ON du.drugusage = op.drugusage
WHERE o.vstdate BETWEEN '2024-12-01' AND '2024-12-31'
    AND EXISTS (
        SELECT 1 
        FROM opitemrece op2
        JOIN nondrugitems nd ON nd.icode = op2.icode
        WHERE op2.vn = o.vn
          AND nd.icode = '3004807' -- ตรวจสอบว่ามีใน nondrugitems
    )
    AND o.hn = '0017504'
    AND op.icode != '3004807'  -- เพิ่มการกรองข้อมูล icode = '3004807' ออก
GROUP BY
    O.vn, 
    o.vstdate, 
    p.cid, 
    p.pname, 
    p.fname, 
    p.lname, 
    d.name, 
    du.code, 
    op.qty, 
    d.dosageform, 
    vn.pdx, 
    du.dosageform,
    op.icode;
-------
SELECT 

    p.cid AS PID,
    '11357' AS HCODE,
    '' AS  PRESCRIPTION_NO,
    o.vstdate AS PRESCRIPTION_DATE,
    p.fname AS FNAME,
    p.lname AS LNAME, 
    STRING_AGG(
        DISTINCT CASE 
            WHEN p.hometel <> '' AND p.hometel ~ '^[0-9-]+$' AND p.hometel !~ '^(.)\1*$' THEN p.hometel 
            WHEN p.mobile_phone_number <> '' AND p.mobile_phone_number ~ '^[0-9-]+$' AND p.mobile_phone_number !~ '^(.)\1*$' THEN p.mobile_phone_number 
            WHEN p.informtel <> '' AND p.informtel ~ '^[0-9-]+$' AND p.informtel !~ '^(.)\1*$' THEN p.informtel 
            ELSE NULL 
        END, ', '
    ) AS PATIENT_TEL,
    CASE WHEN p.sex = '1' THEN 'ชาย' WHEN p.sex = '2' THEN 'หญิง' END AS SEX,
    O.vn,
    CASE 
        WHEN op.icode = '3004807' THEN REPLACE(du.code, 'รับยา', '')  -- แสดง REPLACE สำหรับ icode = '3004807'
        ELSE (
            SELECT REPLACE(du2.code, 'รับยา', '')  -- แสดง REPLACE สำหรับ icode = '3004807' จากบรรทัดอื่น ๆ
            FROM opitemrece op2
            INNER JOIN drugusage du2 ON du2.drugusage = op2.drugusage
            WHERE op2.vn = o.vn AND op2.icode = '3004807'
            LIMIT 1
        )
    END AS STATION,  -- ตรวจสอบค่าของ icode = '3004807'
    vn.pdx AS ICD10,
    d.name AS DRUG_NAME,
    du.code AS USAGE,
    op.qty,
    d.dosageform
FROM ovst o
LEFT OUTER JOIN patient p ON p.hn = o.hn
LEFT OUTER JOIN opitemrece op ON op.vn = o.vn
LEFT OUTER JOIN vn_stat vn ON vn.vn = o.vn
LEFT JOIN drugitems d ON d.icode = op.icode 
INNER JOIN drugusage du ON du.drugusage = op.drugusage
WHERE o.vstdate BETWEEN '2024-12-01' AND '2024-12-31'
    AND EXISTS (
        SELECT 1 
        FROM opitemrece op2
        JOIN nondrugitems nd ON nd.icode = op2.icode
        WHERE op2.vn = o.vn
          AND nd.icode = '3004807' 
    )
    AND op.icode != '3004807'  
GROUP BY
    O.vn, 
    o.vstdate, 
    p.cid,
    p.sex, 
    p.pname, 
    p.fname, 
    p.lname, 
    d.name, 
    du.code, 
    op.qty, 
    d.dosageform, 
    vn.pdx, 
    du.dosageform,
    op.icode;
---------
SELECT 
    o.hn,
    p.cid AS PID,
    '11357' AS HCODE,
    '' AS  PRESCRIPTION_NO,
    o.vstdate AS PRESCRIPTION_DATE,
    p.fname AS FNAME,
    p.lname AS LNAME, 
    STRING_AGG(
        DISTINCT CASE 
            WHEN p.hometel <> '' AND p.hometel ~ '^[0-9-]+$' AND p.hometel !~ '^(.)\1*$' THEN p.hometel 
            WHEN p.mobile_phone_number <> '' AND p.mobile_phone_number ~ '^[0-9-]+$' AND p.mobile_phone_number !~ '^(.)\1*$' THEN p.mobile_phone_number 
            WHEN p.informtel <> '' AND p.informtel ~ '^[0-9-]+$' AND p.informtel !~ '^(.)\1*$' THEN p.informtel 
            ELSE NULL 
        END, ', '
    ) AS PATIENT_TEL,
    CASE WHEN p.sex = '1' THEN 'ชาย' WHEN p.sex = '2' THEN 'หญิง' END AS SEX,
    o.vn,
    (SELECT COUNT(op_prev.icode) + 1 
        FROM opitemrece op_prev 
        WHERE op_prev.icode = '3004807' 
        AND op_prev.vstdate < o.vstdate 
        AND op_prev.hn = o.hn
    ) AS REPEATE_NUM,
    'D1245' AS DRUGSTORE,
    CASE 
        WHEN op.icode = '3004807' THEN REPLACE(du.code, 'รับยา', '')  
        ELSE (
            SELECT REPLACE(du2.code, 'รับยา', '')  
            FROM opitemrece op2
            INNER JOIN drugusage du2 ON du2.drugusage = op2.drugusage
            WHERE op2.vn = o.vn AND op2.icode = '3004807'
            LIMIT 1
        )
    END AS STATION,  
    vn.pdx AS ICD10,
    d.name AS DRUG_NAME,
    du.code AS USAGE,
    op.qty,
    d.dosageform
FROM ovst o
LEFT OUTER JOIN patient p ON p.hn = o.hn
LEFT OUTER JOIN opitemrece op ON op.vn = o.vn
LEFT OUTER JOIN vn_stat vn ON vn.vn = o.vn
LEFT JOIN drugitems d ON d.icode = op.icode 
INNER JOIN drugusage du ON du.drugusage = op.drugusage
WHERE o.vstdate BETWEEN '2024-12-01' AND '2024-12-31'
    AND EXISTS (SELECT 1 FROM opitemrece op2 JOIN nondrugitems nd ON nd.icode = op2.icode WHERE op2.vn = o.vn AND nd.icode = '3004807')
    AND op.icode != '3004807'  
GROUP BY
    o.hn,
    O.vn, 
    o.vstdate, 
    p.cid,
    p.sex, 
    p.pname, 
    p.fname, 
    p.lname, 
    d.name, 
    du.code, 
    op.qty, 
    d.dosageform, 
    vn.pdx, 
    du.dosageform,
    op.icode;
