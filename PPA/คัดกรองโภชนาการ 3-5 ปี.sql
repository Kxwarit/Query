select row_number() over (order by pe.person_id) as con 
,'สุราษฎร์ธานี' as province
,(select sys_value from sys_var where sys_name = 'hospital_code' limit 1) as hospcode
,(select sys_value from sys_var where sys_name = 'hospital_name' limit 1) as hospname
,concat(p.pname,p.fname,' ',p.lname) as ptname
,p.cid
,max(pen.age_y) as age
,s.name as sex
,(select hipdata_code from ovst o left join pttype pt on pt.pttype=o.pttype where o.hn=p.patient_hn order by vstdate desc limit 1) as pt_pttype
,(select pen1.nutrition_date from person_epi_nutrition pen1 left join person_epi pe1 on pe1.person_epi_id=pen1.person_epi_id where pe1.person_id=pe.person_id and pen1.nutrition_date between '2025-01-01' and '2025-03-31' order by pen1.nutrition_date desc limit 1) as Q2_date
,(select bl1.name from person_epi_nutrition pen1 left join person_epi pe1 on pe1.person_epi_id=pen1.person_epi_id left join bmi_level bl1 on bl1.bmi_level=pen1.bmi_level where pe1.person_id=pe.person_id and pen1.nutrition_date between '2025-01-01' and '2025-03-31' order by pen1.nutrition_date desc limit 1) as Q2_bmi
,(select pen1.nutrition_date from person_epi_nutrition pen1 left join person_epi pe1 on pe1.person_epi_id=pen1.person_epi_id where pe1.person_id=pe.person_id and pen1.nutrition_date between '2025-04-01' and '2025-06-30' order by pen1.nutrition_date desc limit 1) as Q3_date
,(select bl1.name from person_epi_nutrition pen1 left join person_epi pe1 on pe1.person_epi_id=pen1.person_epi_id left join bmi_level bl1 on bl1.bmi_level=pen1.bmi_level where pe1.person_id=pe.person_id and pen1.nutrition_date between '2025-04-01' and '2025-06-30' order by pen1.nutrition_date desc limit 1) as Q3_bmi
from person_epi_nutrition pen
left join person_epi pe on pe.person_epi_id=pen.person_epi_id
left join person p on p.person_id=pe.person_id
left join sex s on s.code=p.sex
left join bmi_level bl on bl.bmi_level=pen.bmi_level
where pen.nutrition_date between '2025-01-01' and '2025-06-30' 
and pen.age_y between '3' and '5'
and p.nationality='99'
group by pe.person_id,p.patient_hn,province,hospcode,hospname,ptname,p.cid,s.name