SELECT
    o.oqueue, 
    o.hn, 
    o.vn, 
    p.cid, 
    CONCAT(p.pname,'',p.fname,' ',p.lname) AS pt_name, 
    v.age_y, 
    o.vstdate, 
    o.vsttime, 
    er.name, 
    ep.name AS er_pt_type, 
    ee.name AS emergency_type, 
    el.er_emergency_level_name AS emergency_level_id, 
    s.bpd, 
    s.bps, 
    s.temperature, 
    s.pulse, 
    s.rr,
    s.cc, 
    s.pe, 
    e.er_list, 
    v.pdx, 
    v.dx0, 
    v.dx1, 
    v.dx2, 
    v.dx3, 
    v.dx4, 
    v.dx5, 
    ed.name AS dch_type, 
    els.er_leave_status_name, 
    p.addrpart, 
    p.moopart, 
    t3.name AS tumbon, 
    t2.name AS amphur, 
    t1.name AS province

FROM ovst AS o
JOIN vn_stat AS v ON  v.vn = o.vn
JOIN er_regist AS e ON e.vn = o.vn
LEFT JOIN er_pt_type AS ep ON ep.er_pt_type = e.er_pt_type
LEFT JOIN er_emergency_type AS ee ON ee.er_emergency_type = e.er_emergency_type
LEFT JOIN er_dch_type AS ed ON  ed.er_dch_type = e.er_dch_type
LEFT JOIN er_emergency_level AS el ON el.er_emergency_level_id = e.er_emergency_level_id
LEFT JOIN er_period AS er ON  er.er_period = e.er_period
LEFT JOIN patient AS p ON  p.hn = o.hn
LEFT JOIN opdscreen AS s ON s.vn = o.vn
LEFT JOIN er_leave_status AS els ON  els.er_leave_status_id = e.er_leave_status_id
LEFT JOIN thaiaddress AS t1 ON t1.chwpart = p.chwpart AND t1.codetype = '1'
LEFT JOIN thaiaddress AS t2 ON  t2.chwpart = p.chwpart AND t2.amppart = p.amppart AND t2.codetype = '2'
LEFT JOIN thaiaddress AS t3 ON t3.chwpart = p.chwpart AND t3.amppart = p.amppart AND t3.tmbpart = p.tmbpart AND t3.codetype = '3'
WHERE o.vstdate BETWEEN '2025-01-01' AND '2025-01-31' AND e.doctor_tx_time IS NOT NULL
ORDER BY o.vstdate ASC, o.vsttime ASC