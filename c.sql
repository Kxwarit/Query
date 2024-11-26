SELECT
    'ค่าห้องและอาหาร_ค่าเตียงสังเกตอาการ' AS รายการ,
    COUNT(CASE WHEN op.income IN ('01') THEN o.vn END) AS จำนวน,
    SUM(CASE WHEN op.income IN ('01') THEN op.sum_price ELSE 0 END) AS ยอดรวม
FROM ovst o
INNER JOIN opitemrece op ON op.vn = o.vn
LEFT JOIN xray_items xi ON xi.icode = op.icode
WHERE o.vstdate BETWEEN '2023-10-01' AND '2024-09-30'
  AND o.an IS NULL
  AND o.pttype IN ('T1','T2')

UNION ALL

SELECT
    'ค่าวัสดุอุปกรณ์เครื่องมือที่ใช้' AS รายการ,
    COUNT(CASE WHEN op.income IN ('02') THEN o.vn END) AS จำนวน,
    SUM(CASE WHEN op.income IN ('02') THEN op.sum_price ELSE 0 END) AS ยอดรวม
FROM ovst o
INNER JOIN opitemrece op ON op.vn = o.vn
LEFT JOIN xray_items xi ON xi.icode = op.icode
WHERE o.vstdate BETWEEN '2023-10-01' AND '2024-09-30'
  AND o.an IS NULL
  AND o.pttype IN ('T1','T2')

UNION ALL

SELECT
    'ค่าเวชภัณฑ์ยา' AS รายการ,
    COUNT(CASE WHEN op.income IN ('03', '04') THEN o.vn END) AS จำนวน,
    SUM(CASE WHEN op.income IN ('03', '04') THEN op.sum_price ELSE 0 END) AS ยอดรวม
FROM ovst o
INNER JOIN opitemrece op ON op.vn = o.vn
LEFT JOIN xray_items xi ON xi.icode = op.icode
WHERE o.vstdate BETWEEN '2023-10-01' AND '2024-09-30'
  AND o.an IS NULL
  AND o.pttype IN ('T1','T2')

UNION ALL

SELECT
    'ค่าเวชภัณฑ์ไม่ใช่ยา' AS รายการ,
    COUNT(CASE WHEN op.income IN ('05') THEN o.vn END) AS จำนวน,
    SUM(CASE WHEN op.income IN ('05') THEN op.sum_price ELSE 0 END) AS ยอดรวม
FROM ovst o
INNER JOIN opitemrece op ON op.vn = o.vn
LEFT JOIN xray_items xi ON xi.icode = op.icode
WHERE o.vstdate BETWEEN '2023-10-01' AND '2024-09-30'
  AND o.an IS NULL
  AND o.pttype IN ('T1','T2')

UNION ALL

SELECT
    'ค่าบริการโลหิตและส่วนประกอบของโลหิต' AS รายการ,
    COUNT(CASE WHEN op.income IN ('06') THEN o.vn END) AS จำนวน,
    SUM(CASE WHEN op.income IN ('06') THEN op.sum_price ELSE 0 END) AS ยอดรวม
FROM ovst o
INNER JOIN opitemrece op ON op.vn = o.vn
LEFT JOIN xray_items xi ON xi.icode = op.icode
WHERE o.vstdate BETWEEN '2023-10-01' AND '2024-09-30'
  AND o.an IS NULL
  AND o.pttype IN ('T1','T2')

UNION ALL

SELECT
    'ค่าตรวจวินิจฉัยทางเทคนิคการแพทย์และพยาธิ' AS รายการ,
    COUNT(CASE WHEN op.income IN ('07') THEN o.vn END) AS จำนวน,
    SUM(CASE WHEN op.income IN ('07') THEN op.sum_price ELSE 0 END) AS ยอดรวม
FROM ovst o
INNER JOIN opitemrece op ON op.vn = o.vn
LEFT JOIN xray_items xi ON xi.icode = op.icode
WHERE o.vstdate BETWEEN '2023-10-01' AND '2024-09-30'
  AND o.an IS NULL
  AND o.pttype IN ('T1','T2')

UNION ALL

SELECT
    'ค่าตรวจวินิจฉัยและรักษาทางรังสีวิทยา' AS รายการ,
    COUNT(CASE WHEN op.income IN ('08') THEN o.vn END) AS จำนวน,
    SUM(CASE WHEN op.income IN ('08') THEN op.sum_price ELSE 0 END) AS ยอดรวม
FROM ovst o
INNER JOIN opitemrece op ON op.vn = o.vn
LEFT JOIN xray_items xi ON xi.icode = op.icode
WHERE o.vstdate BETWEEN '2023-10-01' AND '2024-09-30'
  AND o.an IS NULL
  AND o.pttype IN ('T1','T2')

UNION ALL

SELECT
    'ค่า_x_ray' AS รายการ,
    COUNT(CASE WHEN xi.xray_items_group IN ('8') AND xi.active_status = 'Y' THEN o.vn END) AS จำนวน,
    SUM(CASE WHEN xi.xray_items_group IN ('8') AND xi.active_status = 'Y' THEN op.sum_price ELSE 0 END) AS ยอดรวม
FROM ovst o
INNER JOIN opitemrece op ON op.vn = o.vn
LEFT JOIN xray_items xi ON xi.icode = op.icode
WHERE o.vstdate BETWEEN '2023-10-01' AND '2024-09-30'
  AND o.an IS NULL
  AND o.pttype IN ('T1','T2')

UNION ALL

SELECT
    'ค่า_Ultrasound' AS รายการ,
    COUNT(CASE WHEN xi.xray_items_group IN ('6') AND xi.active_status = 'Y' THEN o.vn END) AS จำนวน,
    SUM(CASE WHEN xi.xray_items_group IN ('6') AND xi.active_status = 'Y' THEN op.sum_price ELSE 0 END) AS ยอดรวม
FROM ovst o
INNER JOIN opitemrece op ON op.vn = o.vn
LEFT JOIN xray_items xi ON xi.icode = op.icode
WHERE o.vstdate BETWEEN '2023-10-01' AND '2024-09-30'
  AND o.an IS NULL
  AND o.pttype IN ('T1','T2')

UNION ALL

SELECT
    'ค่า_MRI' AS รายการ,
    COUNT(CASE WHEN xi.xray_items_group IN ('4') AND xi.active_status = 'Y' THEN o.vn END) AS จำนวน,
    SUM(CASE WHEN xi.xray_items_group IN ('4') AND xi.active_status = 'Y' THEN op.sum_price ELSE 0 END) AS ยอดรวม
FROM ovst o
INNER JOIN opitemrece op ON op.vn = o.vn
LEFT JOIN xray_items xi ON xi.icode = op.icode
WHERE o.vstdate BETWEEN '2023-10-01' AND '2024-09-30'
  AND o.an IS NULL
  AND o.pttype IN ('T1','T2')

UNION ALL

SELECT
    'ค่า_CT' AS รายการ,
    COUNT(CASE WHEN xi.xray_items_group IN ('3') AND xi.active_status = 'Y' THEN o.vn END) AS จำนวน,
    SUM(CASE WHEN xi.xray_items_group IN ('3') AND xi.active_status = 'Y' THEN op.sum_price ELSE 0 END) AS ยอดรวม
FROM ovst o
INNER JOIN opitemrece op ON op.vn = o.vn
LEFT JOIN xray_items xi ON xi.icode = op.icode
WHERE o.vstdate BETWEEN '2023-10-01' AND '2024-09-30'
  AND o.an IS NULL
  AND o.pttype IN ('T1','T2')

UNION ALL

SELECT
    'ค่าตรวจด้วยเครื่องมือพิเศษ' AS รายการ,
    COUNT(CASE WHEN op.income IN ('09') THEN o.vn END) AS จำนวน,
    SUM(CASE WHEN op.income IN ('09') THEN op.sum_price ELSE 0 END) AS ยอดรวม
FROM ovst o
INNER JOIN opitemrece op ON op.vn = o.vn
LEFT JOIN xray_items xi ON xi.icode = op.icode
WHERE o.vstdate BETWEEN '2023-10-01' AND '2024-09-30'
  AND o.an IS NULL
  AND o.pttype IN ('T1','T2')

UNION ALL

SELECT
    'ค่าอุปกรณ์ของใช้และเครื่องมือทางการแพทย์' AS รายการ,
    COUNT(CASE WHEN op.income IN ('10') THEN o.vn END) AS จำนวน,
    SUM(CASE WHEN op.income IN ('10') THEN op.sum_price ELSE 0 END) AS ยอดรวม
FROM ovst o
INNER JOIN opitemrece op ON op.vn = o.vn
LEFT JOIN xray_items xi ON xi.icode = op.icode
WHERE o.vstdate BETWEEN '2023-10-01' AND '2024-09-30'
  AND o.an IS NULL
  AND o.pttype IN ('T1','T2')

UNION ALL

SELECT
    'ค่าหัตถการต่างๆ' AS รายการ,
    COUNT(CASE WHEN op.income IN ('11') THEN o.vn END) AS จำนวน,
    SUM(CASE WHEN op.income IN ('11') THEN op.sum_price ELSE 0 END) AS ยอดรวม
FROM ovst o
INNER JOIN opitemrece op ON op.vn = o.vn
LEFT JOIN xray_items xi ON xi.icode = op.icode
WHERE o.vstdate BETWEEN '2023-10-01' AND '2024-09-30'
  AND o.an IS NULL
  AND o.pttype IN ('T1','T2')

UNION ALL

SELECT
    'ค่าบริการผู้ป่วยนอก' AS รายการ,
    COUNT(CASE WHEN op.income IN ('12') THEN o.vn END) AS จำนวน,
    SUM(CASE WHEN op.income IN ('12') THEN op.sum_price ELSE 0 END) AS ยอดรวม
FROM ovst o
INNER JOIN opitemrece op ON op.vn = o.vn
LEFT JOIN xray_items xi ON xi.icode = op.icode
WHERE o.vstdate BETWEEN '2023-10-01' AND '2024-09-30'
  AND o.an IS NULL
  AND o.pttype IN ('T1','T2')

UNION ALL

SELECT
    'ค่าบริการทางพยาบาล' AS รายการ,
    COUNT(CASE WHEN op.income IN ('13') THEN o.vn END) AS จำนวน,
    SUM(CASE WHEN op.income IN ('13') THEN op.sum_price ELSE 0 END) AS ยอดรวม
FROM ovst o
INNER JOIN opitemrece op ON op.vn = o.vn
LEFT JOIN xray_items xi ON xi.icode = op.icode
WHERE o.vstdate BETWEEN '2023-10-01' AND '2024-09-30'
  AND o.an IS NULL
  AND o.pttype IN ('T1','T2')

UNION ALL

SELECT
    'ค่าบริการทางกายภาพบำบัดและทางเวชกรรมฟื้นฟู' AS รายการ,
    COUNT(CASE WHEN op.income IN ('14') THEN o.vn END) AS จำนวน,
    SUM(CASE WHEN op.income IN ('14') THEN op.sum_price ELSE 0 END) AS ยอดรวม
FROM ovst o
INNER JOIN opitemrece op ON op.vn = o.vn
LEFT JOIN xray_items xi ON xi.icode = op.icode
WHERE o.vstdate BETWEEN '2023-10-01' AND '2024-09-30'
  AND o.an IS NULL
  AND o.pttype IN ('T1','T2')

UNION ALL

SELECT
    'ค่าบริการฝังเข็มและค่าบริการการให้การบำบัดของผู้ประกอบโรคศิลปะอื่น' AS รายการ,
    COUNT(CASE WHEN op.income IN ('15') THEN o.vn END) AS จำนวน,
    SUM(CASE WHEN op.income IN ('15') THEN op.sum_price ELSE 0 END) AS ยอดรวม
FROM ovst o
INNER JOIN opitemrece op ON op.vn = o.vn
LEFT JOIN xray_items xi ON xi.icode = op.icode
WHERE o.vstdate BETWEEN '2023-10-01' AND '2024-09-30'
  AND o.an IS NULL
  AND o.pttype IN ('T1','T2')

UNION ALL

SELECT
    'ค่าบริการอื่นๆที่ไม่เกี่ยวกับการรักษาพยาบาลโดยตรง' AS รายการ,
    COUNT(CASE WHEN op.income IN ('16') THEN o.vn END) AS จำนวน,
    SUM(CASE WHEN op.income IN ('16') THEN op.sum_price ELSE 0 END) AS ยอดรวม
FROM ovst o
INNER JOIN opitemrece op ON op.vn = o.vn
LEFT JOIN xray_items xi ON xi.icode = op.icode
WHERE o.vstdate BETWEEN '2023-10-01' AND '2024-09-30'
  AND o.an IS NULL
  AND o.pttype IN ('T1','T2');
