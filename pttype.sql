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
        END AS eligibility_group 
    FROM ovst o 
    WHERE o.vstdate BETWEEN '2023-10-01' AND '2023-09-30' 
) 
SELECT 
    eligibility_group, 
    COUNT(vn) AS visit_count 
FROM DepartmentGroups 
GROUP BY  eligibility_group 
ORDER BY 
    CASE 
        WHEN eligibility_group = 'UCS หลักประกันสุขภาพ' THEN 1 
        WHEN eligibility_group = 'OFC ข้าราชการกรมบัญชีกลาง' THEN 2 
        WHEN eligibility_group = 'LGO ข้าราชการท้องถิ่น' THEN 3 
        WHEN eligibility_group = 'BKK ข้าราชการกรุงเทพมหานคร' THEN 4 
        WHEN eligibility_group = 'SSS ประกันสังคม' THEN 5 
        WHEN eligibility_group = 'NHS สปสช.' THEN 6 
        WHEN eligibility_group = 'STPบุคคลผู้มีปัญหาสถานะสิทธิ' THEN 7 
        WHEN eligibility_group = 'เบิกต้นสังกัด/หน่วยงานรัฐอื่น' THEN 8 
        WHEN eligibility_group = 'ประกันอุบัติเหตุนักเรียน' THEN 9 
        WHEN eligibility_group = 'ประกันชีวิต' THEN 10 
        WHEN eligibility_group = 'อุบัติเหตุจราจร' THEN 11 
        WHEN eligibility_group = 'แรงงานต่างด้าว' THEN 12 
        WHEN eligibility_group = 'ตรวจสุขภาพ' THEN 13 
        WHEN eligibility_group = 'ชำระเงินเอง' THEN 14 
        WHEN eligibility_group = 'สิ่งส่งตรวจหน่วยงานภาครัฐ' THEN 15 
        ELSE 17 
    END;

