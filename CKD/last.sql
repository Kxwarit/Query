WITH infor AS (
    SELECT
        concat(p.pname, p.fname, ' ', p.lname) as patient_name,
        p.hn,
        p.cid,
        p.birthday,
        CONCAT(vv.age_y, ' ปี ', vv.age_m, ' เดือน ', vv.age_d, ' วัน ') AS age,
        CASE WHEN p.sex = '1' THEN 'ชาย' WHEN p.sex = '2' THEN 'หญิง' END AS sex,
        CASE WHEN p.informaddr <> '' THEN p.informaddr 
             ELSE CONCAT_WS(' ', p.addrpart, (CASE WHEN p.moopart <> '' THEN CONCAT('หมู่ ', p.moopart) END), th.full_name) 
        END as addr,
        STRING_AGG(DISTINCT CASE 
            WHEN p.hometel <> '' AND p.hometel ~ '^[0-9-]+$' AND p.hometel !~ '^(.)\1*$' THEN p.hometel 
            WHEN p.mobile_phone_number <> '' AND p.mobile_phone_number ~ '^[0-9-]+$' AND p.mobile_phone_number !~ '^(.)\1*$' THEN p.mobile_phone_number 
            WHEN p.informtel <> '' AND p.informtel ~ '^[0-9-]+$' AND p.informtel !~ '^(.)\1*$' THEN p.informtel 
            ELSE NULL 
        END, ', ') AS contact,
        CONCAT((STRING_AGG(d.agent, ' ')), ' ',(STRING_AGG(f.agent, ' '))) as allergy,
        os.bps,
        os.bpd,
        cg1.clinic_ckd_gfr_type_code
    FROM ovst o
    LEFT JOIN patient p ON p.hn = o.hn
    LEFT JOIN vn_stat vv ON vv.vn = o.vn
    LEFT JOIN thaiaddress th ON th.chwpart = p.chwpart AND th.amppart = p.amppart AND th.tmbpart = p.tmbpart
    LEFT JOIN depression_screen ds ON ds.vn = o.vn 
    LEFT JOIN opdscreen os ON os.vn = o.vn
    LEFT JOIN food_allergy f ON f.hn = p.hn
    LEFT JOIN opd_allergy d ON d.hn = p.hn
    LEFT OUTER JOIN clinicmember cm ON cm.hn = o.hn
    LEFT OUTER JOIN clinic_ckd_member ckd ON ckd.clinicmember_id = cm.clinicmember_id
    LEFT OUTER JOIN clinic_ckd_gfr_type cg1 on cg1.clinic_ckd_gfr_type_id = ckd.clinic_ckd_gfr_type_id 
    WHERE o.vn = '671220165446'
    GROUP BY p.pname, p.fname, p.lname, p.hn, p.cid, p.birthday, vv.age_y, vv.age_m, vv.age_d, p.sex, p.informaddr, 
             p.addrpart, p.moopart, th.full_name, os.bps, os.bpd, cg1.clinic_ckd_gfr_type_code
),

latest_hba1c AS (
    SELECT * FROM (
        SELECT 
            lh.hn,
            lo.lab_order_result AS hba1c,
            o.vstdate AS hba1c_date,
            ROW_NUMBER() OVER (PARTITION BY lh.hn ORDER BY o.vstdate DESC, lo.lab_order_number DESC) AS rn
        FROM ovst o
        LEFT JOIN lab_head lh ON lh.vn = o.vn
        LEFT JOIN lab_order lo ON lo.lab_order_number = lh.lab_order_number
        WHERE lo.lab_items_code = '48' AND lo.lab_order_result <> ''
    ) sub WHERE rn = 1
),

latest_egfr AS (
    SELECT * FROM (
        SELECT 
            lh.hn,
            lo.lab_order_result AS egfr,
            o.vstdate AS egfr_date,
            ROW_NUMBER() OVER (PARTITION BY lh.hn ORDER BY o.vstdate DESC, lo.lab_order_number DESC) AS rn
        FROM ovst o
        LEFT JOIN lab_head lh ON lh.vn = o.vn
        JOIN lab_order lo ON lo.lab_order_number = lh.lab_order_number
        WHERE lo.lab_items_code = '3424' AND lo.lab_order_result <> ''
    ) sub WHERE rn = 1
),

latest_triglyceride AS (
    SELECT * FROM (
        SELECT 
            lh.hn,
            lo.lab_order_result AS triglyceride,
            o.vstdate AS triglyceride_date,
            ROW_NUMBER() OVER (PARTITION BY lh.hn ORDER BY o.vstdate DESC, lo.lab_order_number DESC) AS rn
        FROM ovst o
        LEFT JOIN lab_head lh ON lh.vn = o.vn
        JOIN lab_order lo ON lo.lab_order_number = lh.lab_order_number
        WHERE lo.lab_items_code = '3006' AND lo.lab_order_result <> ''
    ) sub WHERE rn = 1
),

latest_ldl AS (
    SELECT * FROM (
        SELECT 
            lh.hn,
            lo.lab_order_result AS ldl,
            o.vstdate AS ldl_date,
            ROW_NUMBER() OVER (PARTITION BY lh.hn ORDER BY o.vstdate DESC, lo.lab_order_number DESC) AS rn
        FROM ovst o
        LEFT JOIN lab_head lh ON lh.vn = o.vn
        JOIN lab_order lo ON lo.lab_order_number = lh.lab_order_number
        WHERE lo.lab_items_code = '3008' AND lo.lab_order_result <> ''
    ) sub WHERE rn = 1
),

latest_albumin AS (
    SELECT * FROM (
        SELECT 
            lh.hn,
            lo.lab_order_result AS albumin,
            o.vstdate AS albumin_date,
            ROW_NUMBER() OVER (PARTITION BY lh.hn ORDER BY o.vstdate DESC, lo.lab_order_number DESC) AS rn
        FROM ovst o
        LEFT JOIN lab_head lh ON lh.vn = o.vn
        JOIN lab_order lo ON lo.lab_order_number = lh.lab_order_number
        WHERE lo.lab_items_code = '62' AND lo.lab_order_result <> ''
    ) sub WHERE rn = 1
),

latest_checkup AS (
    SELECT
        o.hn,
        (SELECT os_sub.pulse FROM ovst o_sub JOIN opdscreen os_sub ON os_sub.vn = o_sub.vn WHERE o_sub.hn = o.hn AND os_sub.pulse IS NOT NULL ORDER BY o_sub.vstdate DESC, o_sub.vn DESC LIMIT 1) AS pulse,
        (SELECT os_sub.bps FROM ovst o_sub JOIN opdscreen os_sub ON os_sub.vn = o_sub.vn WHERE o_sub.hn = o.hn AND os_sub.bps IS NOT NULL ORDER BY o_sub.vstdate DESC, o_sub.vn DESC LIMIT 1) AS bps,
        (SELECT os_sub.bpd FROM ovst o_sub JOIN opdscreen os_sub ON os_sub.vn = o_sub.vn WHERE o_sub.hn = o.hn AND os_sub.bpd IS NOT NULL ORDER BY o_sub.vstdate DESC, o_sub.vn DESC LIMIT 1) AS bpd,
        (SELECT os_sub.rr FROM ovst o_sub JOIN opdscreen os_sub ON os_sub.vn = o_sub.vn WHERE o_sub.hn = o.hn AND os_sub.rr IS NOT NULL ORDER BY o_sub.vstdate DESC, o_sub.vn DESC LIMIT 1) AS rr,
        (SELECT os_sub.temperature FROM ovst o_sub JOIN opdscreen os_sub ON os_sub.vn = o_sub.vn WHERE o_sub.hn = o.hn AND os_sub.temperature IS NOT NULL ORDER BY o_sub.vstdate DESC, o_sub.vn DESC LIMIT 1) AS temperature,
        (SELECT os_sub.bw FROM ovst o_sub JOIN opdscreen os_sub ON os_sub.vn = o_sub.vn WHERE o_sub.hn = o.hn AND os_sub.bw IS NOT NULL ORDER BY o_sub.vstdate DESC, o_sub.vn DESC LIMIT 1) AS bw,
        (SELECT os_sub.height FROM ovst o_sub JOIN opdscreen os_sub ON os_sub.vn = o_sub.vn WHERE o_sub.hn = o.hn AND os_sub.height IS NOT NULL ORDER BY o_sub.vstdate DESC, o_sub.vn DESC LIMIT 1) AS height,
        (SELECT os_sub.bmi FROM ovst o_sub JOIN opdscreen os_sub ON os_sub.vn = o_sub.vn WHERE o_sub.hn = o.hn AND os_sub.bmi IS NOT NULL ORDER BY o_sub.vstdate DESC, o_sub.vn DESC LIMIT 1) AS bmi,
        (SELECT os_sub.pe_ga FROM ovst o_sub JOIN opdscreen os_sub ON os_sub.vn = o_sub.vn WHERE o_sub.hn = o.hn AND os_sub.pe_ga IS NOT NULL ORDER BY o_sub.vstdate DESC, o_sub.vn DESC LIMIT 1) AS pe_ga,
        (SELECT os_sub.pe_ga_text FROM ovst o_sub JOIN opdscreen os_sub ON os_sub.vn = o_sub.vn WHERE o_sub.hn = o.hn AND os_sub.pe_ga_text IS NOT NULL ORDER BY o_sub.vstdate DESC, o_sub.vn DESC LIMIT 1) AS pe_ga_text,
        (SELECT os_sub.pe_heent FROM ovst o_sub JOIN opdscreen os_sub ON os_sub.vn = o_sub.vn WHERE o_sub.hn = o.hn AND os_sub.pe_heent IS NOT NULL ORDER BY o_sub.vstdate DESC, o_sub.vn DESC LIMIT 1) AS pe_heent,
        (SELECT os_sub.pe_heent_text FROM ovst o_sub JOIN opdscreen os_sub ON os_sub.vn = o_sub.vn WHERE o_sub.hn = o.hn AND os_sub.pe_heent_text IS NOT NULL ORDER BY o_sub.vstdate DESC, o_sub.vn DESC LIMIT 1) AS pe_heent_text,
        (SELECT os_sub.pe_heart FROM ovst o_sub JOIN opdscreen os_sub ON os_sub.vn = o_sub.vn WHERE o_sub.hn = o.hn AND os_sub.pe_heart IS NOT NULL ORDER BY o_sub.vstdate DESC, o_sub.vn DESC LIMIT 1) AS pe_heart,
        (SELECT os_sub.pe_heart_text FROM ovst o_sub JOIN opdscreen os_sub ON os_sub.vn = o_sub.vn WHERE o_sub.hn = o.hn AND os_sub.pe_heart_text IS NOT NULL ORDER BY o_sub.vstdate DESC, o_sub.vn DESC LIMIT 1) AS pe_heart_text,
        (SELECT os_sub.pe_chest FROM ovst o_sub JOIN opdscreen os_sub ON os_sub.vn = o_sub.vn WHERE o_sub.hn = o.hn AND os_sub.pe_chest IS NOT NULL ORDER BY o_sub.vstdate DESC, o_sub.vn DESC LIMIT 1) AS pe_chest,
        (SELECT os_sub.pe_chest_text FROM ovst o_sub JOIN opdscreen os_sub ON os_sub.vn = o_sub.vn WHERE o_sub.hn = o.hn AND os_sub.pe_chest_text IS NOT NULL ORDER BY o_sub.vstdate DESC, o_sub.vn DESC LIMIT 1) AS pe_chest_text,
        (SELECT os_sub.pe_ab FROM ovst o_sub JOIN opdscreen os_sub ON os_sub.vn = o_sub.vn WHERE o_sub.hn = o.hn AND os_sub.pe_ab IS NOT NULL ORDER BY o_sub.vstdate DESC, o_sub.vn DESC LIMIT 1) AS pe_ab,
        (SELECT os_sub.pe_ab_text FROM ovst o_sub JOIN opdscreen os_sub ON os_sub.vn = o_sub.vn WHERE o_sub.hn = o.hn AND os_sub.pe_ab_text IS NOT NULL ORDER BY o_sub.vstdate DESC, o_sub.vn DESC LIMIT 1) AS pe_ab_text,
        (SELECT os_sub.pe_pv FROM ovst o_sub JOIN opdscreen os_sub ON os_sub.vn = o_sub.vn WHERE o_sub.hn = o.hn AND os_sub.pe_pv IS NOT NULL ORDER BY o_sub.vstdate DESC, o_sub.vn DESC LIMIT 1) AS pe_pv,
        (SELECT os_sub.pe_pv_text FROM ovst o_sub JOIN opdscreen os_sub ON os_sub.vn = o_sub.vn WHERE o_sub.hn = o.hn AND os_sub.pe_pv_text IS NOT NULL ORDER BY o_sub.vstdate DESC, o_sub.vn DESC LIMIT 1) AS pe_pv_text,
        (SELECT os_sub.pe_pr FROM ovst o_sub JOIN opdscreen os_sub ON os_sub.vn = o_sub.vn WHERE o_sub.hn = o.hn AND os_sub.pe_pr IS NOT NULL ORDER BY o_sub.vstdate DESC, o_sub.vn DESC LIMIT 1) AS pe_pr,
        (SELECT os_sub.pe_pr_text FROM ovst o_sub JOIN opdscreen os_sub ON os_sub.vn = o_sub.vn WHERE o_sub.hn = o.hn AND os_sub.pe_pr_text IS NOT NULL ORDER BY o_sub.vstdate DESC, o_sub.vn DESC LIMIT 1) AS pe_pr_text,
        (SELECT os_sub.pe_gen FROM ovst o_sub JOIN opdscreen os_sub ON os_sub.vn = o_sub.vn WHERE o_sub.hn = o.hn AND os_sub.pe_gen IS NOT NULL ORDER BY o_sub.vstdate DESC, o_sub.vn DESC LIMIT 1) AS pe_gen,
        (SELECT os_sub.pe_gen_text FROM ovst o_sub JOIN opdscreen os_sub ON os_sub.vn = o_sub.vn WHERE o_sub.hn = o.hn AND os_sub.pe_gen_text IS NOT NULL ORDER BY o_sub.vstdate DESC, o_sub.vn DESC LIMIT 1) AS pe_gen_text,
        (SELECT os_sub.pe_neuro FROM ovst o_sub JOIN opdscreen os_sub ON os_sub.vn = o_sub.vn WHERE o_sub.hn = o.hn AND os_sub.pe_neuro IS NOT NULL ORDER BY o_sub.vstdate DESC, o_sub.vn DESC LIMIT 1) AS pe_neuro,
        (SELECT os_sub.pe_neuro_text FROM ovst o_sub JOIN opdscreen os_sub ON os_sub.vn = o_sub.vn WHERE o_sub.hn = o.hn AND os_sub.pe_neuro_text IS NOT NULL ORDER BY o_sub.vstdate DESC, o_sub.vn DESC LIMIT 1) AS pe_neuro_text,
        (SELECT os_sub.pe_ext FROM ovst o_sub JOIN opdscreen os_sub ON os_sub.vn = o_sub.vn WHERE o_sub.hn = o.hn AND os_sub.pe_ext IS NOT NULL ORDER BY o_sub.vstdate DESC, o_sub.vn DESC LIMIT 1) AS pe_ext,
        (SELECT os_sub.pe_ext_text FROM ovst o_sub JOIN opdscreen os_sub ON os_sub.vn = o_sub.vn WHERE o_sub.hn = o.hn AND os_sub.pe_ext_text IS NOT NULL ORDER BY o_sub.vstdate DESC, o_sub.vn DESC LIMIT 1) AS pe_ext_text,
        (SELECT ors_sub.ros_constitutional FROM ovst o_sub JOIN opdscreen_ros ors_sub ON ors_sub.vn = o_sub.vn WHERE o_sub.hn = o.hn AND ors_sub.ros_constitutional IS NOT NULL ORDER BY o_sub.vstdate DESC, o_sub.vn DESC LIMIT 1) AS ros_constitutional,
        (SELECT ors_sub.ros_constitutional_text FROM ovst o_sub JOIN opdscreen_ros ors_sub ON ors_sub.vn = o_sub.vn WHERE o_sub.hn = o.hn AND ors_sub.ros_constitutional_text IS NOT NULL ORDER BY o_sub.vstdate DESC, o_sub.vn DESC LIMIT 1) AS ros_constitutional_text,
        (SELECT ors_sub.ros_eyes FROM ovst o_sub JOIN opdscreen_ros ors_sub ON ors_sub.vn = o_sub.vn WHERE o_sub.hn = o.hn AND ors_sub.ros_eyes IS NOT NULL ORDER BY o_sub.vstdate DESC, o_sub.vn DESC LIMIT 1) AS ros_eyes,
        (SELECT ors_sub.ros_eyes_text FROM ovst o_sub JOIN opdscreen_ros ors_sub ON ors_sub.vn = o_sub.vn WHERE o_sub.hn = o.hn AND ors_sub.ros_eyes_text IS NOT NULL ORDER BY o_sub.vstdate DESC, o_sub.vn DESC LIMIT 1) AS ros_eyes_text,
        (SELECT ors_sub.ros_ent FROM ovst o_sub JOIN opdscreen_ros ors_sub ON ors_sub.vn = o_sub.vn WHERE o_sub.hn = o.hn AND ors_sub.ros_ent IS NOT NULL ORDER BY o_sub.vstdate DESC, o_sub.vn DESC LIMIT 1) AS ros_ent,
        (SELECT ors_sub.ros_ent_text FROM ovst o_sub JOIN opdscreen_ros ors_sub ON ors_sub.vn = o_sub.vn WHERE o_sub.hn = o.hn AND ors_sub.ros_ent_text IS NOT NULL ORDER BY o_sub.vstdate DESC, o_sub.vn DESC LIMIT 1) AS ros_ent_text,
        (SELECT ors_sub.ros_cardiovascular FROM ovst o_sub JOIN opdscreen_ros ors_sub ON ors_sub.vn = o_sub.vn WHERE o_sub.hn = o.hn AND ors_sub.ros_cardiovascular IS NOT NULL ORDER BY o_sub.vstdate DESC, o_sub.vn DESC LIMIT 1) AS ros_cardiovascular,
        (SELECT ors_sub.ros_cardiovascular_text FROM ovst o_sub JOIN opdscreen_ros ors_sub ON ors_sub.vn = o_sub.vn WHERE o_sub.hn = o.hn AND ors_sub.ros_cardiovascular_text IS NOT NULL ORDER BY o_sub.vstdate DESC, o_sub.vn DESC LIMIT 1) AS ros_cardiovascular_text,
        (SELECT ors_sub.ros_respiratory FROM ovst o_sub JOIN opdscreen_ros ors_sub ON ors_sub.vn = o_sub.vn WHERE o_sub.hn = o.hn AND ors_sub.ros_respiratory IS NOT NULL ORDER BY o_sub.vstdate DESC, o_sub.vn DESC LIMIT 1) AS ros_respiratory,
        (SELECT ors_sub.ros_respiratory_text FROM ovst o_sub JOIN opdscreen_ros ors_sub ON ors_sub.vn = o_sub.vn WHERE o_sub.hn = o.hn AND ors_sub.ros_respiratory_text IS NOT NULL ORDER BY o_sub.vstdate DESC, o_sub.vn DESC LIMIT 1) AS ros_respiratory_text,
        (SELECT ors_sub.ros_gastrointestinal FROM ovst o_sub JOIN opdscreen_ros ors_sub ON ors_sub.vn = o_sub.vn WHERE o_sub.hn = o.hn AND ors_sub.ros_gastrointestinal IS NOT NULL ORDER BY o_sub.vstdate DESC, o_sub.vn DESC LIMIT 1) AS ros_gastrointestinal,
        (SELECT ors_sub.ros_gastrointestinal_text FROM ovst o_sub JOIN opdscreen_ros ors_sub ON ors_sub.vn = o_sub.vn WHERE o_sub.hn = o.hn AND ors_sub.ros_gastrointestinal_text IS NOT NULL ORDER BY o_sub.vstdate DESC, o_sub.vn DESC LIMIT 1) AS ros_gastrointestinal_text,
        (SELECT ors_sub.ros_hemato FROM ovst o_sub JOIN opdscreen_ros ors_sub ON ors_sub.vn = o_sub.vn WHERE o_sub.hn = o.hn AND ors_sub.ros_hemato IS NOT NULL ORDER BY o_sub.vstdate DESC, o_sub.vn DESC LIMIT 1) AS ros_hemato,
        (SELECT ors_sub.ros_hemato_text FROM ovst o_sub JOIN opdscreen_ros ors_sub ON ors_sub.vn = o_sub.vn WHERE o_sub.hn = o.hn AND ors_sub.ros_hemato_text IS NOT NULL ORDER BY o_sub.vstdate DESC, o_sub.vn DESC LIMIT 1) AS ros_hemato_text,
        (SELECT ors_sub.ros_musculoskeletal FROM ovst o_sub JOIN opdscreen_ros ors_sub ON ors_sub.vn = o_sub.vn WHERE o_sub.hn = o.hn AND ors_sub.ros_musculoskeletal IS NOT NULL ORDER BY o_sub.vstdate DESC, o_sub.vn DESC LIMIT 1) AS ros_musculoskeletal,
        (SELECT ors_sub.ros_musculoskeletal_text FROM ovst o_sub JOIN opdscreen_ros ors_sub ON ors_sub.vn = o_sub.vn WHERE o_sub.hn = o.hn AND ors_sub.ros_musculoskeletal_text IS NOT NULL ORDER BY o_sub.vstdate DESC, o_sub.vn DESC LIMIT 1) AS ros_musculoskeletal_text
    FROM ovst o
    GROUP BY o.hn 
),

vaccine AS (
    SELECT 
        o.hn,
        STRING_AGG(CONCAT(TO_CHAR(o.vstdate + INTERVAL '543 years', 'DD/MM/YYYY'), ' ', p1.vaccine_name), E'\n' ORDER BY o.vstdate) FILTER (WHERE p1.vaccine_name ILIKE '%influenza%') AS influenza,
        STRING_AGG(CONCAT(TO_CHAR(o.vstdate + INTERVAL '543 years', 'DD/MM/YYYY'), ' ', p1.vaccine_name), E'\n' ORDER BY o.vstdate) FILTER (WHERE p1.vaccine_name ILIKE '%HBV%') AS hbv,
        STRING_AGG(CONCAT(TO_CHAR(o.vstdate + INTERVAL '543 years', 'DD/MM/YYYY'), ' ', p1.vaccine_name), E'\n' ORDER BY o.vstdate) FILTER (WHERE p1.vaccine_name ILIKE '%Pneumococcal%') AS pneumococcal
    FROM ovst o
    INNER JOIN ovst_vaccine o2 ON o2.vn = o.vn
    LEFT JOIN person_vaccine p1 ON p1.person_vaccine_id = o2.person_vaccine_id
    WHERE (p1.vaccine_name ILIKE '%influenza%' OR p1.vaccine_name ILIKE '%HBV%' OR p1.vaccine_name ILIKE '%Pneumococcal%') AND o.vstdate <> '1899-12-30'
    GROUP BY o.hn
    ORDER BY MIN(o.vstdate)
),

lastest_9q AS (
    SELECT * FROM (
        SELECT
            o.hn,
            ds.score_9q_1,
            ds.score_9q_2,
            ds.score_9q_3,
            ds.score_9q_4,
            ds.score_9q_5,
            ds.score_9q_6,
            ds.score_9q_7,
            ds.score_9q_8,
            ds.score_9q_9,
            ROW_NUMBER() OVER (PARTITION BY o.hn ORDER BY ds.depression_screen_id DESC) AS rn
        FROM ovst o
        INNER JOIN depression_screen ds ON ds.vn = o.vn
    ) sub WHERE rn = 1
)

SELECT 
    i.*,
    h.hba1c,
    h.hba1c_date,
    e.egfr,
    e.egfr_date,
    t.triglyceride,
    t.triglyceride_date,
    l.ldl,
    l.ldl_date,
    a.albumin,
    a.albumin_date,
    c.*,
    v.*, 
    q.*
FROM infor i
LEFT JOIN latest_hba1c h ON h.hn = i.hn
LEFT JOIN latest_egfr e ON e.hn = i.hn
LEFT JOIN latest_triglyceride t ON t.hn = i.hn
LEFT JOIN latest_ldl l ON l.hn = i.hn
LEFT JOIN latest_albumin a ON a.hn = i.hn
LEFT JOIN latest_checkup c ON c.hn = i.hn
LEFT JOIN vaccine v ON v.hn = i.hn
LEFT JOIN lastest_9q q ON q.hn = i.hn
LIMIT 100;
