SELECT 
  d.doctor_cert_date,
  CONCAT(COALESCE(p.pname, ''), COALESCE(p.fname, ''), ' ', COALESCE(p.lname, '')) AS patient_name,
  p.birthday,
  CONCAT(EXTRACT(YEAR FROM AGE(o.vstdate, p.birthday)), ' ปี ', 
         EXTRACT(MONTH FROM AGE(o.vstdate, p.birthday)), ' เดือน', 
         EXTRACT(DAY FROM AGE(o.vstdate, p.birthday)), ' วัน') AS age,
  p.hn,
  i.an,
  i.regdate,
  os.cc,
  os.pe,
  os.temperature,
  os.bps,
  os.bpd,
  os.rr,
  os.hr,
  os.o2sat,
  d.note1,
  d.note2,
  (d.date2 - d.date1) + 1 AS date_diff,
  doc.name AS dname,
  doc.licenseno,
  oid.icd10,
  icd.name
FROM 
  doctor_cert d
  LEFT OUTER JOIN ovst o ON o.vn = d.vn
  LEFT OUTER JOIN ipt i ON i.an = o.an
  LEFT OUTER JOIN patient p ON p.hn = o.hn
  LEFT OUTER JOIN opdscreen os ON os.vn = o.vn
  LEFT OUTER JOIN doctor doc ON doc.code = d.doctor_code
  LEFT OUTER JOIN (
    SELECT oid.vn, oid.icd10, oid.diagtype, NULL AS an
    FROM ovstdiag oid
    WHERE oid.diagtype = '1'
    UNION ALL
    SELECT NULL AS vn, iptd.icd10, iptd.diagtype, iptd.an
    FROM iptdiag iptd
    WHERE iptd.diagtype = '1'
  ) oid ON (oid.vn = o.vn AND i.an IS NULL) OR (oid.an = i.an AND i.an IS NOT NULL)
  LEFT OUTER JOIN icd101 icd ON icd.code = oid.icd10
WHERE 
  d.doctor_cert_id = :doctor_cert_id;
