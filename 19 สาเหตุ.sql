      icode_list : String;
      tc, rc :TclientDataset;
begin   

      tc := TClientDataset.Create(nil);
      rc := TClientDataset.Create(nil);
      
      LoadPPImageFromSQL(Image1,'select app_icon_80x80_png from opdconfig');
      LnDateRange.Caption := 'ช่วงวันที่ : '+Formatthaidate('d mmmm yyyy',date1) +' - '+Formatthaidate('d mmmm yyyy',date2);
      reportName := GetReportName;
      LnHospcodeName.Text := HospitalName;
      LnReportName.Text := StringReplaceALL(reportName,'CUSTOM-XE-','',True);
      LnReportName.Text := StringReplaceALL(LnReportName.Text,'CUSTOM-','',True);
      LnReportNameOri.Text := reportName;
      
      LnLogin.Text := 'พิมพ์จากเครื่อง '+GetSQLStringData('select computername '
        +' from onlineuser where onlineid = "'+GetOnlineID+'" ') 
        +'  วันที่พิมพ์ '+FormatThaiDate('dd mmmm yyyy เวลา hh:mm น.',CurrentDateTime);
      LnPrinterName.Text := 'ผู้พิมพ์ : '+GetSQLStringData('select officer_name from officer '
        +' where officer.officer_login_name = "'+GetCurrentUser+'" ');
      
      hospcode := GetHOSVariable('hospital_code');
      chwpart := GetSQLStringData('select chwpart from hospcode where hospcode = "'+hospcode+'"');
      
      death_code := GetSQLSubQueryData('select ovstost from ovstost where death_status = "Y" ');
    
      repeat 
        showmessage('กรุณาเลือกช่วงวันที่มารับบริการ');
        GetDateRangeDialog(date1, date2);
        ds1:=FormatDateTime('yyyy-mm-dd',date1);
        ds2:=FormatDateTime('yyyy-mm-dd',date2); 
        date_diff := GetSQLIntegerData('select "'+ds2+'"::date - "'+ds1+'"::date');   
      until (ds1 <> '0000-00-00') and (ds2 <> '0000-00-00'); 
      
      LoadPPImageFromSQL(Image1,'select app_icon_80x80_png from opdconfig');
      LnDateRange.Caption := 'ช่วงวันที่ : '+Formatthaidate('d mmmm yyyy',date1) +' - '+Formatthaidate('d mmmm yyyy',date2);
      reportName := GetReportName;
      LnHospcodeName.Text := HospitalName;
      LnReportName.Text := StringReplaceALL(reportName,'CUSTOM-XE-','',True);
      LnReportName.Text := StringReplaceALL(LnReportName.Text,'CUSTOM-','',True);
      LnReportNameOri.Text := reportName; 
      
      tc.HOSxP_GetDataset(' select er_accident_type_id::numeric as er_accident_type, er_accident_type_name as detail,' 
          +' regexp_replace(er_accident_type_name,"[^0-9A-Za-z\-^]","","g") as code' 
          +' from er_accident_type' 
          +' where er_accident_type_id = 1' 
          +' ' 
          +' union ' 
          +' select 1.1::numeric as er_accident_type_id,"อุบัติเหตุอื่นๆ" as detail, "" as code' 
          +' ' 
          +' union ' 
          +' select er_accident_type_id::numeric, er_accident_type_name as detail,' 
          +' regexp_replace(er_accident_type_name,"[^0-9A-Za-z\-^]","","g") as code' 
          +' from er_accident_type' 
          +' where er_accident_type_id > 1' 
          +' ' 
          +' order by er_accident_type' ) ;
      
          rc.HOSxP_GetDataset('select 0 as id, cast(null as char(200)) as detail, 0 as cc_1, 0 as cc_1, 0 as cc_2, 0 as cc_3,'
              +' 0 as cc_4,0 as cc_5,0 as cc_6,0 as cc_7,0 as cc_8,0 as cc_9,0 as cc_1,0 as cc_10,0 as cc_11,'
              +' 0 as cc_12,0 as cc_13,0 as cc_14,0 as cc_15,0 as cc_16,0 as cc_17,0 as cc_18,0 as cc_19,0 as cc_20,0 as cc_21 limit 0');
      
      tc.First;
      while not tc.eof do
      begin             
        rc.Append;
          rc.FieldValues['id'] :=  tc.FieldValues['er_accident_type'];
          rc.FieldValues['detail'] :=  tc.FieldValues['detail'];
          
          min_icd := ExtractString(tc.FieldValues['code'], 1, '-');
          max_icd := ExtractString(tc.FieldValues['code'], 2, '-');
          if (min_icd <> '') then
          begin
            if max_icd = '' then max_icd := min_icd;
            
            vn_list := GetSQLSubQueryData(' select vn from ovstdiag' 
                    +' where left(icd10,3) between "'+min_icd+'" and "'+max_icd+'" ' 
                    +' and vstdate between "'+ds1+'" and "'+ds2+'"' 
                    +' union ' 
                    +' select vn from ipt, iptdiag d' 
                    +' where ipt.an = d.an and left(icd10,3) between "'+min_icd+'" and "'+max_icd+'" ' 
                    +' and dchdate between "'+ds1+'" and "'+ds2+'"' );
            if vn_list = '' then
              vn_list := '"XxxX"';
                    
            rc.FieldValues['cc_1'] := GetSQLIntegerData('select count(distinct vn) from ovst, patient p where ovst.hn = p.hn and p.sex in("1","2") and vn in('+vn_list+') ');
            rc.FieldValues['cc_2'] := GetSQLIntegerData('select count(distinct vn) from ovst, patient p where ovst.hn = p.hn and p.sex = "1" and vn in('+vn_list+') ');
            rc.FieldValues['cc_3'] := GetSQLIntegerData('select count(distinct vn) from ovst, patient p where ovst.hn = p.hn and p.sex = "2" and vn in('+vn_list+') ');
            
            rc.FieldValues['cc_4'] := GetSQLIntegerData('select count(distinct vn) from ovst, patient p where ovst.hn = p.hn and p.sex in("1","2") and p.chwpart = "'+chwpart+'" and vn in('+vn_list+') ');
            rc.FieldValues['cc_5'] := GetSQLIntegerData('select count(distinct vn) from ovst, patient p where ovst.hn = p.hn and p.sex = "1" and p.chwpart = "'+chwpart+'" and vn in('+vn_list+') ');
            rc.FieldValues['cc_6'] := GetSQLIntegerData('select count(distinct vn) from ovst, patient p where ovst.hn = p.hn and p.sex = "2" and p.chwpart = "'+chwpart+'" and vn in('+vn_list+') ');
            
            rc.FieldValues['cc_7'] := GetSQLIntegerData('select count(distinct vn) from ovst, patient p where ovst.hn = p.hn and p.sex in("1","2") and an <> "" and vn in('+vn_list+') ');
            rc.FieldValues['cc_8'] := GetSQLIntegerData('select count(distinct vn) from ovst, patient p where ovst.hn = p.hn and p.sex = "1" and an <> "" and vn in('+vn_list+') ');
            rc.FieldValues['cc_9'] := GetSQLIntegerData('select count(distinct vn) from ovst, patient p where ovst.hn = p.hn and p.sex = "2" and an <> "" and vn in('+vn_list+') '); 
              
             
            vn_list := GetSQLSubQueryData(' select dx.vn from ovstdiag dx, ovst' 
                    +' where dx.vn = ovst.vn and left(icd10,3) between "'+min_icd+'" and "'+max_icd+'" ' 
                    +' and dx.vstdate between "'+ds1+'" and "'+ds2+'" and ovst.ovstost in('+death_code+') ' 
                    +' union ' 
                    +' select vn from ipt, iptdiag d' 
                    +' where ipt.an = d.an and left(icd10,3) between "'+min_icd+'" and "'+max_icd+'" ' 
                    +' and dchdate between "'+ds1+'" and "'+ds2+'" and ipt.dchtype in("08","09") ' ); 
            
            vn_dba := GetSQLSubQueryData(' select er.vn from er_regist er '
                    +' INNER JOIN ovstdiag dx ON dx.vn = er.vn' 
                    +' where er.vstdate between "'+ds1+'" and "'+ds2+'" and dba = "Y" '
                    +' and left(dx.icd10,3) between "'+min_icd+'" and "'+max_icd+'"');                                                     
              
            rc.FieldValues['cc_10'] := GetSQLIntegerData('select count(distinct vn) from ovst, patient p where ovst.hn = p.hn and p.sex in("1","2") and vn in('+vn_list+') ');
            rc.FieldValues['cc_11'] := GetSQLIntegerData('select count(distinct vn) from ovst, patient p where ovst.hn = p.hn and p.sex = "1" and vn in('+vn_list+') ');
            rc.FieldValues['cc_12'] := GetSQLIntegerData('select count(distinct vn) from ovst, patient p where ovst.hn = p.hn and p.sex = "2" and vn in('+vn_list+') ');
            
            rc.FieldValues['cc_13'] := GetSQLIntegerData('select count(distinct vn) from ovst, patient p where ovst.hn = p.hn and p.sex in("1","2") and p.chwpart = "'+chwpart+'" and vn in('+vn_list+') ');
            rc.FieldValues['cc_14'] := GetSQLIntegerData('select count(distinct vn) from ovst, patient p where ovst.hn = p.hn and p.sex = "1" and p.chwpart = "'+chwpart+'" and vn in('+vn_list+') ');
            rc.FieldValues['cc_15'] := GetSQLIntegerData('select count(distinct vn) from ovst, patient p where ovst.hn = p.hn and p.sex = "2" and p.chwpart = "'+chwpart+'" and vn in('+vn_list+') ');
             
            rc.FieldValues['cc_16'] := GetSQLIntegerData('select count(distinct vn) from ovst, patient p where ovst.hn = p.hn and p.sex in("1","2") and an <> "" and vn in('+vn_list+') ');
            rc.FieldValues['cc_17'] := GetSQLIntegerData('select count(distinct vn) from ovst, patient p where ovst.hn = p.hn and p.sex = "1" and an <> "" and vn in('+vn_list+') ');
            rc.FieldValues['cc_18'] := GetSQLIntegerData('select count(distinct vn) from ovst, patient p where ovst.hn = p.hn and p.sex = "2" and an <> "" and vn in('+vn_list+') ');
            
            rc.FieldValues['cc_19'] := GetSQLIntegerData('select count(distinct vn) from ovst, patient p where ovst.hn = p.hn and p.sex in("1","2") and vn in('+vn_dba+') ');
            rc.FieldValues['cc_20'] := GetSQLIntegerData('select count(distinct vn) from ovst, patient p where ovst.hn = p.hn and p.sex = "1" and vn in('+vn_dba+') ');
            rc.FieldValues['cc_21'] := GetSQLIntegerData('select count(distinct vn) from ovst, patient p where ovst.hn = p.hn and p.sex = "2" and vn in('+vn_dba+') ');
          end;
        rc.Post;  
      tc.Next;
      end;
      
             
      rc.AssignDataToMainReport;
      
      rc.Free;
      tc.Free;
      