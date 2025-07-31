--------------------------ตรวจว่า แพทย์ไม่มีพยาบาลคนไหน--------------------
SELECT 
    get_serialnumber('oapp_grant_id'), 
    d.code, 
    o.officer_login_name
FROM 
    doctor d,
    officer o
WHERE 
    d.active = 'Y'
    AND d.position_id = '1' 
    AND o.officer_active = 'Y'
    --AND d.code = 'xxxx' ----รหัสแพทย์
    --AND o.officer_doctor_code = 'xxxx' ---รหัสพยาบาล 
    AND o.officer_id IN (
        SELECT officer_id 
        FROM officer_group_list 
        WHERE officer_group_id IN ('03','11','16','17')
    )
    AND NOT EXISTS (
        SELECT 1 
        FROM oapp_grant og 
        WHERE og.doctor_code = d.code 
          AND og.grant_login = o.officer_login_name
          AND o.officer_active = 'Y'
         
    );

--------------------------เพิ่มพยาบาลให้แพทย์--------------------------------
INSERT INTO oapp_grant(oapp_grant_id, doctor_code, grant_login)
SELECT 
    get_serialnumber('oapp_grant_id'), 
    d.code, 
    o.officer_login_name
FROM 
    doctor d,
    officer o
WHERE 
    d.active = 'Y'
    AND d.position_id = '1' 
    AND o.officer_active = 'Y'
    --AND d.code = 'xxxx' ----รหัสแพทย์
    --AND o.officer_doctor_code = 'xxxx' ---รหัสพยาบาล 
    AND o.officer_id IN (
        SELECT officer_id 
        FROM officer_group_list 
        WHERE officer_group_id IN ('03','11','16','17')
    )
    AND NOT EXISTS (
        SELECT 1 
        FROM oapp_grant og 
        WHERE og.doctor_code = d.code 
          AND og.grant_login = o.officer_login_name
          AND o.officer_active = 'Y'
         
    );

--------------------------ดูรายการที่ต้องลบออก----------------------------------------
WITH keep_rows AS (
  SELECT MIN(oapp_grant_id) AS keep_id, doctor_code, grant_login
  FROM oapp_grant
  --WHERE doctor_code = 'xxxx' ----รหัสแพทย์
  GROUP BY doctor_code, grant_login
)
SELECT og.*
FROM oapp_grant og
JOIN keep_rows kr ON kr.doctor_code = og.doctor_code AND kr.grant_login = og.grant_login
WHERE og.oapp_grant_id <> kr.keep_id
  AND og.doctor_code = 'xxxx' ----รหัสแพทย์;

--------------------------ลบพยาบาลที่ซ้ำออก (ฟ้อง error)-----------------------------
WITH keep_rows AS (
  SELECT MIN(oapp_grant_id) AS keep_id, doctor_code, grant_login
  FROM oapp_grant
  WHERE doctor_code = 'xxxx' ----รหัสแพทย์
  GROUP BY doctor_code, grant_login
)
DELETE FROM oapp_grant og
WHERE og.doctor_code = 'xxxx' ----รหัสแพทย์
  AND EXISTS (
    SELECT 1
    FROM keep_rows kr
    WHERE kr.doctor_code = og.doctor_code
      AND kr.grant_login = og.grant_login
      AND og.oapp_grant_id <> kr.keep_id
  );
--------------------------ลบพยาบาลที่ซ้ำออก (ไม่มีฟ้อง error) แต่จะบอกแถวที่ลบ-----------
WITH keep_rows AS (
  SELECT MIN(oapp_grant_id) AS keep_id, doctor_code, grant_login
  FROM oapp_grant
  WHERE doctor_code = 'xxxx' ----รหัสแพทย์
  GROUP BY doctor_code, grant_login
)
DELETE FROM oapp_grant og
WHERE og.doctor_code = 'xxxx' ----รหัสแพทย์
  AND EXISTS (
    SELECT 1
    FROM keep_rows kr
    WHERE kr.doctor_code = og.doctor_code
      AND kr.grant_login = og.grant_login
      AND og.oapp_grant_id <> kr.keep_id
  )
RETURNING *;
------------------------------------------------------------------------------------

