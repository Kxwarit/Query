WITH latest_visits AS (
    SELECT 
        o.vstdate, 
        p.hn, 
        p.cid, 
        CONCAT(p.pname, p.fname, ' ', p.lname) AS patient_name,
        STRING_AGG(DISTINCT od.icd10, ',') AS icd10,
        ROW_NUMBER() OVER (PARTITION BY p.hn ORDER BY o.vstdate DESC) AS rn,
        os.bw,
        os.height,
        os.bmi,
        os.waist ,
        CONCAT(CAST(os.bps AS INT), '/', CAST(os.bpd AS INT)) AS pressure,
        p.birthday
    FROM ovst o
    INNER JOIN clinicmember cm ON cm.hn = o.hn
    LEFT OUTER JOIN ovstdiag od ON od.vn = o.vn
    LEFT OUTER JOIN opitemrece op ON op.vn = o.vn
    LEFT OUTER JOIN patient p ON p.hn = o.hn
    LEFT OUTER JOIN thaiaddress th ON th.chwpart = p.chwpart AND th.amppart = p.amppart AND th.tmbpart = '00'
    LEFT OUTER JOIN opdscreen os ON os.vn = o.vn
    WHERE o.vstdate BETWEEN '2024-10-01' AND '2025-09-30' AND o.vstdate <= CURRENT_DATE
        AND cm.clinic = '077'AND cm.other_chronic_text LIKE'%เบาหวาน%'
        AND o.main_dep IN ('155','053')
        AND NOT EXISTS (
            SELECT 1 
            FROM ovstdiag AS sub
            WHERE sub.vn = od.vn
            AND (sub.icd10 BETWEEN 'C00' AND 'C979' 
                OR sub.icd10 BETWEEN 'D00' AND 'D489'
                OR sub.icd10 BETWEEN 'N183' AND 'N185'
                OR sub.icd10 BETWEEN 'I120' AND 'I289'
                OR sub.icd10 BETWEEN 'I30' AND 'I529'
                OR sub.icd10 BETWEEN 'I60' AND 'I899'
                OR sub.icd10 BETWEEN 'I95' AND 'I999'
                OR sub.icd10 IN ('N189','D638','N083','E142'))
        )
        AND p.chwpart = '84' 
        AND p.amppart = '02'
        AND o.an IS NULL
    GROUP BY od.icd10, o.vstdate, p.hn, p.cid, p.pname, p.fname, p.lname, os.bmi, os.waist ,os.bps, os.bpd, os.bw, os.height,p.birthday

), latest_drug AS (
        SELECT DISTINCT ON (p.hn) 
        p.hn,
        o.vn,
        o.vstdate, 
        STRING_AGG(DISTINCT d.name, E',\n') AS drug,
        STRING_AGG(DISTINCT 
            CASE 
                WHEN o2.usage_shortlist LIKE '0    %' 
                THEN '>' || SUBSTRING(o2.usage_shortlist FROM 6) 
                ELSE o2.usage_shortlist 
            END, E',\n') AS drugusage,
        STRING_AGG(DISTINCT CONCAT(CAST(op.qty AS TEXT), ' ', d.units), E',\n') AS qty,
        os.bw,
        os.height,
        os.bmi,
        os.waist,
        CONCAT(CAST(os.bps AS INT), '/', CAST(os.bpd AS INT)) AS pressure
    FROM ovst o
    INNER JOIN (SELECT DISTINCT ON (hn) * FROM clinicmember WHERE clinic = '077' AND other_chronic_text LIKE'%เบาหวาน%' ORDER BY hn) cm ON cm.hn = o.hn
    LEFT JOIN ovstdiag od ON od.vn = o.vn
    LEFT JOIN (SELECT DISTINCT icode, vn, drugusage, qty, hos_guid FROM opitemrece) op ON op.vn = o.vn
    LEFT JOIN patient p ON p.hn = o.hn
    INNER JOIN drugitems d ON d.icode = op.icode
    LEFT JOIN drugusage du ON du.drugusage = op.drugusage
    LEFT OUTER JOIN opdscreen os ON os.vn = o.vn
    LEFT OUTER JOIN opi_dispense o2 ON o2.hos_guid = op.hos_guid  
    WHERE o.vstdate BETWEEN '2024-10-01' AND '2025-09-30'
        AND o.main_dep IN ('155','053')
        AND NOT EXISTS (
            SELECT 1 
            FROM ovstdiag AS sub
            WHERE sub.vn = od.vn
            AND (sub.icd10 BETWEEN 'C00' AND 'C979' 
                OR sub.icd10 BETWEEN 'D00' AND 'D489'
                OR sub.icd10 BETWEEN 'N183' AND 'N185'
                OR sub.icd10 BETWEEN 'I120' AND 'I289'
                OR sub.icd10 BETWEEN 'I30' AND 'I529'
                OR sub.icd10 BETWEEN 'I60' AND 'I899'
                OR sub.icd10 BETWEEN 'I95' AND 'I999'
                OR sub.icd10 IN ('N189','D638','N083','E142'))
        )
        AND p.chwpart = '84' 
        AND p.amppart = '02'
        AND o.an IS NULL
        AND o.vn IN (
            SELECT DISTINCT ON (p.hn) o.vn
            FROM ovst o
            INNER JOIN clinicmember cm ON cm.hn = o.hn
            LEFT JOIN ovstdiag od ON od.vn = o.vn
            LEFT JOIN patient p ON p.hn = o.hn
            LEFT JOIN lab_head lh ON lh.vn = o.vn
            LEFT JOIN lab_order lo ON lo.lab_order_number = lh.lab_order_number
            WHERE o.vstdate BETWEEN '2024-10-01' AND '2025-09-30' 
                AND p.chwpart = '84' 
                AND p.amppart = '02'
                AND o.an IS NULL
                AND lo.lab_items_code IN ('3005', '3007', '3008', '3006', '48', '3001', '3398')
            GROUP BY o.vstdate, p.hn, o.vn
            HAVING COUNT(DISTINCT lo.lab_items_code) = 7
            ORDER BY p.hn, o.vstdate
        )
    GROUP BY p.hn, o.vn, o.vstdate, os.bmi, os.waist, os.bps, os.bpd, os.bw, os.height
    ORDER BY p.hn, o.vstdate

), latest_lab AS (
    SELECT DISTINCT ON (p.hn)  
        o.vstdate as vstdate,
        p.hn,
        MAX(CASE WHEN lo.lab_items_code = '3005' THEN lo.lab_order_result ELSE '' END) AS Cholesterol,
        MAX(CASE WHEN lo.lab_items_code = '3007' THEN lo.lab_order_result ELSE '' END) AS hdl,
        MAX(CASE WHEN lo.lab_items_code = '3008' THEN lo.lab_order_result ELSE '' END) AS ldl,
        MAX(CASE WHEN lo.lab_items_code = '3006' THEN lo.lab_order_result ELSE '' END) AS TRIGLYCERIDE,
        MAX(CASE WHEN lo.lab_items_code = '48' THEN lo.lab_order_result ELSE '' END) AS hb1ac,
        MAX(CASE WHEN lo.lab_items_code = '3001' THEN lo.lab_order_result ELSE '' END) AS fbs,
        MAX(CASE WHEN lo.lab_items_code = '3398' THEN lo.lab_order_result ELSE '' END) AS urine
    FROM ovst o
    INNER JOIN clinicmember cm ON cm.hn = o.hn
    LEFT JOIN ovstdiag od ON od.vn = o.vn
    LEFT JOIN patient p ON p.hn = o.hn
    LEFT JOIN lab_head lh ON lh.vn = o.vn
    LEFT JOIN lab_order lo ON lo.lab_order_number = lh.lab_order_number
    LEFT OUTER JOIN opdscreen os ON os.vn = o.vn
    WHERE o.vstdate BETWEEN '2024-10-01' AND '2025-09-30' 
        AND cm.clinic = '077'AND cm.other_chronic_text LIKE'%เบาหวาน%'
        AND o.main_dep IN ('155','053')
        AND NOT EXISTS (
            SELECT 1 
            FROM ovstdiag AS sub
            WHERE sub.vn = od.vn
            AND (sub.icd10 BETWEEN 'C00' AND 'C979' 
                OR sub.icd10 BETWEEN 'D00' AND 'D489'
                OR sub.icd10 BETWEEN 'N183' AND 'N185'
                OR sub.icd10 BETWEEN 'I120' AND 'I289'
                OR sub.icd10 BETWEEN 'I30' AND 'I529'
                OR sub.icd10 BETWEEN 'I60' AND 'I899'
                OR sub.icd10 BETWEEN 'I95' AND 'I999'
                OR sub.icd10 IN ('N189','D638','N083','E142'))
        )
        AND p.chwpart = '84' 
        AND p.amppart = '02'
        AND o.an IS NULL
        AND lo.lab_items_code IN ('3005', '3007', '3008', '3006', '48', '3001', '3398')
        
        
    GROUP BY o.vstdate, p.hn
    HAVING COUNT(DISTINCT lo.lab_items_code) = 7
    ORDER BY p.hn, o.vstdate 

), prev_drug AS (
        SELECT DISTINCT ON (p.hn) 
        p.hn,
        o.vn,
        o.vstdate, 
        STRING_AGG(DISTINCT d.name, E',\n') AS drug,
        STRING_AGG(DISTINCT 
            CASE 
                WHEN o2.usage_shortlist LIKE '0    %' 
                THEN '>' || SUBSTRING(o2.usage_shortlist FROM 6) 
                ELSE o2.usage_shortlist 
            END, E',\n') AS drugusage,
        STRING_AGG(DISTINCT CONCAT(CAST(op.qty AS TEXT), ' ', d.units), E',\n') AS qty,
        os.bw,
        os.height,
        os.bmi,
        os.waist,
        CONCAT(CAST(os.bps AS INT), '/', CAST(os.bpd AS INT)) AS pressure
    FROM ovst o
    INNER JOIN (SELECT DISTINCT ON (hn) * FROM clinicmember WHERE clinic = '077' AND other_chronic_text LIKE'%เบาหวาน%' ORDER BY hn) cm ON cm.hn = o.hn
    LEFT JOIN ovstdiag od ON od.vn = o.vn
    LEFT JOIN (SELECT DISTINCT icode, vn, drugusage, qty, hos_guid FROM opitemrece) op ON op.vn = o.vn
    LEFT JOIN patient p ON p.hn = o.hn
    INNER JOIN drugitems d ON d.icode = op.icode
    LEFT JOIN drugusage du ON du.drugusage = op.drugusage
    LEFT OUTER JOIN opdscreen os ON os.vn = o.vn
    LEFT OUTER JOIN opi_dispense o2 ON o2.hos_guid = op.hos_guid  
    WHERE o.vstdate BETWEEN '2023-10-01' AND '2024-09-30'
        AND o.main_dep IN ('155','053')
        AND NOT EXISTS (
            SELECT 1 
            FROM ovstdiag AS sub
            WHERE sub.vn = od.vn
            AND (sub.icd10 BETWEEN 'C00' AND 'C979' 
                OR sub.icd10 BETWEEN 'D00' AND 'D489'
                OR sub.icd10 BETWEEN 'N183' AND 'N185'
                OR sub.icd10 BETWEEN 'I120' AND 'I289'
                OR sub.icd10 BETWEEN 'I30' AND 'I529'
                OR sub.icd10 BETWEEN 'I60' AND 'I899'
                OR sub.icd10 BETWEEN 'I95' AND 'I999'
                OR sub.icd10 IN ('N189','D638','N083','E142'))
        )
        AND p.chwpart = '84' 
        AND p.amppart = '02'
        AND o.an IS NULL
        AND o.vn IN (
            SELECT DISTINCT ON (p.hn) o.vn
            FROM ovst o
            INNER JOIN clinicmember cm ON cm.hn = o.hn
            LEFT JOIN ovstdiag od ON od.vn = o.vn
            LEFT JOIN patient p ON p.hn = o.hn
            LEFT JOIN lab_head lh ON lh.vn = o.vn
            LEFT JOIN lab_order lo ON lo.lab_order_number = lh.lab_order_number
            WHERE o.vstdate BETWEEN '2023-10-01' AND '2024-09-30' 
                AND p.chwpart = '84' 
                AND p.amppart = '02'
                AND o.an IS NULL
                AND lo.lab_items_code IN ('3005', '3007', '3008', '3006', '48', '3001', '3398')
            GROUP BY o.vstdate, p.hn, o.vn
            HAVING COUNT(DISTINCT lo.lab_items_code) = 7
            ORDER BY p.hn, o.vstdate
        )
    GROUP BY p.hn, o.vn, o.vstdate, os.bmi, os.waist, os.bps, os.bpd, os.bw, os.height
    ORDER BY p.hn, o.vstdate
), prev_lab AS (
    SELECT DISTINCT ON (p.hn) 
        o.vstdate as vstdate,
        p.hn,
        MAX(CASE WHEN lo.lab_items_code = '3005' THEN lo.lab_order_result ELSE '' END) AS Cholesterol,
        MAX(CASE WHEN lo.lab_items_code = '3007' THEN lo.lab_order_result ELSE '' END) AS hdl,
        MAX(CASE WHEN lo.lab_items_code = '3008' THEN lo.lab_order_result ELSE '' END) AS ldl,
        MAX(CASE WHEN lo.lab_items_code = '3006' THEN lo.lab_order_result ELSE '' END) AS TRIGLYCERIDE,
        MAX(CASE WHEN lo.lab_items_code = '48' THEN lo.lab_order_result ELSE '' END) AS hb1ac,
        MAX(CASE WHEN lo.lab_items_code = '3001' THEN lo.lab_order_result ELSE '' END) AS fbs,
        MAX(CASE WHEN lo.lab_items_code = '3398' THEN lo.lab_order_result ELSE '' END) AS urine
    FROM ovst o
    INNER JOIN clinicmember cm ON cm.hn = o.hn
    LEFT JOIN ovstdiag od ON od.vn = o.vn
    LEFT JOIN patient p ON p.hn = o.hn
    LEFT JOIN lab_head lh ON lh.vn = o.vn
    LEFT JOIN lab_order lo ON lo.lab_order_number = lh.lab_order_number
    WHERE o.vstdate BETWEEN '2023-10-01' AND '2024-09-30'
        AND cm.clinic = '077'AND cm.other_chronic_text LIKE'%เบาหวาน%'
        AND o.main_dep IN ('155','053')
        AND NOT EXISTS (
                SELECT 1 
                FROM ovstdiag AS sub
                WHERE sub.vn = od.vn
                AND (sub.icd10 BETWEEN 'C00' AND 'C979' 
                    OR sub.icd10 BETWEEN 'D00' AND 'D489'
                    OR sub.icd10 BETWEEN 'N183' AND 'N185'
                    OR sub.icd10 BETWEEN 'I120' AND 'I289'
                    OR sub.icd10 BETWEEN 'I30' AND 'I529'
                    OR sub.icd10 BETWEEN 'I60' AND 'I899'
                    OR sub.icd10 BETWEEN 'I95' AND 'I999'
                    OR sub.icd10 IN ('N189','D638','N083','E142'))
            )
        AND p.chwpart = '84' 
        AND p.amppart = '02'
        AND o.an IS NULL
        AND lo.lab_items_code IN ('3005', '3007', '3008', '3006', '48', '3001', '3398')
        
        
    GROUP BY o.vstdate, p.hn
    HAVING COUNT(DISTINCT lo.lab_items_code) = 7
    ORDER BY p.hn, o.vstdate 

)
SELECT  TO_CHAR(lv.vstdate + INTERVAL '543 years', 'DD/MM/YYYY') AS วันที่รับบริการล่าสุด,
        lv.hn, 
        lv.cid, 
        lv.patient_name AS ชื่อนามสกุล,
         EXTRACT(YEAR FROM AGE(lv.vstdate, lv.birthday)) AS อายุ,
        lv.icd10,
        lv.bw,
        lv.height,
        lv.bmi,
        lv.waist,
        CASE WHEN lv.pressure = '/' THEN NULL ELSE lv.pressure END AS pressure,

        pd.bw as bw_67,
        pd.height as height_67,
        pd.bmi as bmi_67,
        pd.waist as waist_67,
        CASE WHEN pd.pressure = '/' THEN NULL ELSE pd.pressure END AS pressure_67,
        
        TO_CHAR(pd.vstdate + INTERVAL '543 years', 'DD/MM/YYYY') AS วันที่รับยา_67,
        pd.drug AS รายการยา_67,
        pd.qty as ปริมาณยา_67,
        pd.drugusage as วิธีการใช้ยา_67,
        
        TO_CHAR(pl.vstdate + INTERVAL '543 years', 'DD/MM/YYYY') AS วันที่ตรวจแลป_67,
        pl.Cholesterol as Cholesterol_67,
        pl.hdl as hdl_67,
        pl.ldl as ldl_67,
        pl.TRIGLYCERIDE as TRIGLYCERIDE_67,
        pl.hb1ac as hb1ac_67,
        pl.fbs as fbs_67,
        pl.urine as urine_67,

        ld.bw as bw_68,
        ld.height as height_68,
        ld.bmi as bmi_68,
        ld.waist as waist_68,
        CASE WHEN ld.pressure = '/' THEN NULL ELSE ld.pressure END AS pressure_68,

        TO_CHAR(ld.vstdate + INTERVAL '543 years', 'DD/MM/YYYY') AS วันที่รับยา_68,
        ld.drug AS รายการยา_68,
        ld.qty as ปริมาณยา_68,
        ld.drugusage as วิธีการใช้ยา_68,
        
        TO_CHAR(ll.vstdate + INTERVAL '543 years', 'DD/MM/YYYY') AS วันที่ตรวจแลป_68,
        ll.Cholesterol as Cholesterol_68,
        ll.hdl as hdl_68,
        ll.ldl as ldl_68,
        ll.TRIGLYCERIDE as TRIGLYCERIDE_68,
        ll.hb1ac as hb1ac_68,
        ll.fbs as fbs_68,
        ll.urine as urine_68
FROM latest_visits lv
LEFT JOIN latest_lab ll ON ll.hn = lv.hn 
LEFT JOIN prev_lab pl ON pl.hn = lv.hn 
LEFT JOIN latest_drug ld ON ld.hn = lv.hn AND ld.vstdate = ll.vstdate
LEFT JOIN prev_drug pd ON pd.hn = lv.hn AND pd.vstdate = pl.vstdate
WHERE rn = 1
GROUP BY lv.vstdate, lv.hn, lv.cid, lv.patient_name, lv.icd10, lv.bw,lv.height, lv.bmi, lv.pressure, lv.waist, pd.vstdate, pd.drug, pd.drugusage, pd.qty, 
ld.vstdate, ld.drug, ld.drugusage, ld.qty, pl.Cholesterol, ll.Cholesterol,pl.hdl,ll.hdl,pl.ldl,
ll.ldl,pl.TRIGLYCERIDE,ll.TRIGLYCERIDE,pl.hb1ac,ll.hb1ac,pl.fbs,ll.fbs, pl.vstdate,ll.vstdate, ll.urine, 
pl.urine, pd.bw,pd.height, pd.bmi, pd.pressure, pd.waist, ld.bw,ld.height, ld.bmi, ld.pressure, ld.waist,lv.birthday
ORDER BY lv.vstdate, lv.hn