 SELECT row_number() OVER () as ord, province,hospcode,hospname, name as pt_name, cid, age_month1 as age_month,sex_name, hipdata_code, entry_datetime as entry_date, pp_result from (SELECT 'สุราษฎร์ธานี' as province,  
(select sys_value from sys_var where sys_name = 'hospital_code' limit 1) as hospcode,  
(select sys_value from sys_var where sys_name = 'hospital_name' limit 1) as hospname,  
concat(pname,' ',fname,' ',lname) as name,   
patient.cid, 
(EXTRACT(Year FROM age(pp.entry_datetime::TIMESTAMP::DATE,birthday)) :: int * 12) + (EXTRACT(MONTH FROM age(pp.entry_datetime::TIMESTAMP::DATE,birthday))) :: int as age_month1, 
sex.name as sex_name, pttype.hipdata_code, 
pp.entry_datetime::TIMESTAMP::DATE AS entry_datetime,    

pp_special_type_name as PP_SPECIAL, 
case when pp_special_code = '1B260' then '1' else '2' end as pp_result , 

row_number() OVER (PARTITION BY patient.cid, (EXTRACT(Year FROM age(pp.entry_datetime::TIMESTAMP::DATE,birthday)) :: int * 12) + (EXTRACT(MONTH FROM age(pp.entry_datetime::TIMESTAMP::DATE,birthday))) :: int  ORDER BY ovst.hn , pp.entry_datetime::TIMESTAMP::DATE ASC) as ord
 
FROM pp_special pp  
inner join ovst on ovst.vn = pp.vn   
inner join patient on patient.hn = ovst.hn  
inner join pttype on pttype.pttype = ovst.pttype  
inner join sex on sex.code = patient.sex       
left join pp_special_type pptype on pptype.pp_special_type_id = pp.pp_special_type_id    
WHERE  ovst.vstdate BETWEEN '2025-01-01' and '2025-06-30'   
AND (EXTRACT(Year FROM age(pp.entry_datetime::TIMESTAMP::DATE,birthday)) :: int * 12) + (EXTRACT(MONTH FROM age(pp.entry_datetime::TIMESTAMP,birthday))) :: int  in ( 9 ,18,30,42,60) 
and pptype.pp_special_code in ('1B260','1B261','1B262')  and patient.nationality = '99'   
ORDER BY ovst.hn ) pp_ WHERE ord = 1