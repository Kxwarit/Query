//สถิติการวินิจฉัยโรคของผู้ป่วยนอก : ในส่วนของ summary คิดว่าไม่ตรงกับยอดรวมของสถิติการวินิจฉัยโรคของผู้ป่วยนอก
SELECT icd.code, icd.name, count(distinct i1.vn) as cc_vn, count(distinct i1.hn) as cc_hn 
FROM icd101 icd 
LEFT JOIN (select o.vn, od.pdx, o.hn FROM ovst o, vn_stat od WHERE o.vn = od.vn and o.vstdate between '2023-10-01' and '2024-09-30') i1 on i1.pdx = icd.code
WHERE icd.code NOT LIKE 'Z%'
GROUP BY icd.code 
ORDER BY cc_vn DESC
-------------------------------------------

//สถิติการบริการผู้ป่วยแบ่งตามเดือน : ข้อมูลตรงกัน 
SELECT count(distinct o.vn) as ครั้ง , count(distinct o.hn) as คน
FROM ovst o
WHERE o.vstdate between '2023-12-01' and '2023-12-31'
------------------------- 

//สถิติการบริการผู้ป่วยแบ่งตามแผนก : ข้อมูลตรงกัน
WITH DepartmentGroups AS ( 
    SELECT 
        o.vn,
        CASE 
            WHEN o.main_dep IN ('118', '119') THEN 'ANC' 
            WHEN o.main_dep = '011' THEN 'ER' 
            WHEN o.main_dep IN ('137', '121', '028', '054', '123', '055', '122', '053') THEN 'NCD' 
            WHEN o.main_dep IN ('007', '120', '021', '136', '138', '139', '107', '015', '019', '096', '130', '014', '020', '010', '117', '099', '098', '027', '052', '031', '012', '091') THEN 'OPD' 
            WHEN o.main_dep IN ('042', '131') THEN 'กายภาพ' 
            WHEN o.main_dep = '029' THEN 'กุมารเวชกรรม' 
            WHEN o.main_dep IN ('034', '124', '037', '045') THEN 'จิตเวช' 
            WHEN o.main_dep = '005' THEN 'ทันตกรรม' 
            WHEN o.main_dep IN ('081', '114') THEN 'นรีเวชกรรม' 
            WHEN o.main_dep = '135' THEN 'แพทย์แผนจีน' 
            WHEN o.main_dep = '134' THEN 'แพทย์แผนไทย' 
            WHEN o.main_dep IN ('104', '080') THEN 'ศัลยกรรม' 
            WHEN o.main_dep IN ('032', '105') THEN 'ศัลยกรรมกระดูก' 
            WHEN o.main_dep = '017' THEN 'ห้องคลอด' 
            WHEN o.main_dep = '040' THEN 'ห้องฉีดยา ทำแผล' 
            WHEN o.main_dep = '049' THEN 'ห้องผ่าตัด' 
            ELSE 'อื่นๆ'
        END AS group_name,
        p.sex as sex
    FROM ovst o 
    LEFT OUTER JOIN patient p ON p.hn = o.hn
    WHERE o.vstdate BETWEEN '2023-10-01' AND '2024-09-30'
    )
SELECT 
    group_name,
    COUNT(vn) AS visit_count,
    COUNT(CASE WHEN sex = '1' THEN vn END) as ชาย,
    COUNT(CASE WHEN sex = '2' THEN vn END) as หญิง 
FROM DepartmentGroups 
GROUP BY group_name 
UNION ALL
SELECT 
    'รวมทั้งหมด' AS group_name,
    COUNT(vn) AS visit_count,
    COUNT(CASE WHEN sex = '1' THEN vn END) as ชาย,
    COUNT(CASE WHEN sex = '2' THEN vn END) as หญิง 
FROM DepartmentGroups;

--------------------------------------
//สิทธิการรักษาของผู้ป่วยนอก : ข้อมูลตรงกัน
WITH DepartmentGroups AS (
    SELECT 
        o.vn, 
        CASE 
            WHEN o.pttype IN ('D1','D2','K1','F1','F2','T1','T2','T3','T4','U1','U2','U3','U4','U5','U6','U7','U8','U9','V1','V2','V3','V4','V5','V6','V7','V8','V9','W1','W2','W3','W4','W5','W6','W7','W8','W9','X1','X2','X3','X4','X5','X6','X7','X8','X9','Y1','Y2','Y3','Y4','Y5','Y6','Y7','Y8','Y9','Z5','Z6','Z7','Z8','Z9') THEN 'UCS หลักประกันสุขภาพ' 
            WHEN o.pttype IN ('O1','O2','O3','O4','O5','A2') THEN 'OFC ข้าราชการกรมบัญชีกลาง' 
            WHEN o.pttype IN ('L1','L2','L3','L4','L5','L6','L7','L8','L9','A1','A4') THEN 'LGO ข้าราชการท้องถิ่น' 
            WHEN o.pttype IN ('B1','B2','B3','B4','B5','A3') THEN 'BKK ข้าราชการกรุงเทพมหานคร' 
            WHEN o.pttype IN ('S0','S1','S2','S3','S4','S5','S6','S7','S8','S9','Q1','Q2','Z4') THEN 'SSS ประกันสังคม' 
            WHEN o.pttype = 'Z3' THEN 'NHS สปสช.' 
            WHEN o.pttype = 'ST' THEN 'STPบุคคลผู้มีปัญหาสถานะสิทธิ' 
            WHEN o.pttype IN ('C1','C2','C3','C4','C5','C6','E1','E2','E3','E4','G1','P1','P2','P3','Q0') THEN 'เบิกต้นสังกัด/หน่วยงานรัฐอื่น' 
            WHEN o.pttype = 'J1' THEN 'ประกันอุบัติเหตุนักเรียน' 
            WHEN o.pttype IN ('J4','J6') THEN 'ประกันชีวิต' 
            WHEN o.pttype IN ('H5','I1') THEN 'อุบัติเหตุจราจร' 
            WHEN o.pttype IN ('H3','N1','N2','N3','N4','N5','N6','N7','F3') THEN 'แรงงานต่างด้าว' 
            WHEN o.pttype IN ('I2','I3','I4') THEN 'ตรวจสุขภาพ' 
            WHEN o.pttype IN ('H0','H1','H2','H4') THEN 'ชำระเงินเอง' 
            WHEN o.pttype = 'J3' THEN 'สิ่งส่งตรวจหน่วยงานภาครัฐ' 
            WHEN o.pttype IN ('J2','J5') THEN 'อื่นๆ' 
            ELSE 'ไม่ตรงสิทธิ' 
        END AS eligibility_group 
    FROM ovst o 
    WHERE o.vstdate BETWEEN '2023-10-01' AND '2024-09-30' 
) 
SELECT 
    eligibility_group, 
    COUNT(vn) AS visit_count 
FROM DepartmentGroups 
GROUP BY eligibility_group 
UNION ALL
SELECT 
    'รวมทั้งหมด' AS eligibility_group, 
    COUNT(vn) AS visit_count 
FROM DepartmentGroups
----------------------------------

//สถิติการจำหน่ายผู้ป่วยออกแบ่งตามเดือน : ข้อมูลตรงกัน
SELECT *
FROM ipt i
WHERE i.dchdate between '2024-01-01' and '2024-01-31'
------------------
//สถิติวอร์ดที่เข้าแอดมิทมากที่สุด : ตรงตามคิวรี่ แต่การย้ายเตียงต้องมาเกี่ยวด้วยหรอมั้ย
SELECT w.name AS ward_name, 
    COUNT(DISTINCT i.an) AS admission_count
FROM ipt i
LEFT OUTER JOIN ward w ON w.ward = i.ward  
WHERE i.dchdate BETWEEN '2023-10-01' AND '2024-09-30' 
GROUP BY w.name

กรณีมีการย้ายเตียง
WITH min_bedmove AS (
    SELECT 
        im.an,
        MIN(im.iptbedmove_id) AS min_iptbedmove_id,  
        im.oward
    FROM 
        iptbedmove im
    GROUP BY im.an, im.oward
)
SELECT 
    w.name AS ward_name, 
    COUNT(i.an) AS admission_count
FROM 
    ipt i
LEFT OUTER JOIN min_bedmove mb ON mb.an = i.an
LEFT OUTER JOIN iptbedmove im ON im.iptbedmove_id = mb.min_iptbedmove_id        
LEFT OUTER JOIN ward w 
    ON (mb.min_iptbedmove_id IS NOT NULL AND w.ward = mb.oward)
    OR (mb.min_iptbedmove_id IS NULL AND w.ward = i.ward)
WHERE 
    i.dchdate BETWEEN '2023-10-01' AND '2024-09-30'
GROUP BY 
    w.name;
---------------------
//สถิติโรคของผู้ป่วยใน
SELECT icd.code, icd.name, count(distinct i1.hn) as cc_hn, count(distinct i1.an) as cc_an 
FROM icd101 icd 
LEFT JOIN (select i.an, id.pdx, i.hn FROM ipt i, an_stat id WHERE i.an = id.an and i.dchdate BETWEEN '2023-10-01' AND '2024-09-30') i1 on i1.pdx = icd.code 
WHERE NOT i1.pdx LIKE 'Z%'
      AND NOT i1.pdx LIKE 'R%'
      AND NOT i1.pdx LIKE 'O%'
GROUP BY icd.code
ORDER BY cc_an DESC 
LIMIT 1000
----------------
//ผู้ป่วยส่งต่อผู้ป่วยนอก(ครั้ง) : ตรง
//จำนวนผู้ป่วยส่งต่อ OPD รายเดือน : ตรง
//จำนวนโรคผู้ป่วยส่งต่อ OPD : 
SELECT count(r.vn)AS vn_count, v.pdx, i.NAME, i.tname 
                  FROM referout r 
                  LEFT OUTER JOIN vn_stat v ON v.vn = r.vn 
                  LEFT OUTER JOIN icd101 i ON i.code = v.pdx 
                  WHERE r.refer_date BETWEEN '2023-10-01' AND '2024-09-30'
                   AND r.department = 'OPD' 
                  GROUP BY v.pdx , i.NAME, i.tname 
                  ORDER BY vn_count DESC 
--------------------------------
//ผู้ป่วยส่งต่อผู้ป่วยใน(ครั้ง) :  ยอดไม่ตรง
//จำนวนผู้ป่วยส่งต่อ IPD รายเดือน : ยอดเดือน 5 7 8 9 ไม่ตรง
SELECT 
    TO_CHAR(DATE_TRUNC('month', refer_date), 'YYYY-MM') AS month, 
    COUNT(vn) AS count_per_month
FROM referout
WHERE refer_date BETWEEN '2023-10-01' AND '2024-09-30'
  AND department = 'IPD'
GROUP BY DATE_TRUNC('month', refer_date)

UNION ALL

SELECT 
    'รวม' AS month, 
    COUNT(vn) AS count_per_month
FROM referout
WHERE refer_date BETWEEN '2023-10-01' AND '2024-09-30'
  AND department = 'IPD'

ORDER BY month; 
-------------

//จำนวนโรคผู้ป่วยส่งต่อ IPD : อันดับมีความใกล้เคียง ยอดไม่ตรงกัน
//จำนวนผู้ป่วยคลอด(ครั้ง) : ตรง
//จำนวนผู้คลอดรายเดือน : ตรง
//ผู้ป่วยโรคเฝ้าระวังระบาดวิทยา "ยอดไม่ตรงเลย"



