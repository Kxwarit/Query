select
    c.clinicmember_id,
    c.clinic,
    c.doctor,
    c.hn,
    c.note,
    c.regdate,
    c.lastvisit,
    c.pttype,
    c.last_vn,
    c.next_app_date,
    c.begin_year,
    c.dchdate,
    c.current_status,
    c.subtype,
    c.number,
    c.node_id,
    c.send_to_pcu,
    c.send_to_pcu_date,
    c.refer_from_pcu,
    c.refer_from_pcu_date,
    c.refer_from_pcu_cause,
    c.refer_from_pcu_hcode,
    c.special_case,
    c.new_case,
    c.age_y,
    c.sex,
    c.special_id,
    c.send_to_pcu_hcode,
    c.pt_number,
    c.chronic_type,
    c.chronic_level,
    c.period_begin_date,
    c.mo1_visit_date,
    c.mo2_visit_date,
    c.mo3_visit_date,
    c.mo4_visit_date,
    c.mo5_visit_date,
    c.mo6_visit_date,
    c.mo7_visit_date,
    c.mo8_visit_date,
    c.mo9_visit_date,
    c.mo10_visit_date,
    c.mo11_visit_date,
    c.mo12_visit_date,
    c.clinic_member_status_id,
    c.lastupdate,
    c.clinic_subtype_id,
    c.other_chronic_text,
    c.dw_chronic_number,
    c.appointment_visit_frequency,
    c.entry_datetime,
    c.entry_staff,
    c.modify_staff,
    c.refer_register_from_hospcode,
    c.has_eye_cormobidity,
    c.last_cormobidity_screen_vn,
    c.has_foot_cormobidity,
    c.has_cardiovascular_cormobidity,
    c.has_cerebrovascular_cormobidity,
    c.has_peripheralvascular_cormobidity,
    c.has_dental_cormobidity,
    c.has_kidney_cormobidity,
    c.register_hospcode,
    c.discharge,
    c.with_pregnancy,
    c.with_hypertension,
    c.with_insulin,
    c.pre_register,
    c.last_hba1c_date,
    c.last_hba1c_value,
    c.last_ua_date,
    c.last_ua_value,
    c.last_bp_date,
    c.last_bp_bps_value,
    c.last_bp_bpd_value,
    c.nap_number,
    c.send_to_pcu_note,
    c.last_fbs_value,
    c.last_fbs_date,
    c.hhc_register_id,
    c.last_cloud_sync_datetime,
    c.mark_correct_43,
    c.dx_date,
    c.dx_hospcode,
    c.begin_date,
    c.sct_id,
    c.sct_desc,
    c.cm_vt_eval_type_id,
    c.doctor_confirm,
    c.doctor_confirm_datetime,
    c.confirm_doctor_code,
    c.clinical_text,
    c.description_text,
    c.doctor_confirm_prv_cid,
    c.doctor_confirm_prv_name,
    c.ncd_icd10_list,
    concat(p.pname, p.fname, " ", p.lname) as patient_name,
    n.name as clinic_name,
    p.cid,
    y.name as pttype_name,
    cs.name as clinic_subtype_name,
    s.name as sex_name,
    d.name as doctor_name,
    cm.clinic_member_status_name,
    u.name as staff_name,
    ov1.vstdate as last_cormobidity_screen_date,
    concat(hh.hosptype, " ", hh.name) as dw_reg_hospital_name,
    concat(ph.hosptype, " ", ph.name) as send_pcu_hospital_name,
    concat(p.addrpart, " หมู่ ", p.moopart, " ", ta.full_name) :: varchar(500) as addr_name
from
    clinicmember c
    left outer join patient p on p.hn = c.hn
    left outer join clinic n on n.clinic = c.clinic
    left outer join pttype y on y.pttype = p.pttype
    left outer join clinic_subtype cs on cs.clinic_subtype_id = c.clinic_subtype_id
    left outer join sex s on s.code = p.sex
    left outer join doctor d on d.code = c.doctor
    left outer join clinic_member_status cm on cm.clinic_member_status_id = c.clinic_member_status_id
    left outer join opduser u on u.loginname = c.modify_staff
    left outer join ovst ov1 on ov1.vn = c.last_cormobidity_screen_vn
    left outer join hospcode hh on hh.hospcode = c.register_hospcode
    left outer join hospcode ph on ph.hospcode = c.send_to_pcu_hcode
    left outer join thaiaddress ta on ta.chwpart = p.chwpart
    and ta.amppart = p.amppart
    and ta.tmbpart = p.tmbpart
    and ta.codetype = "3"
where
    c.clinic = "096"
order by
    c.pt_number,
    c.regdate
--------------------------
SELECT 
  o.vstdate,
  p.hn,
  Concat(p.pname, p.fname, " ", p.lname) AS patient_name,
  c.name,
  oc.pfull_score,
  ct.cvd_risk_score_type_name
FROM ovst o
INNER JOIN clinicmember cm ON cm.hn = o.hn
LEFT OUTER JOIN clinic c ON c.clinic = cm.clinic
LEFT OUTER JOIN patient p ON p.hn = o.hn
INNER JOIN opdscreen_cvd oc ON oc.vn = o.vn
LEFT OUTER JOIN cvd_risk_score_type ct ON ct.cvd_risk_score_type_id = oc.cvd_risk_score_type_id
WHERE o.vstdate BETWEEN "2025-06-01" AND "2025-06-30" 
AND cm.clinic IN ("096","002")
AND oc.pfull_score IS NOT NULL
ORDER BY c.name