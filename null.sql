WITH DepartmentGroups AS ( 
    SELECT 
        o.vn,
        CASE 
            WHEN op.income IN ('01') THEN 'ค่าห้องและอาหาร ค่าเตียงสังเกตอาการ' 
            WHEN op.income IN ('02') THEN 'ค่าวัสดุอุปกรณ์เครื่องมือที่ใช้' 
            WHEN op.income IN ('03', '04') THEN 'ค่าเวชภัณฑ์ยา'
            WHEN op.income IN ('05') THEN 'ค่าเวชภัณฑ์ไม่ใช่ยา'
            WHEN op.income IN ('06') THEN '06ค่าบริการโลหิตและส่วนประกอบของโลหิต'
            WHEN op.income IN ('07') THEN 'ค่าตรวจวินิวฉัยทางเทคนิคการแพทย์และพยาธิ'
            WHEN op.income IN ('08') THEN 'ค่าตรวจวินิจฉัยและรักษาทางรังสีวิทยา' 
            WHEN xi.xray_items_group IN ('8') AND xi.active_status = 'Y' THEN 'ค่า x-ray' 
            WHEN xi.xray_items_group IN ('6') AND xi.active_status = 'Y' THEN 'ค่า Ultrasound' 
            WHEN xi.xray_items_group IN ('4') AND xi.active_status = 'Y'  THEN 'ค่า MRI' 
            WHEN xi.xray_items_group IN ('3') AND xi.active_status = 'Y' THEN 'ค่า CT' 
            WHEN op.income IN ('09') THEN 'ค่าตรวจด้วยเครื่องมือพิเศษ'
            WHEN op.income IN ('10') THEN 'ค่าอุปกรณ์ของใช้และเครื่องมือทางการแพทย์' 
            WHEN op.income IN ('11') THEN 'ค่าหัตถการต่างๆ' 
            WHEN op.income IN ('12') THEN 'ค่าบริการผู้ป่วยนอก' 
            WHEN op.income IN ('13') THEN 'ค่าบริการทางพยาบาล' 
            WHEN op.income IN ('14') THEN 'ค่าบริการทางกายภาพบำบัดและทางเวชกรรมฟื้นฟู' 
            WHEN op.income IN ('15') THEN 'ค่าบริการฝังเข็ม และค่าบริการการให้การบำบัดของผู้ประกอบโรคศิลปะอื่น' 
            WHEN op.income IN ('16') THEN 'ค่าบริการอื่น ๆ ที่ไม่เกี่ยวกับการรักษาพยาบาลโดยตรง'
             
        END AS group_name,
        op.sum_price
    FROM ovst o
    INNER JOIN opitemrece op ON op.vn = o.vn
    LEFT JOIN xray_items xi ON xi.icode = op.icode 
    WHERE o.vstdate BETWEEN '2023-10-01' AND '2024-09-30' 
      AND o.an IS NULL  AND o.pttype IN ('T1','T2')
)

SELECT 
    group_name,
    COUNT(vn) AS visit_count,
    SUM(sum_price) AS costs 
FROM DepartmentGroups 
WHERE group_name IN (
    'ค่าห้องและอาหาร ค่าเตียงสังเกตอาการ',
    'ค่าวัสดุอุปกรณ์เครื่องมือที่ใช้',
    'ค่าตรวจวินิวฉัยทางเทคนิคการแพทย์และพยาธิ',
    'ค่าตรวจวินิจฉัยและรังสีวิทยา',
    'ค่า Ultrasound',
    'ค่า MRI',
    'ค่า CT',
    'ค่าตรวจด้วยเครื่องมือพิเศษ',
    'ค่าหัตถการต่างๆ',
    'ค่าบริการผู้ป่วยนอก',
    'ค่าเวชภัณฑ์ยา'
)
GROUP BY group_name 
ORDER BY 
    CASE 
        WHEN group_name = 'ค่าห้องและอาหาร ค่าเตียงสังเกตอาการ'  THEN 1 
        WHEN group_name = 'ค่าวัสดุอุปกรณ์เครื่องมือที่ใช้' THEN 2 
        WHEN group_name = 'ค่าตรวจวินิวฉัยทางเทคนิคการแพทย์และพยาธิ'  THEN 3 
        WHEN group_name = 'ค่าตรวจวินิจฉัยและรังสีวิทยา' THEN 4 
        WHEN group_name = 'ค่า Ultrasound' THEN 5 
        WHEN group_name = 'ค่า MRI' THEN 6 
        WHEN group_name = 'ค่า CT' THEN 7 
        WHEN group_name = 'ค่าตรวจด้วยเครื่องมือพิเศษ' THEN 8 
        WHEN group_name = 'ค่าหัตถการต่างๆ' THEN 9 
        WHEN group_name = 'ค่าบริการผู้ป่วยนอก'  THEN 10 
        WHEN group_name = 'ค่าเวชภัณฑ์ยา'  THEN 11 
    END
