SELECT  o.vn, o.vstdate, p.cid, p.hn, CONCAT(p.pname," ", p.fname," ", p.lname) AS patient_name, pt.name, 
    STRING_AGG(DISTINCT CASE 
        WHEN vn_stat.pdx LIKE "Z39%" THEN vn_stat.pdx 
        WHEN vn_stat.dx0 LIKE "Z39%" THEN vn_stat.dx0 
        WHEN vn_stat.dx1 LIKE "Z39%" THEN vn_stat.dx1 
        WHEN vn_stat.dx2 LIKE "Z39%" THEN vn_stat.dx2 
        WHEN vn_stat.dx3 LIKE "Z39%" THEN vn_stat.dx3 
        WHEN vn_stat.dx4 LIKE "Z39%" THEN vn_stat.dx4 
        WHEN vn_stat.dx5 LIKE "Z39%" THEN vn_stat.dx5 
        ELSE NULL  
    END, ", ") AS pdx, 
    STRING_AGG(DISTINCT nd.billcode, ",") AS billcode,
    SUM(CASE 
        WHEN op.icode = "3004730" THEN 150 
        WHEN op.icode = "3000110" AND NOT EXISTS( SELECT 1 FROM opitemrece op2  WHERE op2.vn = o.vn AND op2.icode = "3004730") THEN 150 
        WHEN op.icode = "3004731" THEN 135  
        WHEN op.icode = "1530016" AND NOT EXISTS( SELECT 1 FROM opitemrece op3  WHERE op3.vn = o.vn AND op3.icode = "3004731") THEN 135 
        ELSE 0 END ) AS cost, 
    vn_stat.income as costs
    FROM ovst o 
    LEFT JOIN patient p ON p.hn = o.hn 
    LEFT JOIN pttype pt ON pt.pttype = o.pttype 
    LEFT JOIN vn_stat ON vn_stat.vn = o.vn 
    LEFT JOIN opitemrece op ON op.vn = o.vn AND op.icode IN ("3004730","3000110") 
    LEFT JOIN nondrugitems nd ON nd.icode = op.icode
    WHERE 
    o.vstdate BETWEEN "2025-01-01" AND "2025-01-31" 
    AND pt.pttype = "F2" 
    AND (
        vn_stat.pdx LIKE "Z39%" 
        OR vn_stat.dx0 LIKE "Z39%" 
        OR vn_stat.dx1 LIKE "Z39%" 
        OR vn_stat.dx2 LIKE "Z39%" 
        OR vn_stat.dx3 LIKE "Z39%" 
        OR vn_stat.dx4 LIKE "Z39%" 
        OR vn_stat.dx5 LIKE "Z39%" 
        OR op.icode IN ("3004730","3000110")
    )
GROUP BY  o.vn, p.cid, p.hn, o.vstdate, o.vsttime,  p.pname, p.fname, p.lname, pt.name, vn_stat.pdx, vn_stat.income
ORDER BY o.vstdate;
