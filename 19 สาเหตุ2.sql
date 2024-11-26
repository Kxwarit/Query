WITH accident_counts AS (
    SELECT 
        CASE 
            WHEN LEFT(od.icd10, 3) BETWEEN 'V01' AND 'V89' OR LEFT(id.icd10, 3) BETWEEN 'V01' AND 'V89' THEN 'อุบัติเหตุการขนส่ง'
            WHEN LEFT(od.icd10, 3) BETWEEN 'W00' AND 'W19' OR LEFT(id.icd10, 3) BETWEEN 'W00' AND 'W19' THEN 'พลัด ตก หรือหกล้ม'
            WHEN LEFT(od.icd10, 3) BETWEEN 'W20' AND 'W49' OR LEFT(id.icd10, 3) BETWEEN 'W20' AND 'W49' THEN 'สัมผัสกับแรงเชิงกลวัตถุสิ่งของ'
            WHEN LEFT(od.icd10, 3) BETWEEN 'W50' AND 'W64' OR LEFT(id.icd10, 3) BETWEEN 'W50' AND 'W64' THEN 'สัมผัสกับแรงเชิงกลของสัตว์/คน'
            WHEN LEFT(od.icd10, 3) BETWEEN 'W65' AND 'W74' OR LEFT(id.icd10, 3) BETWEEN 'W65' AND 'W74' THEN 'การตกน้ำ จมน้ำ'
            WHEN LEFT(od.icd10, 3) BETWEEN 'W75' AND 'W84' OR LEFT(id.icd10, 3) BETWEEN 'W75' AND 'W84' THEN 'คุกคามการหายใจ'
            WHEN LEFT(od.icd10, 3) BETWEEN 'W85' AND 'W99' OR LEFT(id.icd10, 3) BETWEEN 'W85' AND 'W99' THEN 'สัมผัสกระแสไฟฟ้า รังสีและอุณหภูมิ'
            WHEN LEFT(od.icd10, 3) BETWEEN 'X00' AND 'X99' OR LEFT(id.icd10, 3) BETWEEN 'X00' AND 'X99' THEN 'สัมผัสควันไฟ และเปลวไฟ'
            WHEN LEFT(od.icd10, 3) BETWEEN 'X10' AND 'X19' OR LEFT(id.icd10, 3) BETWEEN 'X10' AND 'X19' THEN 'สัมผัสความร้อน ของร้อน'
            WHEN LEFT(od.icd10, 3) BETWEEN 'X20' AND 'X29' OR LEFT(id.icd10, 3) BETWEEN 'X20' AND 'X29' THEN 'สัมผัสพิษจากสัตว์หรือพืช'
            WHEN LEFT(od.icd10, 3) BETWEEN 'X30' AND 'X39' OR LEFT(id.icd10, 3) BETWEEN 'X30' AND 'X39' THEN 'สัมผัสพลังงานจากธรรมชาติ'
            WHEN LEFT(od.icd10, 3) BETWEEN 'X40' AND 'X49' OR LEFT(id.icd10, 3) BETWEEN 'X40' AND 'X49' THEN 'สัมผัสพิษและสารอื่นๆ'
            WHEN LEFT(od.icd10, 3) BETWEEN 'X50' AND 'X57' OR LEFT(id.icd10, 3) BETWEEN 'X50' AND 'X57' THEN 'การออกแรงเกิน'
            WHEN LEFT(od.icd10, 3) BETWEEN 'X58' AND 'X59' OR LEFT(id.icd10, 3) BETWEEN 'X58' AND 'X59' THEN 'สัมผัสกับสิ่งไม่ทราบแน่ชัด'
            WHEN LEFT(od.icd10, 3) BETWEEN 'X60' AND 'X84' OR LEFT(id.icd10, 3) BETWEEN 'X60' AND 'X84' THEN 'ทำร้ายตัวเองด้วยวิธีต่างๆ'
            WHEN LEFT(od.icd10, 3) BETWEEN 'X85' AND 'Y09' OR LEFT(id.icd10, 3) BETWEEN 'X85' AND 'Y09' THEN 'ถูกทำร้ายด้วยวิธีต่างๆ'
            WHEN LEFT(od.icd10, 3) BETWEEN 'Y10' AND 'Y33' OR LEFT(id.icd10, 3) BETWEEN 'Y10' AND 'Y33' THEN 'บาดเจ็บโดยไม่ทราบเจตนา'
            WHEN LEFT(od.icd10, 3) BETWEEN 'Y35' AND 'Y36' OR LEFT(id.icd10, 3) BETWEEN 'Y35' AND 'Y36' THEN 'ดำเนินการตามกฎหมายหรือสงคราม'
            WHEN LEFT(od.icd10, 3) = 'Y34' OR LEFT(id.icd10, 3) = 'Y34' THEN 'ไม่ทราบทั้งสาเหตุและเจตนา'
            ELSE NULL 
        END AS accident_type,
        COUNT(DISTINCT CASE 
            WHEN o.vn IS NOT NULL THEN o.vn
            WHEN i.an IS NOT NULL THEN i.an
        END) AS count_accidents
    FROM 
        er_regist er
        LEFT JOIN ovst o ON o.vn = er.vn 
        LEFT JOIN ovstdiag od ON od.vn = er.vn
        LEFT JOIN ipt i ON i.vn = er.vn 
        LEFT JOIN iptdiag id ON id.an = i.an
    WHERE o.vstdate = '2024-09-01' OR i.dchdate = '2024-09-01'
    GROUP BY 
        accident_type
),
accident_types AS (
    SELECT unnest(ARRAY[
        'อุบัติเหตุการขนส่ง', 'พลัด ตก หรือหกล้ม', 'สัมผัสกับแรงเชิงกลวัตถุสิ่งของ',
        'สัมผัสกับแรงเชิงกลของสัตว์/คน', 'การตกน้ำ จมน้ำ', 'คุกคามการหายใจ',
        'สัมผัสกระแสไฟฟ้า รังสีและอุณหภูมิ', 'สัมผัสควันไฟ และเปลวไฟ', 'สัมผัสความร้อน ของร้อน',
        'สัมผัสพิษจากสัตว์หรือพืช', 'สัมผัสพลังงานจากธรรมชาติ', 'สัมผัสพิษและสารอื่นๆ',
        'การออกแรงเกิน', 'สัมผัสกับสิ่งไม่ทราบแน่ชัด', 'ทำร้ายตัวเองด้วยวิธีต่างๆ',
        'ถูกทำร้ายด้วยวิธีต่างๆ', 'บาดเจ็บโดยไม่ทราบเจตนา', 'ดำเนินการตามกฎหมายหรือสงคราม',
        'ไม่ทราบทั้งสาเหตุและเจตนา'
    ]) AS accident_type
)
SELECT 
    act.accident_type,
    COALESCE(ac.count_accidents, 0) AS count_accidents
FROM 
    accident_types act
    LEFT JOIN accident_counts ac ON act.accident_type = ac.accident_type
WHERE 
    act.accident_type IS NOT NULL
ORDER BY 
    CASE act.accident_type
        WHEN 'อุบัติเหตุการขนส่ง' THEN 1
        WHEN 'พลัด ตก หรือหกล้ม' THEN 2
        WHEN 'สัมผัสกับแรงเชิงกลวัตถุสิ่งของ' THEN 3
        WHEN 'สัมผัสกับแรงเชิงกลของสัตว์/คน' THEN 4
        WHEN 'การตกน้ำ จมน้ำ' THEN 5
        WHEN 'คุกคามการหายใจ' THEN 6
        WHEN 'สัมผัสกระแสไฟฟ้า รังสีและอุณหภูมิ' THEN 7
        WHEN 'สัมผัสควันไฟ และเปลวไฟ' THEN 8
        WHEN 'สัมผัสความร้อน ของร้อน' THEN 9
        WHEN 'สัมผัสพิษจากสัตว์หรือพืช' THEN 10
        WHEN 'สัมผัสพลังงานจากธรรมชาติ' THEN 11
        WHEN 'สัมผัสพิษและสารอื่นๆ' THEN 12
        WHEN 'การออกแรงเกิน' THEN 13
        WHEN 'สัมผัสกับสิ่งไม่ทราบแน่ชัด' THEN 14
        WHEN 'ทำร้ายตัวเองด้วยวิธีต่างๆ' THEN 15
        WHEN 'ถูกทำร้ายด้วยวิธีต่างๆ' THEN 16
        WHEN 'บาดเจ็บโดยไม่ทราบเจตนา' THEN 17
        WHEN 'ดำเนินการตามกฎหมายหรือสงคราม' THEN 18
        WHEN 'ไม่ทราบทั้งสาเหตุและเจตนา' THEN 19
    END;
WITH accident_counts AS (
    SELECT 
        CASE 
            WHEN LEFT(od.icd10, 3) BETWEEN 'V01' AND 'V89' OR LEFT(id.icd10, 3) BETWEEN 'V01' AND 'V89' THEN 'อุบัติเหตุการขนส่ง'
            WHEN LEFT(od.icd10, 3) BETWEEN 'W00' AND 'W19' OR LEFT(id.icd10, 3) BETWEEN 'W00' AND 'W19' THEN 'พลัด ตก หรือหกล้ม'
            WHEN LEFT(od.icd10, 3) BETWEEN 'W20' AND 'W49' OR LEFT(id.icd10, 3) BETWEEN 'W20' AND 'W49' THEN 'สัมผัสกับแรงเชิงกลวัตถุสิ่งของ'
            WHEN LEFT(od.icd10, 3) BETWEEN 'W50' AND 'W64' OR LEFT(id.icd10, 3) BETWEEN 'W50' AND 'W64' THEN 'สัมผัสกับแรงเชิงกลของสัตว์/คน'
            WHEN LEFT(od.icd10, 3) BETWEEN 'W65' AND 'W74' OR LEFT(id.icd10, 3) BETWEEN 'W65' AND 'W74' THEN 'การตกน้ำ จมน้ำ'
            WHEN LEFT(od.icd10, 3) BETWEEN 'W75' AND 'W84' OR LEFT(id.icd10, 3) BETWEEN 'W75' AND 'W84' THEN 'คุกคามการหายใจ'
            WHEN LEFT(od.icd10, 3) BETWEEN 'W85' AND 'W99' OR LEFT(id.icd10, 3) BETWEEN 'W85' AND 'W99' THEN 'สัมผัสกระแสไฟฟ้า รังสีและอุณหภูมิ'
            WHEN LEFT(od.icd10, 3) BETWEEN 'X00' AND 'X99' OR LEFT(id.icd10, 3) BETWEEN 'X00' AND 'X99' THEN 'สัมผัสควันไฟ และเปลวไฟ'
            WHEN LEFT(od.icd10, 3) BETWEEN 'X10' AND 'X19' OR LEFT(id.icd10, 3) BETWEEN 'X10' AND 'X19' THEN 'สัมผัสความร้อน ของร้อน'
            WHEN LEFT(od.icd10, 3) BETWEEN 'X20' AND 'X29' OR LEFT(id.icd10, 3) BETWEEN 'X20' AND 'X29' THEN 'สัมผัสพิษจากสัตว์หรือพืช'
            WHEN LEFT(od.icd10, 3) BETWEEN 'X30' AND 'X39' OR LEFT(id.icd10, 3) BETWEEN 'X30' AND 'X39' THEN 'สัมผัสพลังงานจากธรรมชาติ'
            WHEN LEFT(od.icd10, 3) BETWEEN 'X40' AND 'X49' OR LEFT(id.icd10, 3) BETWEEN 'X40' AND 'X49' THEN 'สัมผัสพิษและสารอื่นๆ'
            WHEN LEFT(od.icd10, 3) BETWEEN 'X50' AND 'X57' OR LEFT(id.icd10, 3) BETWEEN 'X50' AND 'X57' THEN 'การออกแรงเกิน'
            WHEN LEFT(od.icd10, 3) BETWEEN 'X58' AND 'X59' OR LEFT(id.icd10, 3) BETWEEN 'X58' AND 'X59' THEN 'สัมผัสกับสิ่งไม่ทราบแน่ชัด'
            WHEN LEFT(od.icd10, 3) BETWEEN 'X60' AND 'X84' OR LEFT(id.icd10, 3) BETWEEN 'X60' AND 'X84' THEN 'ทำร้ายตัวเองด้วยวิธีต่างๆ'
            WHEN LEFT(od.icd10, 3) BETWEEN 'X85' AND 'Y09' OR LEFT(id.icd10, 3) BETWEEN 'X85' AND 'Y09' THEN 'ถูกทำร้ายด้วยวิธีต่างๆ'
            WHEN LEFT(od.icd10, 3) BETWEEN 'Y10' AND 'Y33' OR LEFT(id.icd10, 3) BETWEEN 'Y10' AND 'Y33' THEN 'บาดเจ็บโดยไม่ทราบเจตนา'
            WHEN LEFT(od.icd10, 3) BETWEEN 'Y35' AND 'Y36' OR LEFT(id.icd10, 3) BETWEEN 'Y35' AND 'Y36' THEN 'ดำเนินการตามกฎหมายหรือสงคราม'
            WHEN LEFT(od.icd10, 3) = 'Y34' OR LEFT(id.icd10, 3) = 'Y34' THEN 'ไม่ทราบทั้งสาเหตุและเจตนา'
            ELSE NULL 
        END AS accident_type,
        COUNT(DISTINCT er.vn) AS count_accidents
    FROM 
        er_regist er
        LEFT JOIN ovst o ON o.vn = er.vn 
        LEFT JOIN ovstdiag od ON od.vn = er.vn  
        LEFT JOIN ipt i ON i.vn = er.vn 
        LEFT JOIN iptdiag id ON id.an = i.an 
    WHERE o.vstdate = '2024-09-01' OR i.dchdate = '2024-09-01'
    GROUP BY 
        accident_type
),
accident_types AS (
    SELECT unnest(ARRAY[
        'อุบัติเหตุการขนส่ง', 'พลัด ตก หรือหกล้ม', 'สัมผัสกับแรงเชิงกลวัตถุสิ่งของ',
        'สัมผัสกับแรงเชิงกลของสัตว์/คน', 'การตกน้ำ จมน้ำ', 'คุกคามการหายใจ',
        'สัมผัสกระแสไฟฟ้า รังสีและอุณหภูมิ', 'สัมผัสควันไฟ และเปลวไฟ', 'สัมผัสความร้อน ของร้อน',
        'สัมผัสพิษจากสัตว์หรือพืช', 'สัมผัสพลังงานจากธรรมชาติ', 'สัมผัสพิษและสารอื่นๆ',
        'การออกแรงเกิน', 'สัมผัสกับสิ่งไม่ทราบแน่ชัด', 'ทำร้ายตัวเองด้วยวิธีต่างๆ',
        'ถูกทำร้ายด้วยวิธีต่างๆ', 'บาดเจ็บโดยไม่ทราบเจตนา', 'ดำเนินการตามกฎหมายหรือสงคราม',
        'ไม่ทราบทั้งสาเหตุและเจตนา'
    ]) AS accident_type
)
SELECT 
    act.accident_type,
    COALESCE(ac.count_accidents, 0) AS count_accidents
FROM 
    accident_types act
    LEFT JOIN accident_counts ac ON act.accident_type = ac.accident_type
WHERE 
    act.accident_type IS NOT NULL
ORDER BY 
    CASE act.accident_type
        WHEN 'อุบัติเหตุการขนส่ง' THEN 1
        WHEN 'พลัด ตก หรือหกล้ม' THEN 2
        WHEN 'สัมผัสกับแรงเชิงกลวัตถุสิ่งของ' THEN 3
        WHEN 'สัมผัสกับแรงเชิงกลของสัตว์/คน' THEN 4
        WHEN 'การตกน้ำ จมน้ำ' THEN 5
        WHEN 'คุกคามการหายใจ' THEN 6
        WHEN 'สัมผัสกระแสไฟฟ้า รังสีและอุณหภูมิ' THEN 7
        WHEN 'สัมผัสควันไฟ และเปลวไฟ' THEN 8
        WHEN 'สัมผัสความร้อน ของร้อน' THEN 9
        WHEN 'สัมผัสพิษจากสัตว์หรือพืช' THEN 10
        WHEN 'สัมผัสพลังงานจากธรรมชาติ' THEN 11
        WHEN 'สัมผัสพิษและสารอื่นๆ' THEN 12
        WHEN 'การออกแรงเกิน' THEN 13
        WHEN 'สัมผัสกับสิ่งไม่ทราบแน่ชัด' THEN 14
        WHEN 'ทำร้ายตัวเองด้วยวิธีต่างๆ' THEN 15
        WHEN 'ถูกทำร้ายด้วยวิธีต่างๆ' THEN 16
        WHEN 'บาดเจ็บโดยไม่ทราบเจตนา' THEN 17
        WHEN 'ดำเนินการตามกฎหมายหรือสงคราม' THEN 18
        WHEN 'ไม่ทราบทั้งสาเหตุและเจตนา' THEN 19
    END;
