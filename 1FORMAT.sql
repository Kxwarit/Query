
    date1, date2 : DateTime;
    ds1, ds2 : String;

--------------------------
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

---------------------------
        'จำนวน  '
            + GetSQLStringData('SELECT TO_CHAR(COUNT(*)::numeric, "FM999,999") as count_data'
            + ' FROM ( '
            + ' '
            + ' ) as subquery '
            + ' ' ) 
            + '  รายการ '

-------------------------
        FormatThaiDate('dd/mm/yyyy', DBPipeline['vstdate']); 

        BETWEEN "'+ds1+'" AND "'+ds2+'"
-------------------
SELECT *
FROM ipt i
LEFT OUTER JOIN patient p ON p.hn = i.hn
LEFT OUTER JOIN an_stat a ON a.an = i.an
LEFT OUTER JOIN spclty s ON s.spclty = i.spclty
WHERE i.dchdate BETWEEN '2024-09-01' AND '2024-09-30' AND i.ward = '32'