SELECT 
    o.vstdate,
    p.hn,
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
    d.name AS DRUG_NAME,
    du.code AS USAGE,
    op.qty
FROM ovst o
LEFT OUTER JOIN patient p ON p.hn = o.hn
LEFT OUTER JOIN opitemrece op ON op.vn = o.vn
INNER JOIN drugitems d ON d.icode = op.icode
INNER JOIN drugusage du ON du.drugusage = op.drugusage
WHERE o.vstdate BETWEEN '2024-12-01' AND '2024-12-31'
    AND EXISTS (
        SELECT 1 
        FROM opitemrece op2
        JOIN nondrugitems nd ON nd.icode = op2.icode
        WHERE op2.vn = o.vn
          AND nd.icode = '3004807'
    )
GROUP BY o.vstdate, p.hn, p.cid, p.pname, p.fname, p.lname, d.name, du.code, op.qty
