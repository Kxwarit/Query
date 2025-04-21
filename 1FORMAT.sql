
    date1, date2 : DateTime;
    ds1, ds2 : String;

----------------------------------------------------------------------------------------------------------------------

      GetDateRangeDialog(date1, date2);
      ds1 := FormatDateTime('yyyy-mm-dd', date1);
      ds2 := FormatDateTime('yyyy-mm-dd', date2);

      LoadPPImageFromSQL(Image1, 'SELECT opdconfig.app_icon_80x80_png FROM opdconfig');
      Hosname.Text := HospitalName; 
      Headreport.Text := 'รายชื่อผู้ป่วย ';
      RangeDate.Text := 'วันที่ ' + FormatThaiDate('d mmmm yyyy', date1) + ' ถึง ' +  FormatThaiDate('d mmmm yyyy', date2);

      LoginBy.Text := 'ผู้พิมพ์ : ' +  GetSQLStringData('SELECT officer_name FROM officer WHERE officer_login_name = "'+GetCurrentUser+'" ');
      PrintBy.Text := 'พิมพ์จากเครื่อง : ' + GetSQLStringData('SELECT computername FROM onlineuser where onlineid = "'+GetOnlineID+'" ') 
      +'  วันที่ ' + FormatThaiDate('dd/mm/yyyy เวลา hh:mm:ss น.',CurrentDateTime);
      Reportname.Text := GetReportName;

-----------------------------------------------------------------------------------------------------------------------

        'จำนวน  '
            + GetSQLStringData('SELECT TO_CHAR(COUNT(*)::numeric, "FM999,999") as count_data'
            + ' FROM ( '
            + ' '
            + ' ) as subquery '
            + ' ' ) 
            + '  รายการ '

---------------------------------------------------------------------------------------------------------------------

        FormatThaiDate('dd/mm/yyyy', DBPipeline['vstdate']); 

        BETWEEN "'+ds1+'" AND "'+ds2+'"


--------------------------เบอร์--------------------------------------------------------------------------------------------
STRING_AGG( DISTINCT CASE 
 WHEN p.hometel <> '' AND p.hometel ~ '^[0-9-]+$' AND p.hometel !~ '^(.)\1*$' THEN p.hometel 
 WHEN p.mobile_phone_number <> '' AND p.mobile_phone_number ~ '^[0-9-]+$' AND p.mobile_phone_number !~ '^(.)\1*$' THEN p.mobile_phone_number 
 WHEN p.informtel <> '' AND p.informtel ~ '^[0-9-]+$' AND p.informtel !~ '^(.)\1*$' THEN p.informtel 
ELSE NULL END, ', ') AS contact

CASE WHEN p.informaddr <> "" then p.informaddr ELSE CONCAT_WS( " ", p.addrpart, (CASE WHEN p.moopart <> "" THEN CONCAT("หมู่ ", p.moopart)END), th.full_name) END as addr

LEFT OUTER JOIN thaiaddress th ON th.chwpart = p.chwpart AND th.amppart = p.amppart AND th.tmbpart = p.tmbpart

--------------------------ที่อยู่--------------------------------------------------------------------------------------------
STRING_AGG(CASE WHEN th.amppart = p.amppart  AND th.tmbpart = p.tmbpart THEN th.name ELSE NULL END, ', ') AS tmb,
STRING_AGG(CASE WHEN th.amppart = p.amppart AND th.tmbpart = "00" THEN th.name ELSE NULL END, ', ') AS amp,
STRING_AGG(CASE WHEN th.amppart = "00" AND th.tmbpart = "00" THEN th.name ELSE NULL END, ', ') AS chw

