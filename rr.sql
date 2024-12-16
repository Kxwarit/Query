SELECT inc.bill_order,
  inc.income_group,
  inc.income AS income_no,
  Concat(inc.name) AS income_name,
  rp.total_amount,
  Coalesce(inc.ename, inc.name) AS income_ename,
  Sum(CASE
    WHEN rd.paidst = '01'
    THEN rd.total_amount
    ELSE 0
  END) AS paidst_01,
  Sum(CASE
    WHEN rd.paidst = '03'
    THEN rd.total_amount
    ELSE 0
  END) AS paidst_03,
  rp.rcpno
FROM rcpt_print rp
  INNER JOIN rcpt_print_detail rd ON rp.finance_number = rd.finance_number
  INNER JOIN income inc ON rd.income = inc.income
WHERE rp.rcpno = Replace(Replace(:rcpno, 'RCPT-', ''), '-', ':')
GROUP BY inc.income,
  rp.total_amount,
  Coalesce(inc.ename, inc.name),
  rp.rcpno,
  inc.name
ORDER BY inc.bill_order,
  inc.income_group
  -------
  
 
  // icdX := GetSQLSubQueryData(' select code from icd101 where (left(code,3) in("Z21","R75","Y05") or left(code,4) in("Z206","T742") or left(code,3) between "B20" and "B24")' );  
   
   compname :=  GetSQLStringData('select computername '
      +' from onlineuser where onlineid = "'+GetOnlineID+'" '); 
       
   rcpno := GetUserParameter(0);
   rcpno :=StringReplaceAll(StringReplaceAll(rcpno, 'RCPT-', '', True),'-', ':',True); 
   _vn := GetSQLStringData('select vn from rcpt_print where rcpno = "'+rcpno+'" ');
   
   ChangeDBPipeLineLink1SQL(' SELECT CASE' 
      +'     WHEN StrPos(u.name, ",") > 0' 
      +'     THEN Concat(Substr(u.name, StrPos(u.name, ",") + 1, 20), Substr(u.name, 0, StrPos(u.name, ",")))' 
      +'     ELSE u.name' 
      +'   END AS staff_name,ov.vstdate, '
      +'   rp.finance_number,  To_Char(CURRENT_DATE, "Month") AS month_frm,' 
      +'   d.position_id,  d.ename,  dp.name AS doctor_position,  pt2.name AS pttype_name,' 
      +'   (select cc.company_name from company_contact cc, visit_pttype vv where cc.company_id = vv.company_id and vv.vn=rp.vn and vv.pttype = rp.pttype) AS company_name,' 
      +'   pt.lang, (rp.rcpno) as rcp,  (rp.department) AS dep,  rp.bill_date AS date1,' 
      +'   Concat(pt.pname, pt.fname, " ", pt.lname) AS pt_name,' 
      +'   Concat(pe.eng_pname, pe.eng_fname, " ", pe.eng_lname) AS pt_name_eng,' 
      +'   rp.book_number,  rp.bill_number,  To_Char(rp.bill_date_time, "HH24:MI") as ttime,' 
      +'   rp.department,  rp.credit_card_amount,  rp.receive_cash_amount,rp.credit_card_no,' 
      +'   rp.cash_amount,  rp.deposit_debit_amount,rp.finance_pay_type_id, '
      +'   rp.vn,  rp.hn' 
      +' FROM rcpt_print rp' 
      +'   INNER JOIN ovst ov ON ov.vn = rp.vn'
      +'   INNER JOIN patient pt ON rp.hn = pt.hn' 
      +'   LEFT JOIN patient_eng pe ON pt.hn = pe.hn' 
      +'   INNER JOIN pttype pt2 ON rp.pttype = pt2.pttype' 
      +'   LEFT JOIN opduser u ON rp.bill_staff = u.loginname' 
      +'   LEFT JOIN doctor d ON u.doctorcode = d.code' 
      +'   LEFT JOIN doctor_position dp ON dp.id = d.position_id' 
      +' WHERE rp.rcpno = "'+rcpno+'"' );
  

  //------------------- Dx -------------------     
  _dx := GetSQLStringData('select case when (length(regexp_replace(i1.tname," ","","g"))=0) or (length(regexp_replace(i1.tname," ","","g")) is null) then i1.name else i1.tname end   '
      +' from ovstdiag od '
      +' left join icd101 i1 on i1.code = od.icd10   '   
      +' where vn = "'+_vn+'" and diagtype="1" '); 
    
  if _dx = '' then 
    _dx := GetSQLStringData('select diag_text   '
        +' from ovst_doctor_diag od   '   
        +' where vn = "'+_vn+'" order by diag_datetime desc limit 1 '); 
{        
  if _dx = '' then 
    _dx := InputQuery('คนไข้ยังไม่ระบุโรค', 'กำหนดโรคในเอกสาร : ');
}    
   LnPDX.Text := _dx; 
   
       staff :=GetSQLStringData('select concat(d.pname,d.fname," ",d.lname)::VARCHAR(300) from opduser op ,doctor d  '
      +' where op.doctorcode=d.code and op.loginname="'+GetCurrentUser+'" ');   
  