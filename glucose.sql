SELECT o.vstdate, 
o.vn, 
p.cid, 
CONCAT(p.pname, p.fname, ' ', p.lname) AS patient_name,
p.addrpart,
p.moopart,
STRING_AGG(CASE WHEN th.amppart = p.amppart  AND th.tmbpart = p.tmbpart THEN th.name ELSE NULL END, ', ') AS tmb,
STRING_AGG(CASE WHEN th.amppart = p.amppart AND th.tmbpart = '00' THEN th.name ELSE NULL END, ', ') AS amp,
STRING_AGG(CASE WHEN th.amppart = '00' AND th.tmbpart = '00' THEN th.name ELSE NULL END, ', ') AS chw, 
STRING_AGG( DISTINCT CASE 
 WHEN p.hometel <> '' AND p.hometel ~ '^[0-9-]+$' AND p.hometel !~ '^(.)\1*$' THEN p.hometel 
 WHEN p.mobile_phone_number <> '' AND p.mobile_phone_number ~ '^[0-9-]+$' AND p.mobile_phone_number !~ '^(.)\1*$' THEN p.mobile_phone_number 
 WHEN p.informtel <> '' AND p.informtel ~ '^[0-9-]+$' AND p.informtel !~ '^(.)\1*$' THEN p.informtel 
ELSE NULL END, ', ') AS contact,
os.cc,
lo.lab_order_result
FROM ovst o
LEFT OUTER JOIN opdscreen os ON os.vn = o.vn
LEFT OUTER JOIN lab_head lh ON lh.vn = o.vn
LEFT OUTER JOIN lab_order lo ON lo.lab_order_number = lh.lab_order_number
LEFT OUTER JOIN patient p ON p.hn = o.hn
LEFT OUTER JOIN thaiaddress th ON th.chwpart = p.chwpart 
WHERE o.vstdate BETWEEN '2024-11-04' AND '2025-01-24' 
AND (os.cc LIKE '%ส่งตรวจ%' OR os.cc LIKE '%ส่งเจาะ%' OR os.cc LIKE '%ส่งเลือด%' OR os.cc LIKE '%ส่งตวรจ%') 
AND (os.cc LIKE '%PCU%' OR os.cc LIKE '%สต%' )  
AND lo.lab_items_code = '3604' 
AND (lo.lab_order_result IS NOT NULL  OR lo.lab_order_result <> '...') 
AND lo.lab_order_result BETWEEN '110' AND '125'
GROUP BY  o.vn, o.vstdate, o.vn, p.cid, p.pname, p.fname, p.lname, p.addrpart, p.moopart, os.cc, lo.lab_order_result   
---------------

SELECT o.vstdate, 
o.vn, 
p.cid, 
CONCAT(p.pname, p.fname, ' ', p.lname) AS patient_name,
p.addrpart,
p.moopart,
STRING_AGG(CASE WHEN th.amppart = p.amppart  AND th.tmbpart = p.tmbpart THEN th.name ELSE NULL END, ', ') AS tmb,
STRING_AGG(CASE WHEN th.amppart = p.amppart AND th.tmbpart = '00' THEN th.name ELSE NULL END, ', ') AS amp,
STRING_AGG(CASE WHEN th.amppart = '00' AND th.tmbpart = '00' THEN th.name ELSE NULL END, ', ') AS chw, 
STRING_AGG( DISTINCT CASE 
 WHEN p.hometel <> '' AND p.hometel ~ '^[0-9-]+$' AND p.hometel !~ '^(.)\1*$' THEN p.hometel 
 WHEN p.mobile_phone_number <> '' AND p.mobile_phone_number ~ '^[0-9-]+$' AND p.mobile_phone_number !~ '^(.)\1*$' THEN p.mobile_phone_number 
 WHEN p.informtel <> '' AND p.informtel ~ '^[0-9-]+$' AND p.informtel !~ '^(.)\1*$' THEN p.informtel 
ELSE NULL END, ', ') AS contact,
os.cc,
lo.lab_order_result,
CASE 
    WHEN os.cc LIKE '%ท่าทองใหม่%' THEN 'ท่าทองใหม่' 
    WHEN os.cc LIKE '%ท่าทอง%' AND (os.cc NOT LIKE '%ท่าทองใหม่%' AND os.cc NOT LIKE '%ปากน้ำท่าทอง%') THEN 'ท่าทอง' 
    WHEN os.cc ILIKE '%PCU%' THEN 'PCUกะแดะ'
    WHEN os.cc LIKE '%ทุ่งกง%' THEN 'ทุ่งกง' 
    WHEN os.cc LIKE '%กรูด%' THEN 'กรูด' 
    WHEN os.cc LIKE '%ช้างซ้าย%' OR os.cc LIKE '%ซ้างซ้าย%' THEN 'ช้างซ้าย' 
    WHEN os.cc LIKE '%พลายวาส%' THEN 'พลายวาส' 
    WHEN os.cc LIKE '%ป่าร่อน%' THEN 'ป่าร่อน' 
    WHEN os.cc LIKE '%ตะเคียนทอง%' THEN 'ตะเคียนทอง' 
    WHEN os.cc LIKE '%ช้างขวา%' THEN 'ช้างขวา'  
    WHEN os.cc LIKE '%ท่าอุแท%' THEN 'ท่าอุแท' 
    WHEN os.cc LIKE '%ทุ่งรัง%' THEN 'ทุ่งรัง' 
    WHEN os.cc LIKE '%คลองสระ%' THEN 'คลองสระ'
    WHEN os.cc LIKE '%หัวหมากล่าง%' THEN 'หัวหมากล่าง'
    WHEN os.cc LIKE '%ปากน้ำท่าทอง%' THEN 'ปากน้ำท่าทอง'
    WHEN os.cc LIKE '%กงตาก%' THEN 'กงตาก'
    WHEN os.cc LIKE '%หมู่บ้านตัวอย่าง%' THEN 'หมู่บ้านตัวอย่าง'
    WHEN os.cc LIKE '%วังไทร%' THEN 'วังไทร'
ELSE NULL END sub  
FROM ovst o
LEFT OUTER JOIN opdscreen os ON os.vn = o.vn
LEFT OUTER JOIN lab_head lh ON lh.vn = o.vn
LEFT OUTER JOIN lab_order lo ON lo.lab_order_number = lh.lab_order_number
LEFT OUTER JOIN patient p ON p.hn = o.hn
LEFT OUTER JOIN thaiaddress th ON th.chwpart = p.chwpart 
WHERE o.vstdate BETWEEN '2024-11-04' AND '2025-01-24' 
AND (os.cc LIKE '%ส่งตรวจ%' OR os.cc LIKE '%ส่งเจาะ%' OR os.cc LIKE '%ส่งเลือด%' OR os.cc LIKE '%ส่งตวรจ%') 
AND (os.cc LIKE '%PCU%' OR os.cc LIKE '%สต%' )  
AND lo.lab_items_code = '3604' 
AND (lo.lab_order_result IS NOT NULL  OR lo.lab_order_result <> '...') 
AND lo.lab_order_result BETWEEN '110' AND '125'
GROUP BY  o.vn, o.vstdate, o.vn, p.cid, p.pname, p.fname, p.lname, p.addrpart, p.moopart, os.cc, lo.lab_order_result   
