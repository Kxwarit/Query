SELECT DISTINCT p.hn,
  i.regdate,
  Concat_Ws('', p.pname, p.fname, '  ', p.lname) AS ptname,
  p.citizenship,
  p.birthday,
  Concat_Ws('', p.addrpart, ' ม. ', p.moopart, ' ', t.full_name) AS fiam,
  p.po_code,
  p.bloodgrp,
  Concat_Ws('', p.fathername, ' ', p.fatherlname) AS ptfather,
  p.informaddr,
  p.informname,
  p.informrelation,
  p.informtel,
  Concat_Ws('', p.mathername, '  ', p.motherlname) AS ptmother,
  p.cid,
  p.father_cid,
  p.mother_cid,
  p.country,
  p.pttype,
  y.expire_date,
  y.pttypeno,
  y.begin_date,
  y.hospmain,
  y.hospsub,
  s.name AS sexname,
  n.name AS namenationality,
  r.name AS namereligion,
  m.name AS namemarrystatus,
  o.name AS nameoccupation,
  p1.name AS namepttype,
  COALESCE(a.age_y,v.age_y) as age_y,
  p.hometel,
  Concat_Ws('', h1.hosptype, h1.name) AS hospmain,
  Concat_Ws('', h2.hosptype, h2.name) AS hospsub,
  p.lang,
  CASE
    WHEN Concat(p.spsname, ' ', p.spslname) IS NULL OR Concat(p.spsname, ' ', p.spslname) = ''
    THEN '-'
    ELSE Concat(p.spsname, ' ', p.spslname)
  END AS spspsname,
  p.drugallergy,
  p.firstday,
  CASE
    WHEN p.drugallergy = ''
    THEN 'ไม่มีประวัติการแพ้ยา และแพ้อื่นๆ'
    ELSE ''
  END AS no_alg,
  CASE
    WHEN p.bloodgrp = ''
    THEN 'ไม่ทราบหมู่เลือด'
    ELSE ''
  END AS no_bloodgrp,
  ou.name,
  p.mobile_phone_number,
  i.doctor,
  i.staff,
  oh.cc_persist_disease,
  u.officer_name
FROM ovst ov
  LEFT OUTER JOIN ipt i ON i.an = ov.an OR i.vn = ov.vn
  INNER JOIN patient p ON ov.hn = p.hn
  LEFT OUTER JOIN vn_stat v ON v.vn = ov.vn
  LEFT OUTER JOIN an_stat a ON a.an = i.an
  LEFT OUTER JOIN opduser ou ON ou.loginname = ov.staff
  LEFT OUTER JOIN visit_pttype y ON y.vn = ov.vn
  LEFT OUTER JOIN sex s ON s.code = p.sex
  LEFT OUTER JOIN nationality n ON n.nationality = p.nationality
  LEFT OUTER JOIN religion r ON r.religion = p.religion
  LEFT OUTER JOIN marrystatus m ON m.code = p.marrystatus
  LEFT OUTER JOIN thaiaddress t ON t.addressid = v.aid
  LEFT OUTER JOIN occupation o ON o.occupation = p.occupation
  LEFT OUTER JOIN pttype p1 ON p1.pttype = p.pttype
  LEFT OUTER JOIN hospcode h1 ON h1.hospcode = y.hospmain
  LEFT OUTER JOIN hospcode h2 ON h2.hospcode = y.hospsub
  LEFT OUTER JOIN opd_ill_history oh ON oh.hn = p.hn
  LEFT OUTER JOIN opdscreen_cc_list ocl ON ocl.vn = ov.vn
  LEFT OUTER JOIN officer u ON u.officer_login_name = ocl.staff
WHERE i.an = :an