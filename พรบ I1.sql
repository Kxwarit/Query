SELECT  
    COUNT(DISTINCT o.vn) AS visit_count, 
    COALESCE(SUM(CASE WHEN o.pttype = "H5" THEN vv.income END), 0) + COALESCE(SUM(CASE WHEN i.pttype = "I5" THEN aa.income END), 0) AS income,

    COALESCE(SUM(CASE WHEN o.pttype = "H5" THEN vv.uc_money END), 0) + COALESCE(SUM(CASE WHEN i.pttype = "I5" THEN aa.uc_money END), 0) AS ลูกหนี้,

    COALESCE(SUM(CASE WHEN o.pttype = "H5" THEN vv.paid_money END), 0) + COALESCE(SUM(CASE WHEN i.pttype = "I5" THEN aa.paid_money END), 0) AS ต้องชำระ,

    COALESCE(SUM(CASE WHEN o.pttype = "H5" THEN (vv.paid_money - vv.remain_money) END), 0) + COALESCE(SUM(CASE WHEN i.pttype = "I5" THEN (aa.paid_money - aa.remain_money) END), 0) AS ชำระ,

    COALESCE(SUM(CASE WHEN o.pttype = "H5" THEN vv.remain_money END), 0) + COALESCE(SUM(CASE WHEN i.pttype = "I5" THEN aa.remain_money END), 0) AS รอชำระ
FROM ovst o
LEFT JOIN ipt i ON i.an = o.an 
LEFT JOIN vn_stat vv ON vv.vn = o.vn
LEFT JOIN an_stat aa ON aa.an = i.an
WHERE (i.an IS NULL AND o.vstdate BETWEEN "2022-10-01" AND "2023-09-30" AND o.pttype = "H5")
OR (i.an IS NOT NULL AND i.dchdate BETWEEN "2022-10-01" AND "2023-09-30" AND i.pttype = "H5" )
--GROUP BY o.hn
--ORDER BY visit_count DESC;