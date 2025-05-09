WITH drug_rank AS (
    SELECT 
        op.vn,
        op.icode,
        ROW_NUMBER() OVER (PARTITION BY op.vn ORDER BY op.icode) AS current_row,
        COUNT(op.icode) OVER (PARTITION BY op.vn) AS total_rows
    FROM opitemrece op
    INNER JOIN drugitems d ON d.icode = op.icode
    WHERE op.vn IN (SELECT o.vn FROM ovst o WHERE o.vstdate BETWEEN '2024-12-01' AND '2024-12-31')
)

SELECT 
    o.hn,
    p.cid AS PID,
    '11357' AS HCODE,
    CONCAT(TO_CHAR(o.vstdate + INTERVAL '543 years', 'YYMMDD'), LPAD(o.oqueue::TEXT, 4, '0')) AS PRESCRIPTION_NO,
    CONCAT(dr.current_row, '/', dr.total_rows) AS DRUG_LABEL_NO,
    op.qty AS DISPENSE_QTY,
    d.dosageform AS  DISPENSE_UNIT,
    du.code AS DRUG_USAGE, 
    '' AS DISPENSE_TIME,
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
CASE
    WHEN op.icode = '3004807' THEN ''
    ELSE (
        SELECT CASE
            WHEN du2.code = 'รับยาณลูกยาฟาร์มาซี' THEN 'D0712'
            WHEN du2.code = 'รับยาศูนย์ยาเภสัชกรกาญจนดิษฐ์' THEN 'D1247'
            WHEN du2.code = 'รับยาสีฟ้าเภสัช' THEN 'D3435'
            WHEN du2.code = 'รับยาร้านณลูกยา' THEN 'D0920'
            WHEN du2.code = 'รับยากาญจนดิษฐ์เภสัช' THEN 'D0917'
            WHEN du2.code = 'รับยาร้านหมอยาเภสัช' THEN 'D0919'
            WHEN du2.code = 'รับยาศูนย์ยาเภสัชกรตำบลกรูด' THEN 'D1245'
            WHEN du2.code = 'รับยาศูนย์ยาเภสัชกรท่าทอง' THEN 'D1246'
            ELSE NULL
        END
        FROM opitemrece op2
        INNER JOIN drugusage du2 ON du2.drugusage = op2.drugusage
        WHERE op2.vn = o.vn AND op2.icode = '3004807'
        LIMIT 1
    )
END AS DRUGSTORE,

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
    d.name AS DRUG_NAME
FROM ovst o
LEFT OUTER JOIN patient p ON p.hn = o.hn
LEFT OUTER JOIN opitemrece op ON op.vn = o.vn
LEFT OUTER JOIN vn_stat vn ON vn.vn = o.vn
LEFT JOIN drugitems d ON d.icode = op.icode 
INNER JOIN drugusage du ON du.drugusage = op.drugusage
LEFT JOIN drug_rank dr ON dr.vn = o.vn AND dr.icode = op.icode
WHERE o.vstdate BETWEEN '2024-12-01' AND '2024-12-31'
    AND EXISTS (SELECT 1 FROM opitemrece op2 JOIN nondrugitems nd ON nd.icode = op2.icode WHERE op2.vn = o.vn AND nd.icode = '3004807')
    AND op.icode != '3004807'  
GROUP BY
    o.hn,
    o.vn, 
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
    op.icode,
    o.oqueue,
    dr.current_row,
    dr.total_rows,
    op.rxdate;
