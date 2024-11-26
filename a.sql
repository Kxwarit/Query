SELECT Count(CASE
    WHEN ic.income IN ('01')
    THEN ov.vn
    ELSE NULL
  END) AS visit_01ค่าห้องและค่าอาหาร,
  Count(CASE
    WHEN ic.income IN ('02')
    THEN ov.vn
    ELSE NULL
  END) AS visit_02ค่าอวัยวะเทียมและอุปกรณ์ในการบำบัดรักษาโรค,
  Count(CASE
    WHEN ic.income IN ('03', '04')
    THEN ov.vn
    ELSE NULL
  END) AS visit_0304ค่าเวชภัณฑ์ยา,
  Count(CASE
    WHEN ic.income IN ('05')
    THEN ov.vn
    ELSE NULL
  END) AS visit_05ค่าเวชภัณฑ์ที่มิใช่ยา,
  Count(CASE
    WHEN ic.income IN ('06')
    THEN ov.vn
    ELSE NULL
  END) AS visit_06ค่าบริการโลหิต,
  Count(CASE
    WHEN ic.income IN ('07')
    THEN ov.vn
    ELSE NULL
  END) AS visit_07ค่าตรวจวินิจฉัยทางเทคนิคการแพทย์และพยาธิวิทยา,
  Count(CASE
    WHEN ic.income IN ('08')
    THEN ov.vn
    ELSE NULL
  END) AS visit_08ค่าตรวจวินิจฉัยและรักษาทางรังสีวิทยา,
  Count(CASE
    WHEN ic.income IN ('09')
    THEN ov.vn
    ELSE NULL
  END) AS visit_09ค่าตรวจวินิจฉัยโดยวิธีพิเศษอื่น,
  Count(CASE
    WHEN ic.income IN ('10')
    THEN ov.vn
    ELSE NULL
  END) AS visit_10ค่าอุปกรณ์ของใช้และเครื่องมือทางการแพทย์,
  Count(CASE
    WHEN ic.income IN ('11')
    THEN ov.vn
    ELSE NULL
  END) AS visit_11ค่าทำหัตถการ,
  Count(CASE
    WHEN ic.income IN ('12')
    THEN ov.vn
    ELSE NULL
  END) AS visit_12ค่าบริการผู้ป่วยนอก,
  Count(CASE
    WHEN ic.income IN ('13')
    THEN ov.vn
    ELSE NULL
  END) AS visit_13ค่าบริการทางทันตกรรม,
  Count(CASE
    WHEN ic.income IN ('14')
    THEN ov.vn
    ELSE NULL
  END) AS visit_14ค่าบริการทางกายภาพบำบัดและทางเวชกรรมฟื้นฟู,
  Count(CASE
    WHEN ic.income IN ('15')
    THEN ov.vn
    ELSE NULL
  END) AS visit_15ค่าบริการฝังเข็ม,
  Count(CASE
    WHEN ic.income IN ('16')
    THEN ov.vn
    ELSE NULL
  END) AS visit_16ค่าบริการอื่น,
  Count(CASE
    WHEN xi.xray_items_group IN ('3')
    THEN xr.vn
    ELSE NULL
  END) AS visit_CT3,
  Count(CASE
    WHEN xi.xray_items_group IN ('4')
    THEN xr.vn
    ELSE NULL
  END) AS visit_MRI4,
  Count(CASE
    WHEN xi.ultrasound_item = 'Y'
    THEN xr.vn
    ELSE NULL
  END) AS visit_ultrasound,
  Sum(CASE
    WHEN ic.income IN ('01')
    THEN op.sum_price
    ELSE NULL
  END) AS price_01ค่าห้องและค่าอาหาร,
  Sum(CASE
    WHEN ic.income IN ('02')
    THEN op.sum_price
    ELSE NULL
  END) AS price_02ค่าอวัยวะเทียมและอุปกรณ์ในการบำบัดรักษาโรค,
  Sum(CASE
    WHEN ic.income IN ('03', '04')
    THEN op.sum_price
    ELSE NULL
  END) AS price_0304ค่าเวชภัณฑ์ยา,
  Sum(CASE
    WHEN ic.income IN ('05')
    THEN op.sum_price
    ELSE NULL
  END) AS price_05ค่าเวชภัณฑ์ที่มิใช่ยา,
  Sum(CASE
    WHEN ic.income IN ('06')
    THEN op.sum_price
    ELSE NULL
  END) AS price_06ค่าบริการโลหิต,
  Sum(CASE
    WHEN ic.income IN ('07')
    THEN op.sum_price
    ELSE NULL
  END) AS price_07ค่าตรวจวินิจฉัยทางเทคนิคการแพทย์และพยาธิวิทยา,
  Sum(CASE
    WHEN ic.income IN ('08')
    THEN op.sum_price
    ELSE NULL
  END) AS price_08ค่าตรวจวินิจฉัยและรักษาทางรังสีวิทยา,
  Sum(CASE
    WHEN ic.income IN ('09')
    THEN op.sum_price
    ELSE NULL
  END) AS price_09ค่าตรวจวินิจฉัยโดยวิธีพิเศษอื่น,
  Sum(CASE
    WHEN ic.income IN ('10')
    THEN op.sum_price
    ELSE NULL
  END) AS price_10ค่าอุปกรณ์ของใช้และเครื่องมือทางการแพทย์,
  Sum(CASE
    WHEN ic.income IN ('11')
    THEN op.sum_price
    ELSE NULL
  END) AS price_11ค่าทำหัตถการ,
  Sum(CASE
    WHEN ic.income IN ('12')
    THEN op.sum_price
    ELSE NULL
  END) AS price_12ค่าบริการผู้ป่วยนอก,
  Sum(CASE
    WHEN ic.income IN ('13')
    THEN op.sum_price
    ELSE NULL
  END) AS price_13ค่าบริการทางทันตกรรม,
  Sum(CASE
    WHEN ic.income IN ('14')
    THEN op.sum_price
    ELSE NULL
  END) AS price_14ค่าบริการทางกายภาพบำบัดและทางเวชกรรมฟื้นฟู,
  Sum(CASE
    WHEN ic.income IN ('15')
    THEN op.sum_price
    ELSE NULL
  END) AS price_15ค่าบริการฝังเข็ม,
  Sum(CASE
    WHEN ic.income IN ('16')
    THEN op.sum_price
    ELSE NULL
  END) AS price_16ค่าบริการอื่น,
  Sum(CASE
    WHEN xi.xray_items_group IN ('3')
    THEN xi.service_price
    ELSE NULL
  END) AS price_CT3,
  Sum(CASE
    WHEN xi.xray_items_group IN ('4')
    THEN xi.service_price
    ELSE NULL
  END) AS price_MRI4,
  Sum(CASE
    WHEN xi.ultrasound_item = 'Y'
    THEN xi.service_price
    ELSE NULL
  END) AS price_ultrasound
FROM ovst ov
  INNER JOIN opitemrece op ON op.vn = ov.vn
  LEFT JOIN pttype pt ON pt.pttype = ov.pttype
  LEFT JOIN nondrugitems n ON n.icode = op.icode
  LEFT JOIN income ic ON ic.income = n.income
  LEFT JOIN vn_stat vn ON vn.vn = ov.vn
  LEFT JOIN xray_report xr ON xr.vn = ov.vn AND xr.vn = op.vn
  LEFT JOIN xray_items xi ON xi.xray_items_code = xr.xray_items_code
WHERE ((xi.xray_items_group IN ('3', '4')) OR (xi.ultrasound_item = 'Y') OR (ic.income IN ('01', '02', '07', '08', '09', '11', '12', '03', '04', '05',
      '10', '13', '14', '15', '16', '06') AND ov.an IS NULL AND ov.vstdate BETWEEN '2023-10-01' AND '2024-09-30')) AND pt.pttype IN ('T1', 'T2')




      ----------------
      WITH DepartmentGroups AS ( 
    SELECT 
        o.vn,
        CASE 
            WHEN op.income IN ('01') THEN 'ค่าห้องและอาหาร ค่าเตียงสังเกตอาการ' 
            WHEN op.income IN ('02') THEN 'ค่าวัสดุอุปกรณ์เครื่องมือที่ใช้' 
            WHEN op.income IN ('03', '04') THEN 'ค่าเวชภัณฑ์ยา'
            WHEN op.income IN ('05') THEN 'ค่าเวชภัณฑ์ไม่ใช่ยา'
            WHEN op.income IN ('06') THEN 'ค่าบริการโลหิตและส่วนประกอบของโลหิต'
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
      AND o.an IS NULL  
)

SELECT 
    group_name,
    COUNT(vn) AS visit_count,
    SUM(sum_price) AS costs 
FROM DepartmentGroups 
WHERE group_name IN (
            'ค่าห้องและอาหาร ค่าเตียงสังเกตอาการ' ,
             'ค่าวัสดุอุปกรณ์เครื่องมือที่ใช้' ,
            'ค่าเวชภัณฑ์ยา',
            'ค่าเวชภัณฑ์ไม่ใช่ยา',
            'ค่าบริการโลหิตและส่วนประกอบของโลหิต',
            'ค่าตรวจวินิวฉัยทางเทคนิคการแพทย์และพยาธิ',
            'ค่าตรวจวินิจฉัยและรักษาทางรังสีวิทยา' ,
            'ค่า x-ray' ,
            'ค่า Ultrasound' ,
            'ค่า MRI' ,
             'ค่า CT' ,
            'ค่าตรวจด้วยเครื่องมือพิเศษ',
           'ค่าอุปกรณ์ของใช้และเครื่องมือทางการแพทย์' ,
            'ค่าหัตถการต่างๆ' ,
            'ค่าบริการผู้ป่วยนอก' ,
            'ค่าบริการทางพยาบาล' ,
           'ค่าบริการทางกายภาพบำบัดและทางเวชกรรมฟื้นฟู' ,
            'ค่าบริการฝังเข็ม และค่าบริการการให้การบำบัดของผู้ประกอบโรคศิลปะอื่น' ,
            'ค่าบริการอื่น ๆ ที่ไม่เกี่ยวกับการรักษาพยาบาลโดยตรง',
)
GROUP BY group_name 
ORDER BY 
    CASE 
        WHEN group_name = 'ค่าห้องและอาหาร ค่าเตียงสังเกตอาการ' THEN 1
        WHEN group_name = 'ค่าวัสดุอุปกรณ์เครื่องมือที่ใช้' THEN 2
        WHEN group_name = 'ค่าเวชภัณฑ์ยา' THEN 3
        WHEN group_name = 'ค่าเวชภัณฑ์ไม่ใช่ยา' THEN 4
        WHEN group_name = 'ค่าบริการโลหิตและส่วนประกอบของโลหิต' THEN 5
        WHEN group_name = 'ค่าตรวจวินิวฉัยทางเทคนิคการแพทย์และพยาธิ' THEN 6
        WHEN group_name = 'ค่าตรวจวินิจฉัยและรักษาทางรังสีวิทยา' THEN 7
        WHEN group_name = 'ค่า x-ray' THEN 8
        WHEN group_name = 'ค่า Ultrasound' THEN 9
        WHEN group_name = 'ค่า MRI' THEN 10
        WHEN group_name = 'ค่า CT' THEN 11
        WHEN group_name = 'ค่าตรวจด้วยเครื่องมือพิเศษ' THEN 12
        WHEN group_name = 'ค่าอุปกรณ์ของใช้และเครื่องมือทางการแพทย์' THEN 13
        WHEN group_name = 'ค่าหัตถการต่างๆ' THEN 14
        WHEN group_name = 'ค่าบริการผู้ป่วยนอก' THEN 15
        WHEN group_name = 'ค่าบริการทางพยาบาล' THEN 16
        WHEN group_name = 'ค่าบริการทางกายภาพบำบัดและทางเวชกรรมฟื้นฟู' THEN 17
        WHEN group_name = 'ค่าบริการฝังเข็ม และค่าบริการการให้การบำบัดของผู้ประกอบโรคศิลปะอื่น' THEN 18
        WHEN group_name = 'ค่าบริการอื่น ๆ ที่ไม่เกี่ยวกับการรักษาพยาบาลโดยตรง' THEN 19
    END
    ----------------------------
    WITH DepartmentGroups AS ( 
    SELECT 
        o.vn,
        CASE 
            WHEN op.income IN ('01') THEN 'ค่าห้องและอาหาร ค่าเตียงสังเกตอาการ' 
            WHEN op.income IN ('02') THEN 'ค่าวัสดุอุปกรณ์เครื่องมือที่ใช้' 
            WHEN op.income IN ('07') THEN 'ค่าตรวจวินิวฉัยทางเทคนิคการแพทย์และพยาธิ' 
            WHEN op.income IN ('08') THEN 'ค่าตรวจวินิจฉัยและรักษาทางรังสีวิทยา' 
            WHEN xi.xray_items_group IN ('8') AND xi.active_status = 'Y' THEN 'ค่า x-ray' 
            WHEN xi.xray_items_group IN ('6') AND xi.active_status = 'Y' THEN 'ค่า Ultrasound' 
            WHEN xi.xray_items_group IN ('4') AND xi.active_status = 'Y'  THEN 'ค่า MRI' 
            WHEN xi.xray_items_group IN ('3') AND xi.active_status = 'Y' THEN 'ค่า CT' 
            WHEN op.income IN ('09') THEN 'ค่าตรวจด้วยเครื่องมือพิเศษ' 
            WHEN op.income IN ('11') THEN 'ค่าหัตถการต่างๆ' 
            WHEN op.income IN ('12') THEN 'ค่าบริการผู้ป่วยนอก' 
            WHEN op.income IN ('03', '04') THEN 'ค่าเวชภัณฑ์ยา' 
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
    'ค่า x-ray',
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
        WHEN group_name = 'ค่า x-ray' THEN 5  
        WHEN group_name = 'ค่า Ultrasound' THEN 6
        WHEN group_name = 'ค่า MRI' THEN 7
        WHEN group_name = 'ค่า CT' THEN 8
        WHEN group_name = 'ค่าตรวจด้วยเครื่องมือพิเศษ' THEN 9
        WHEN group_name = 'ค่าหัตถการต่างๆ' THEN 10
        WHEN group_name = 'ค่าบริการผู้ป่วยนอก'  THEN 11
        WHEN group_name = 'ค่าเวชภัณฑ์ยา'  THEN 12
    END
