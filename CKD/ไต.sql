SELECT
    --ข้อมูลผู้ป่วยเบื้องต้น 
    concat(p.pname, p.fname, ' ', p.lname) as patient_name,
    p.hn,
    p.cid,
    p.birthday,
    CONCAT(vv.age_y, ' ปี ', vv.age_m, ' เดือน ', vv.age_d, ' วัน ') AS age,
    CASE WHEN p.sex = '1' THEN 'ชาย' WHEN p.sex = '2' THEN 'หญิง' END AS sex,
    CASE WHEN p.informaddr <> '' then p.informaddr ELSE CONCAT_WS(' ', p.addrpart, (CASE WHEN p.moopart <> '' THEN CONCAT('หมู่ ', p.moopart)END), th.full_name) END as addr,
    STRING_AGG( DISTINCT CASE 
        WHEN p.hometel <> '' AND p.hometel ~ '^[0-9-]+$' AND p.hometel !~ '^(.)\1*$' THEN p.hometel 
        WHEN p.mobile_phone_number <> '' AND p.mobile_phone_number ~ '^[0-9-]+$' AND p.mobile_phone_number !~ '^(.)\1*$' THEN p.mobile_phone_number 
        WHEN p.informtel <> '' AND p.informtel ~ '^[0-9-]+$' AND p.informtel !~ '^(.)\1*$' THEN p.informtel 
    ELSE NULL END, ', ') AS contact,
    --ตรวจร่างกายของแพทย์
    os.pulse,
    os.bps,
    os.bpd,
    os.rr,
    os.temperature,
    os.bw,
    os.height,
    os.bmi,
    ds.score_9q_1,
    ds.score_9q_2,
    ds.score_9q_3,
    ds.score_9q_4,
    ds.score_9q_5,
    ds.score_9q_6,
    ds.score_9q_7,
    ds.score_9q_8,
    ds.score_9q_9
FROM ovst o
LEFT OUTER JOIN patient p ON p.hn = o.hn
LEFT OUTER JOIN vn_stat vv ON vv.vn = o.vn
LEFT OUTER JOIN thaiaddress th ON th.chwpart = p.chwpart AND th.amppart = p.amppart AND th.tmbpart = p.tmbpart
LEFT OUTER JOIN depression_screen ds ON ds.vn = o.vn 
LEFT OUTER JOIN opdscreen os ON os.vn = o.vn
LEFT OUTER JOIN lab_head lh ON lh.hn = o.hn
LEFT OUTER JOIN lab_order lo ON lo.lab_order_number = lh.lab_order_number
WHERE o.vn = '671220165446'
AND lo.lab_items_code IN ('48','3424')
AND lo.lab_order_result <> ''
GROUP BY p.pname, p.fname, p.lname, p.hn, p.cid, p.birthday, vv.age_y, vv.age_m, vv.age_d, p.sex, p.informaddr, p.addrpart, p.moopart, th.full_name, 
os.pulse, os.bps, os.bpd, os.rr, os.temperature, os.bw, os.height, os.bmi,
ds.score_9q_1, ds.score_9q_2, ds.score_9q_3, ds.score_9q_4, ds.score_9q_5, ds.score_9q_6, ds.score_9q_7, ds.score_9q_8, ds.score_9q_9 
----------
WITH infor AS (
    SELECT
        --ข้อมูลผู้ป่วยเบื้องต้น 
        concat(p.pname, p.fname, ' ', p.lname) as patient_name,
        p.hn,
        p.cid,
        p.birthday,
        CONCAT(vv.age_y, ' ปี ', vv.age_m, ' เดือน ', vv.age_d, ' วัน ') AS age,
        CASE WHEN p.sex = '1' THEN 'ชาย' WHEN p.sex = '2' THEN 'หญิง' END AS sex,
        CASE WHEN p.informaddr <> '' then p.informaddr ELSE CONCAT_WS(' ', p.addrpart, (CASE WHEN p.moopart <> '' THEN CONCAT('หมู่ ', p.moopart)END), th.full_name) END as addr,
        STRING_AGG( DISTINCT CASE 
            WHEN p.hometel <> '' AND p.hometel ~ '^[0-9-]+$' AND p.hometel !~ '^(.)\1*$' THEN p.hometel 
            WHEN p.mobile_phone_number <> '' AND p.mobile_phone_number ~ '^[0-9-]+$' AND p.mobile_phone_number !~ '^(.)\1*$' THEN p.mobile_phone_number 
            WHEN p.informtel <> '' AND p.informtel ~ '^[0-9-]+$' AND p.informtel !~ '^(.)\1*$' THEN p.informtel 
        ELSE NULL END, ', ') AS contact,
        --ตรวจร่างกายของแพทย์
        os.pulse,
        os.bps,
        os.bpd,
        os.rr,
        os.temperature,
        os.bw,
        os.height,
        os.bmi,
        ds.score_9q_1,
        ds.score_9q_2,
        ds.score_9q_3,
        ds.score_9q_4,
        ds.score_9q_5,
        ds.score_9q_6,
        ds.score_9q_7,
        ds.score_9q_8,
        ds.score_9q_9
    FROM ovst o
    LEFT OUTER JOIN patient p ON p.hn = o.hn
    LEFT OUTER JOIN vn_stat vv ON vv.vn = o.vn
    LEFT OUTER JOIN thaiaddress th ON th.chwpart = p.chwpart AND th.amppart = p.amppart AND th.tmbpart = p.tmbpart
    LEFT OUTER JOIN depression_screen ds ON ds.vn = o.vn 
    LEFT OUTER JOIN opdscreen os ON os.vn = o.vn
    WHERE o.vn = '680709000057'
    GROUP BY p.pname, p.fname, p.lname, p.hn, p.cid, p.birthday, vv.age_y, vv.age_m, vv.age_d, p.sex, p.informaddr, p.addrpart, p.moopart, th.full_name, 
    os.pulse, os.bps, os.bpd, os.rr, os.temperature, os.bw, os.height, os.bmi,
    ds.score_9q_1, ds.score_9q_2, ds.score_9q_3, ds.score_9q_4, ds.score_9q_5, ds.score_9q_6, ds.score_9q_7, ds.score_9q_8, ds.score_9q_9 

),

latest_hba1c AS (
    SELECT 
        lh.hn,
        lo.lab_order_result AS hba1c,
        lh.order_date AS hba1c_date,
        ROW_NUMBER() OVER (PARTITION BY lh.hn ORDER BY lh.order_date DESC, lo.lab_order_number DESC) AS rn
    FROM lab_head lh
    JOIN lab_order lo ON lo.lab_order_number = lh.lab_order_number
    WHERE lo.lab_items_code = '48' AND lo.lab_order_result <> ''
),

latest_egfr AS (
    SELECT 
        lh.hn,
        lo.lab_order_result AS egfr,
        lh.order_date AS egfr_date,
        ROW_NUMBER() OVER (PARTITION BY lh.hn ORDER BY lh.order_date DESC, lo.lab_order_number DESC) AS rn
    FROM lab_head lh
    JOIN lab_order lo ON lo.lab_order_number = lh.lab_order_number
    WHERE lo.lab_items_code = '3424' AND lo.lab_order_result <> ''
)
SELECT 
    i.*,
    h.hba1c,
    h.hba1c_date,
    e.egfr,
    e.egfr_date
FROM infor i
LEFT OUTER JOIN latest_hba1c h ON h.hn = i.hn
LEFT OUTER JOIN latest_egfr e ON e.hn = i.hn
WHERE h.rn = 1 AND e.rn = 1
LIMIT 100;
