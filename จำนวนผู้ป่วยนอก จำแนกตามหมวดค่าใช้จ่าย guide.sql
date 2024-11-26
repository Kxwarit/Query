SELECT 
    COUNT(CASE WHEN op.income IN ('01') THEN o.vn END) AS ค่าห้องและอาหาร_ค่าเตียงสังเกตอาการ,
    COUNT(CASE WHEN op.income IN ('02') THEN o.vn END) AS ค่าวัสดุอุปกรณ์เครื่องมือที่ใช้,
    COUNT(CASE WHEN op.income IN ('03', '04') THEN o.vn END) AS ค่าเวชภัณฑ์ยา,
    COUNT(CASE WHEN op.income IN ('05') THEN o.vn END) AS ค่าเวชภัณฑ์ไม่ใช่ยา,
    COUNT(CASE WHEN op.income IN ('06') THEN o.vn END) AS ค่าบริการโลหิตและส่วนประกอบของโลหิต,
    COUNT(CASE WHEN op.income IN ('07') THEN o.vn END) AS ค่าตรวจวินิวฉัยทางเทคนิคการแพทย์และพยาธิ,
    COUNT(CASE WHEN op.income IN ('08') THEN o.vn END) AS ค่าตรวจวินิจฉัยและรักษาทางรังสีวิทยา,
    COUNT(CASE WHEN xi.xray_items_group IN ('8') AND xi.active_status = 'Y' THEN o.vn END) AS ค่า_x_ray,
    COUNT(CASE WHEN xi.xray_items_group IN ('6') AND xi.active_status = 'Y' THEN o.vn END) AS ค่า_Ultrasound,
    COUNT(CASE WHEN xi.xray_items_group IN ('4') AND xi.active_status = 'Y' THEN o.vn END) AS ค่า_MRI,
    COUNT(CASE WHEN xi.xray_items_group IN ('3') AND xi.active_status = 'Y' THEN o.vn END) AS ค่า_CT,
    COUNT(CASE WHEN op.income IN ('09') THEN o.vn END) AS ค่าตรวจด้วยเครื่องมือพิเศษ,
    COUNT(CASE WHEN op.income IN ('10') THEN o.vn END) AS ค่าอุปกรณ์ของใช้และเครื่องมือทางการแพทย์,
    COUNT(CASE WHEN op.income IN ('11') THEN o.vn END) AS ค่าหัตถการต่างๆ,
    COUNT(CASE WHEN op.income IN ('12') THEN o.vn END) AS ค่าบริการผู้ป่วยนอก,
    COUNT(CASE WHEN op.income IN ('13') THEN o.vn END) AS ค่าบริการทางพยาบาล,
    COUNT(CASE WHEN op.income IN ('14') THEN o.vn END) AS ค่าบริการทางกายภาพบำบัดและทางเวชกรรมฟื้นฟู,
    COUNT(CASE WHEN op.income IN ('15') THEN o.vn END) AS ค่าบริการฝังเข็มและค่าบริการการให้การบำบัดของผู้ประกอบโรคศิลปะอื่น,
    COUNT(CASE WHEN op.income IN ('16') THEN o.vn END) AS ค่าบริการอื่นๆที่ไม่เกี่ยวกับการรักษาพยาบาลโดยตรง
FROM ovst o
INNER JOIN opitemrece op ON op.vn = o.vn
LEFT JOIN xray_items xi ON xi.icode = op.icode 
WHERE o.vstdate BETWEEN '2023-10-01' AND '2024-09-30' 
  AND o.an IS NULL  
  AND o.pttype IN ('T1','T2');
---------------
SELECT 
    COUNT(CASE WHEN op.income IN ('01') THEN o.vn END) AS ค่าห้องและอาหาร_ค่าเตียงสังเกตอาการ,
    SUM(CASE WHEN op.income IN ('01') THEN op.sum_price ELSE 0 END) AS sum_ค่าห้องและอาหาร_ค่าเตียงสังเกตอาการ,
    
    COUNT(CASE WHEN op.income IN ('02') THEN o.vn END) AS ค่าวัสดุอุปกรณ์เครื่องมือที่ใช้,
    SUM(CASE WHEN op.income IN ('02') THEN op.sum_price ELSE 0 END) AS sum_ค่าวัสดุอุปกรณ์เครื่องมือที่ใช้,
    
    COUNT(CASE WHEN op.income IN ('03', '04') THEN o.vn END) AS ค่าเวชภัณฑ์ยา,
    SUM(CASE WHEN op.income IN ('03', '04') THEN op.sum_price ELSE 0 END) AS sum_ค่าเวชภัณฑ์ยา,
    
    COUNT(CASE WHEN op.income IN ('05') THEN o.vn END) AS ค่าเวชภัณฑ์ไม่ใช่ยา,
    SUM(CASE WHEN op.income IN ('05') THEN op.sum_price ELSE 0 END) AS sum_ค่าเวชภัณฑ์ไม่ใช่ยา,
    
    COUNT(CASE WHEN op.income IN ('06') THEN o.vn END) AS ค่าบริการโลหิตและส่วนประกอบของโลหิต,
    SUM(CASE WHEN op.income IN ('06') THEN op.sum_price ELSE 0 END) AS sum_ค่าบริการโลหิตและส่วนประกอบของโลหิต,
    
    COUNT(CASE WHEN op.income IN ('07') THEN o.vn END) AS ค่าตรวจวินิวฉัยทางเทคนิคการแพทย์และพยาธิ,
    SUM(CASE WHEN op.income IN ('07') THEN op.sum_price ELSE 0 END) AS sum_ค่าตรวจวินิวฉัยทางเทคนิคการแพทย์และพยาธิ,
    
    COUNT(CASE WHEN op.income IN ('08') THEN o.vn END) AS ค่าตรวจวินิจฉัยและรักษาทางรังสีวิทยา,
    SUM(CASE WHEN op.income IN ('08') THEN op.sum_price ELSE 0 END) AS sum_ค่าตรวจวินิจฉัยและรักษาทางรังสีวิทยา,
    
    COUNT(CASE WHEN xi.xray_items_group IN ('8') AND xi.active_status = 'Y' THEN o.vn END) AS ค่า_x_ray,
    SUM(CASE WHEN xi.xray_items_group IN ('8') AND xi.active_status = 'Y' THEN op.sum_price ELSE 0 END) AS sum_ค่า_x_ray,
    
    COUNT(CASE WHEN xi.xray_items_group IN ('6') AND xi.active_status = 'Y' THEN o.vn END) AS ค่า_Ultrasound,
    SUM(CASE WHEN xi.xray_items_group IN ('6') AND xi.active_status = 'Y' THEN op.sum_price ELSE 0 END) AS sum_ค่า_Ultrasound,
    
    COUNT(CASE WHEN xi.xray_items_group IN ('4') AND xi.active_status = 'Y' THEN o.vn END) AS ค่า_MRI,
    SUM(CASE WHEN xi.xray_items_group IN ('4') AND xi.active_status = 'Y' THEN op.sum_price ELSE 0 END) AS sum_ค่า_MRI,
    
    COUNT(CASE WHEN xi.xray_items_group IN ('3') AND xi.active_status = 'Y' THEN o.vn END) AS ค่า_CT,
    SUM(CASE WHEN xi.xray_items_group IN ('3') AND xi.active_status = 'Y' THEN op.sum_price ELSE 0 END) AS sum_ค่า_CT,
    
    COUNT(CASE WHEN op.income IN ('09') THEN o.vn END) AS ค่าตรวจด้วยเครื่องมือพิเศษ,
    SUM(CASE WHEN op.income IN ('09') THEN op.sum_price ELSE 0 END) AS sum_ค่าตรวจด้วยเครื่องมือพิเศษ,
    
    COUNT(CASE WHEN op.income IN ('10') THEN o.vn END) AS ค่าอุปกรณ์ของใช้และเครื่องมือทางการแพทย์,
    SUM(CASE WHEN op.income IN ('10') THEN op.sum_price ELSE 0 END) AS sum_ค่าอุปกรณ์ของใช้และเครื่องมือทางการแพทย์,
    
    COUNT(CASE WHEN op.income IN ('11') THEN o.vn END) AS ค่าหัตถการต่างๆ,
    SUM(CASE WHEN op.income IN ('11') THEN op.sum_price ELSE 0 END) AS sum_ค่าหัตถการต่างๆ,
    
    COUNT(CASE WHEN op.income IN ('12') THEN o.vn END) AS ค่าบริการผู้ป่วยนอก,
    SUM(CASE WHEN op.income IN ('12') THEN op.sum_price ELSE 0 END) AS sum_ค่าบริการผู้ป่วยนอก,
    
    COUNT(CASE WHEN op.income IN ('13') THEN o.vn END) AS ค่าบริการทางพยาบาล,
    SUM(CASE WHEN op.income IN ('13') THEN op.sum_price ELSE 0 END) AS sum_ค่าบริการทางพยาบาล,
    
    COUNT(CASE WHEN op.income IN ('14') THEN o.vn END) AS ค่าบริการทางกายภาพบำบัดและทางเวชกรรมฟื้นฟู,
    SUM(CASE WHEN op.income IN ('14') THEN op.sum_price ELSE 0 END) AS sum_ค่าบริการทางกายภาพบำบัดและทางเวชกรรมฟื้นฟู,
    
    COUNT(CASE WHEN op.income IN ('15') THEN o.vn END) AS ค่าบริการฝังเข็มและค่าบริการการให้การบำบัดของผู้ประกอบโรคศิลปะอื่น,
    SUM(CASE WHEN op.income IN ('15') THEN op.sum_price ELSE 0 END) AS sum_ค่าบริการฝังเข็มและค่าบริการการให้การบำบัดของผู้ประกอบโรคศิลปะอื่น,
    
    COUNT(CASE WHEN op.income IN ('16') THEN o.vn END) AS ค่าบริการอื่นๆที่ไม่เกี่ยวกับการรักษาพยาบาลโดยตรง,
    SUM(CASE WHEN op.income IN ('16') THEN op.sum_price ELSE 0 END) AS sum_ค่าบริการอื่นๆที่ไม่เกี่ยวกับการรักษาพยาบาลโดยตรง
FROM ovst o
INNER JOIN opitemrece op ON op.vn = o.vn
LEFT JOIN xray_items xi ON xi.icode = op.icode 
WHERE o.vstdate BETWEEN '2023-10-01' AND '2024-09-30' 
  AND o.an IS NULL  
  AND o.pttype IN ('T1','T2');
  ----------------
  