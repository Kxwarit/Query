SELECT
    p.hn,
    CONCAT(p.pname, p.fname, ' ', p.lname) AS ptname,
    p.sex,
    p.birthday,
    d.name AS request_doctor_name,
    os.cc,
    h.lab_order_number,
    h.order_time,
    h.order_date,
    h.form_name,
    o.vstdate,
    concat(v.age_y, ' ปี ', v.age_m, ' เดือน ', v.age_d, ' วัน ') as age, 
    h.reporter_name
FROM ovst o
    LEFT JOIN lab_head h ON h.vn = o.vn
    LEFT JOIN lab_order l ON l.lab_order_number = h.lab_order_number
    LEFT JOIN lab_items i ON i.lab_items_code = l.lab_items_code
    LEFT JOIN lab_items_sub_group ig ON ig.lab_items_sub_group_code = i.lab_items_sub_group_code
    LEFT JOIN patient p ON p.hn = h.hn
    LEFT JOIN doctor d ON d.code = h.doctor_code
    LEFT JOIN vn_stat v ON v.vn = h.vn
    INNER JOIN opdscreen os ON os.vn = h.vn
WHERE o.vstdate BETWEEN '2025-06-09' AND '2025-06-09'
    AND o.main_dep = '053'
    AND i.lab_items_code IN ('3438', '3001')
    AND ( l.lab_order_result <> '' OR l.lab_order_result <> '...' )
GROUP BY 
    h.lab_order_number,o.vn, p.hn, p.pname, p.fname, p.lname, p.sex, p.birthday, d.name, 
    os.cc, h.order_time, h.order_date, h.form_name, 
    o.vstdate, v.age_y, v.age_m, v.age_d, h.reporter_name
HAVING COUNT(DISTINCT i.lab_items_code) = 2
ORDER BY o.vn, h.lab_order_number