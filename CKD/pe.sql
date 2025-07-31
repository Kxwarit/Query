SELECT
    o.hn,
    (SELECT os_sub.pulse FROM ovst o_sub JOIN opdscreen os_sub ON os_sub.vn = o_sub.vn WHERE  (o_sub.vstdate BETWEEN CURRENT_DATE - INTERVAL '6 months' AND CURRENT_DATE) AND o_sub.hn = o.hn AND os_sub.pulse IS NOT NULL ORDER BY o_sub.vstdate DESC, o_sub.vn DESC LIMIT 1) AS pulse,
    (SELECT os_sub.bps FROM ovst o_sub JOIN opdscreen os_sub ON os_sub.vn = o_sub.vn WHERE  (o_sub.vstdate BETWEEN CURRENT_DATE - INTERVAL '6 months' AND CURRENT_DATE) AND o_sub.hn = o.hn AND os_sub.bps IS NOT NULL ORDER BY o_sub.vstdate DESC, o_sub.vn DESC LIMIT 1) AS bps,
    (SELECT os_sub.bpd FROM ovst o_sub JOIN opdscreen os_sub ON os_sub.vn = o_sub.vn WHERE  (o_sub.vstdate BETWEEN CURRENT_DATE - INTERVAL '6 months' AND CURRENT_DATE) AND o_sub.hn = o.hn AND os_sub.bpd IS NOT NULL ORDER BY o_sub.vstdate DESC, o_sub.vn DESC LIMIT 1) AS bpd,
    (SELECT os_sub.rr FROM ovst o_sub JOIN opdscreen os_sub ON os_sub.vn = o_sub.vn WHERE  (o_sub.vstdate BETWEEN CURRENT_DATE - INTERVAL '6 months' AND CURRENT_DATE) AND o_sub.hn = o.hn AND os_sub.rr IS NOT NULL ORDER BY o_sub.vstdate DESC, o_sub.vn DESC LIMIT 1) AS rr,
    (SELECT os_sub.temperature FROM ovst o_sub JOIN opdscreen os_sub ON os_sub.vn = o_sub.vn WHERE  (o_sub.vstdate BETWEEN CURRENT_DATE - INTERVAL '6 months' AND CURRENT_DATE) AND o_sub.hn = o.hn AND os_sub.temperature IS NOT NULL ORDER BY o_sub.vstdate DESC, o_sub.vn DESC LIMIT 1) AS temperature,
    (SELECT os_sub.bw FROM ovst o_sub JOIN opdscreen os_sub ON os_sub.vn = o_sub.vn WHERE  (o_sub.vstdate BETWEEN CURRENT_DATE - INTERVAL '6 months' AND CURRENT_DATE) AND o_sub.hn = o.hn AND os_sub.bw IS NOT NULL ORDER BY o_sub.vstdate DESC, o_sub.vn DESC LIMIT 1) AS bw,
    (SELECT os_sub.height FROM ovst o_sub JOIN opdscreen os_sub ON os_sub.vn = o_sub.vn WHERE  (o_sub.vstdate BETWEEN CURRENT_DATE - INTERVAL '6 months' AND CURRENT_DATE) AND o_sub.hn = o.hn AND os_sub.height IS NOT NULL ORDER BY o_sub.vstdate DESC, o_sub.vn DESC LIMIT 1) AS height,
    (SELECT os_sub.bmi FROM ovst o_sub JOIN opdscreen os_sub ON os_sub.vn = o_sub.vn WHERE  (o_sub.vstdate BETWEEN CURRENT_DATE - INTERVAL '6 months' AND CURRENT_DATE) AND o_sub.hn = o.hn AND os_sub.bmi IS NOT NULL ORDER BY o_sub.vstdate DESC, o_sub.vn DESC LIMIT 1) AS bmi,
    
    (SELECT os_sub.pe_ga FROM ovst o_sub JOIN opdscreen os_sub ON os_sub.vn = o_sub.vn WHERE  (o_sub.vstdate BETWEEN CURRENT_DATE - INTERVAL '6 months' AND CURRENT_DATE) AND o_sub.hn = o.hn AND os_sub.pe_ga IS NOT NULL ORDER BY o_sub.vstdate DESC, o_sub.vn DESC LIMIT 1) AS pe_ga,
    (SELECT os_sub.pe_ga_text FROM ovst o_sub JOIN opdscreen os_sub ON os_sub.vn = o_sub.vn WHERE  (o_sub.vstdate BETWEEN CURRENT_DATE - INTERVAL '6 months' AND CURRENT_DATE) AND o_sub.hn = o.hn AND os_sub.pe_ga_text <> '' ORDER BY o_sub.vstdate DESC, o_sub.vn DESC LIMIT 1) AS pe_ga_text,
    
    (SELECT os_sub.pe_heent FROM ovst o_sub JOIN opdscreen os_sub ON os_sub.vn = o_sub.vn WHERE  (o_sub.vstdate BETWEEN CURRENT_DATE - INTERVAL '6 months' AND CURRENT_DATE) AND o_sub.hn = o.hn AND os_sub.pe_heent IS NOT NULL ORDER BY o_sub.vstdate DESC, o_sub.vn DESC LIMIT 1) AS pe_heent,
    (SELECT os_sub.pe_heent_text FROM ovst o_sub JOIN opdscreen os_sub ON os_sub.vn = o_sub.vn WHERE  (o_sub.vstdate BETWEEN CURRENT_DATE - INTERVAL '6 months' AND CURRENT_DATE) AND o_sub.hn = o.hn AND os_sub.pe_heent_text <> '' ORDER BY o_sub.vstdate DESC, o_sub.vn DESC LIMIT 1) AS pe_heent_text,
    
    (SELECT os_sub.pe_heart FROM ovst o_sub JOIN opdscreen os_sub ON os_sub.vn = o_sub.vn WHERE  (o_sub.vstdate BETWEEN CURRENT_DATE - INTERVAL '6 months' AND CURRENT_DATE) AND o_sub.hn = o.hn AND os_sub.pe_heart IS NOT NULL ORDER BY o_sub.vstdate DESC, o_sub.vn DESC LIMIT 1) AS pe_heart,
    (SELECT os_sub.pe_heart_text FROM ovst o_sub JOIN opdscreen os_sub ON os_sub.vn = o_sub.vn WHERE  (o_sub.vstdate BETWEEN CURRENT_DATE - INTERVAL '6 months' AND CURRENT_DATE) AND o_sub.hn = o.hn AND os_sub.pe_heart_text <> '' ORDER BY o_sub.vstdate DESC, o_sub.vn DESC LIMIT 1) AS pe_heart_text,
    
    (SELECT os_sub.pe_chest FROM ovst o_sub JOIN opdscreen os_sub ON os_sub.vn = o_sub.vn WHERE  (o_sub.vstdate BETWEEN CURRENT_DATE - INTERVAL '6 months' AND CURRENT_DATE) AND o_sub.hn = o.hn AND os_sub.pe_chest IS NOT NULL ORDER BY o_sub.vstdate DESC, o_sub.vn DESC LIMIT 1) AS pe_chest,
    (SELECT os_sub.pe_chest_text FROM ovst o_sub JOIN opdscreen os_sub ON os_sub.vn = o_sub.vn WHERE  (o_sub.vstdate BETWEEN CURRENT_DATE - INTERVAL '6 months' AND CURRENT_DATE) AND o_sub.hn = o.hn AND os_sub.pe_chest_text <> '' ORDER BY o_sub.vstdate DESC, o_sub.vn DESC LIMIT 1) AS pe_chest_text,
    
    (SELECT os_sub.pe_ab FROM ovst o_sub JOIN opdscreen os_sub ON os_sub.vn = o_sub.vn WHERE  (o_sub.vstdate BETWEEN CURRENT_DATE - INTERVAL '6 months' AND CURRENT_DATE) AND o_sub.hn = o.hn AND os_sub.pe_ab IS NOT NULL ORDER BY o_sub.vstdate DESC, o_sub.vn DESC LIMIT 1) AS pe_ab,
    (SELECT os_sub.pe_ab_text FROM ovst o_sub JOIN opdscreen os_sub ON os_sub.vn = o_sub.vn WHERE  (o_sub.vstdate BETWEEN CURRENT_DATE - INTERVAL '6 months' AND CURRENT_DATE) AND o_sub.hn = o.hn AND os_sub.pe_ab_text <> '' ORDER BY o_sub.vstdate DESC, o_sub.vn DESC LIMIT 1) AS pe_ab_text,
    
    (SELECT os_sub.pe_pv FROM ovst o_sub JOIN opdscreen os_sub ON os_sub.vn = o_sub.vn WHERE  (o_sub.vstdate BETWEEN CURRENT_DATE - INTERVAL '6 months' AND CURRENT_DATE) AND o_sub.hn = o.hn AND os_sub.pe_pv IS NOT NULL ORDER BY o_sub.vstdate DESC, o_sub.vn DESC LIMIT 1) AS pe_pv,
    (SELECT os_sub.pe_pv_text FROM ovst o_sub JOIN opdscreen os_sub ON os_sub.vn = o_sub.vn WHERE  (o_sub.vstdate BETWEEN CURRENT_DATE - INTERVAL '6 months' AND CURRENT_DATE) AND o_sub.hn = o.hn AND os_sub.pe_pv_text <> '' ORDER BY o_sub.vstdate DESC, o_sub.vn DESC LIMIT 1) AS pe_pv_text,
    
    (SELECT os_sub.pe_pr FROM ovst o_sub JOIN opdscreen os_sub ON os_sub.vn = o_sub.vn WHERE  (o_sub.vstdate BETWEEN CURRENT_DATE - INTERVAL '6 months' AND CURRENT_DATE) AND o_sub.hn = o.hn AND os_sub.pe_pr IS NOT NULL ORDER BY o_sub.vstdate DESC, o_sub.vn DESC LIMIT 1) AS pe_pr,
    (SELECT os_sub.pe_pr_text FROM ovst o_sub JOIN opdscreen os_sub ON os_sub.vn = o_sub.vn WHERE  (o_sub.vstdate BETWEEN CURRENT_DATE - INTERVAL '6 months' AND CURRENT_DATE) AND o_sub.hn = o.hn AND os_sub.pe_pr_text <> '' ORDER BY o_sub.vstdate DESC, o_sub.vn DESC LIMIT 1) AS pe_pr_text,
    
    (SELECT os_sub.pe_gen FROM ovst o_sub JOIN opdscreen os_sub ON os_sub.vn = o_sub.vn WHERE  (o_sub.vstdate BETWEEN CURRENT_DATE - INTERVAL '6 months' AND CURRENT_DATE) AND o_sub.hn = o.hn AND os_sub.pe_gen IS NOT NULL ORDER BY o_sub.vstdate DESC, o_sub.vn DESC LIMIT 1) AS pe_gen,
    (SELECT os_sub.pe_gen_text FROM ovst o_sub JOIN opdscreen os_sub ON os_sub.vn = o_sub.vn WHERE  (o_sub.vstdate BETWEEN CURRENT_DATE - INTERVAL '6 months' AND CURRENT_DATE) AND o_sub.hn = o.hn AND os_sub.pe_gen_text <> '' ORDER BY o_sub.vstdate DESC, o_sub.vn DESC LIMIT 1) AS pe_gen_text,
    
    (SELECT os_sub.pe_neuro FROM ovst o_sub JOIN opdscreen os_sub ON os_sub.vn = o_sub.vn WHERE  (o_sub.vstdate BETWEEN CURRENT_DATE - INTERVAL '6 months' AND CURRENT_DATE) AND o_sub.hn = o.hn AND os_sub.pe_neuro IS NOT NULL ORDER BY o_sub.vstdate DESC, o_sub.vn DESC LIMIT 1) AS pe_neuro,
    (SELECT os_sub.pe_neuro_text FROM ovst o_sub JOIN opdscreen os_sub ON os_sub.vn = o_sub.vn WHERE  (o_sub.vstdate BETWEEN CURRENT_DATE - INTERVAL '6 months' AND CURRENT_DATE) AND o_sub.hn = o.hn AND os_sub.pe_neuro_text <> '' ORDER BY o_sub.vstdate DESC, o_sub.vn DESC LIMIT 1) AS pe_neuro_text,
    
    (SELECT os_sub.pe_ext FROM ovst o_sub JOIN opdscreen os_sub ON os_sub.vn = o_sub.vn WHERE  (o_sub.vstdate BETWEEN CURRENT_DATE - INTERVAL '6 months' AND CURRENT_DATE) AND o_sub.hn = o.hn AND os_sub.pe_ext IS NOT NULL ORDER BY o_sub.vstdate DESC, o_sub.vn DESC LIMIT 1) AS pe_ext,
    (SELECT os_sub.pe_ext_text FROM ovst o_sub JOIN opdscreen os_sub ON os_sub.vn = o_sub.vn WHERE  (o_sub.vstdate BETWEEN CURRENT_DATE - INTERVAL '6 months' AND CURRENT_DATE) AND o_sub.hn = o.hn AND os_sub.pe_ext_text <> '' ORDER BY o_sub.vstdate DESC, o_sub.vn DESC LIMIT 1) AS pe_ext_text,
    
    (SELECT ors_sub.ros_constitutional FROM ovst o_sub JOIN opdscreen_ros ors_sub ON ors_sub.vn = o_sub.vn WHERE  (o_sub.vstdate BETWEEN CURRENT_DATE - INTERVAL '6 months' AND CURRENT_DATE) AND o_sub.hn = o.hn AND ors_sub.ros_constitutional IS NOT NULL ORDER BY o_sub.vstdate DESC, o_sub.vn DESC LIMIT 1) AS ros_constitutional,
    (SELECT ors_sub.ros_constitutional_text FROM ovst o_sub JOIN opdscreen_ros ors_sub ON ors_sub.vn = o_sub.vn WHERE  (o_sub.vstdate BETWEEN CURRENT_DATE - INTERVAL '6 months' AND CURRENT_DATE) AND o_sub.hn = o.hn AND ors_sub.ros_constitutional_text <> '' ORDER BY o_sub.vstdate DESC, o_sub.vn DESC LIMIT 1) AS ros_constitutional_text,
    
    (SELECT ors_sub.ros_eyes FROM ovst o_sub JOIN opdscreen_ros ors_sub ON ors_sub.vn = o_sub.vn WHERE  (o_sub.vstdate BETWEEN CURRENT_DATE - INTERVAL '6 months' AND CURRENT_DATE) AND o_sub.hn = o.hn AND ors_sub.ros_eyes IS NOT NULL ORDER BY o_sub.vstdate DESC, o_sub.vn DESC LIMIT 1) AS ros_eyes,
    (SELECT ors_sub.ros_eyes_text FROM ovst o_sub JOIN opdscreen_ros ors_sub ON ors_sub.vn = o_sub.vn WHERE  (o_sub.vstdate BETWEEN CURRENT_DATE - INTERVAL '6 months' AND CURRENT_DATE) AND o_sub.hn = o.hn AND ors_sub.ros_eyes_text <> '' ORDER BY o_sub.vstdate DESC, o_sub.vn DESC LIMIT 1) AS ros_eyes_text,
    
    (SELECT ors_sub.ros_ent FROM ovst o_sub JOIN opdscreen_ros ors_sub ON ors_sub.vn = o_sub.vn WHERE  (o_sub.vstdate BETWEEN CURRENT_DATE - INTERVAL '6 months' AND CURRENT_DATE) AND o_sub.hn = o.hn AND ors_sub.ros_ent IS NOT NULL ORDER BY o_sub.vstdate DESC, o_sub.vn DESC LIMIT 1) AS ros_ent,
    (SELECT ors_sub.ros_ent_text FROM ovst o_sub JOIN opdscreen_ros ors_sub ON ors_sub.vn = o_sub.vn WHERE  (o_sub.vstdate BETWEEN CURRENT_DATE - INTERVAL '6 months' AND CURRENT_DATE) AND o_sub.hn = o.hn AND ors_sub.ros_ent_text <> '' ORDER BY o_sub.vstdate DESC, o_sub.vn DESC LIMIT 1) AS ros_ent_text,
    
    (SELECT ors_sub.ros_cardiovascular FROM ovst o_sub JOIN opdscreen_ros ors_sub ON ors_sub.vn = o_sub.vn WHERE  (o_sub.vstdate BETWEEN CURRENT_DATE - INTERVAL '6 months' AND CURRENT_DATE) AND o_sub.hn = o.hn AND ors_sub.ros_cardiovascular IS NOT NULL ORDER BY o_sub.vstdate DESC, o_sub.vn DESC LIMIT 1) AS ros_cardiovascular,
    (SELECT ors_sub.ros_cardiovascular_text FROM ovst o_sub JOIN opdscreen_ros ors_sub ON ors_sub.vn = o_sub.vn WHERE  (o_sub.vstdate BETWEEN CURRENT_DATE - INTERVAL '6 months' AND CURRENT_DATE) AND o_sub.hn = o.hn AND ors_sub.ros_cardiovascular_text <> '' ORDER BY o_sub.vstdate DESC, o_sub.vn DESC LIMIT 1) AS ros_cardiovascular_text,
    
    (SELECT ors_sub.ros_respiratory FROM ovst o_sub JOIN opdscreen_ros ors_sub ON ors_sub.vn = o_sub.vn WHERE  (o_sub.vstdate BETWEEN CURRENT_DATE - INTERVAL '6 months' AND CURRENT_DATE) AND o_sub.hn = o.hn AND ors_sub.ros_respiratory IS NOT NULL ORDER BY o_sub.vstdate DESC, o_sub.vn DESC LIMIT 1) AS ros_respiratory,
    (SELECT ors_sub.ros_respiratory_text FROM ovst o_sub JOIN opdscreen_ros ors_sub ON ors_sub.vn = o_sub.vn WHERE  (o_sub.vstdate BETWEEN CURRENT_DATE - INTERVAL '6 months' AND CURRENT_DATE) AND o_sub.hn = o.hn AND ors_sub.ros_respiratory_text <> '' ORDER BY o_sub.vstdate DESC, o_sub.vn DESC LIMIT 1) AS ros_respiratory_text,
    
    (SELECT ors_sub.ros_gastrointestinal FROM ovst o_sub JOIN opdscreen_ros ors_sub ON ors_sub.vn = o_sub.vn WHERE  (o_sub.vstdate BETWEEN CURRENT_DATE - INTERVAL '6 months' AND CURRENT_DATE) AND o_sub.hn = o.hn AND ors_sub.ros_gastrointestinal IS NOT NULL ORDER BY o_sub.vstdate DESC, o_sub.vn DESC LIMIT 1) AS ros_gastrointestinal,
    (SELECT ors_sub.ros_gastrointestinal_text FROM ovst o_sub JOIN opdscreen_ros ors_sub ON ors_sub.vn = o_sub.vn WHERE  (o_sub.vstdate BETWEEN CURRENT_DATE - INTERVAL '6 months' AND CURRENT_DATE) AND o_sub.hn = o.hn AND ors_sub.ros_gastrointestinal_text <> '' ORDER BY o_sub.vstdate DESC, o_sub.vn DESC LIMIT 1) AS ros_gastrointestinal_text,
    
    (SELECT ors_sub.ros_hemato FROM ovst o_sub JOIN opdscreen_ros ors_sub ON ors_sub.vn = o_sub.vn WHERE  (o_sub.vstdate BETWEEN CURRENT_DATE - INTERVAL '6 months' AND CURRENT_DATE) AND o_sub.hn = o.hn AND ors_sub.ros_hemato IS NOT NULL ORDER BY o_sub.vstdate DESC, o_sub.vn DESC LIMIT 1) AS ros_hemato,
    (SELECT ors_sub.ros_hemato_text FROM ovst o_sub JOIN opdscreen_ros ors_sub ON ors_sub.vn = o_sub.vn WHERE  (o_sub.vstdate BETWEEN CURRENT_DATE - INTERVAL '6 months' AND CURRENT_DATE) AND o_sub.hn = o.hn AND ors_sub.ros_hemato_text <> '' ORDER BY o_sub.vstdate DESC, o_sub.vn DESC LIMIT 1) AS ros_hemato_text,
    
    (SELECT ors_sub.ros_musculoskeletal FROM ovst o_sub JOIN opdscreen_ros ors_sub ON ors_sub.vn = o_sub.vn WHERE  (o_sub.vstdate BETWEEN CURRENT_DATE - INTERVAL '6 months' AND CURRENT_DATE) AND o_sub.hn = o.hn AND ors_sub.ros_musculoskeletal IS NOT NULL ORDER BY o_sub.vstdate DESC, o_sub.vn DESC LIMIT 1) AS ros_musculoskeletal,
    (SELECT ors_sub.ros_musculoskeletal_text FROM ovst o_sub JOIN opdscreen_ros ors_sub ON ors_sub.vn = o_sub.vn WHERE  (o_sub.vstdate BETWEEN CURRENT_DATE - INTERVAL '6 months' AND CURRENT_DATE) AND o_sub.hn = o.hn AND ors_sub.ros_musculoskeletal_text <> '' ORDER BY o_sub.vstdate DESC, o_sub.vn DESC LIMIT 1) AS ros_musculoskeletal_text
FROM ovst o
WHERE o.hn = '6410725' 

GROUP BY o.hn; 