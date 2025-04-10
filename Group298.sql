 select tmpz.id, tmpz.name rpt_name, count(distinct od.hn) as cc_hn , count(distinct od.vn) as cc_vn
     from  
     (select 1 as id,'A00 อหิวาตกโรค' as name,'A00' as code1,'A00' as code2 
     union 
     select 2 as id,'A23 โรคติดเชื้อบรูเซลลา' as name,'A23' as code1,'A23' as code2 
     union 
     select 3 as id,'D80-D89 ความผิดปกติที่เกี่ยวกับกลไกของภูมิคุ้มกัน'as name,'D80' as code1,'D89'  as code2 
     union 
     select 4 as id,'E00-E02 การขาดไอโอดีนที่มีความสัมพันธ์กับต่อมธัยรอยด์' as name,'E00' as code1,'E02' as code2 
     union 
     select 5 as id,'E05 โรคพิษธัยรอยด์' as name,'E05' as code1,'E05' as code2 
     union 
     select 6 as id,'E03-E04, E06-E07 ความผิดปกติของต่อมธัยรอยด์อื่น ๆ'as name,'E03' as code1,'E07' as code2 
     union 
     select 7 as id,'E10-E14 เบาหวาน' as name,'E10' as code1,'E14' as code2 
     union 
     select 8 as id,'E40-E46 ทุพโภชนาการ' as name,'E40' as code1,'E46' as code2 
     union 
     select 9 as id,'E50 การขาดวิตามินเอ' as name,'E50' as code1,'E50' as code2 
     union 
     select 10 as id,'E51-E56 การขาดวิตามินอื่น ๆ'as name,'E51' as code1,'E56' as code2 
     union 
     select 11 as id,'E64 ผลที่ตามมาของภาวะทุพโภชนาการและภาวะพร่องโภชนาการอื่น ๆ' as name,'E64' as code1,'E64' as code2 
         union 
     select 12 as id,'E66 โรคอ้วน'as name,'E66' as code1,'E66' as code2 
         union 
     select 13 as id,'A30 โรคเรื้อน ' as name,'A30' as code1,'A30' as code2 
              union 
     select 14 as id,'E86 การขาดปริมาณของเหลวในร่างกาย' as name,'E86' as code1,'E86' as code2 
              union 
     select 15 as id,'E15-E35, E58-E63, E65, E67-E85, E87-E90 ความผิดปกติของต่อมไร้ท่อ โภชนาการและเมตะบอลิกอื่น ๆ' as name,'E15' as code1,'E35' as code2 
           union 
     select 15 as id,'E15-E35, E58-E63, E65, E67-E85, E87-E90 ความผิดปกติของต่อมไร้ท่อ โภชนาการและเมตะบอลิกอื่น ๆ' as name,'E58' as code1,'E63' as code2 
            union 
     select 15 as id,'E15-E35, E58-E63, E65, E67-E85, E87-E90 ความผิดปกติของต่อมไร้ท่อ โภชนาการและเมตะบอลิกอื่น ๆ'  as name,'E65' as code1,'E65' as code2 
                 union 
     select 15 as id,'E15-E35, E58-E63, E65, E67-E85, E87-E90 ความผิดปกติของต่อมไร้ท่อ โภชนาการและเมตะบอลิกอื่น ๆ' as name,'E67' as code1,'E85' as code2 
                          union 
     select 15 as id,'E15-E35, E58-E63, E65, E67-E85, E87-E90 ความผิดปกติของต่อมไร้ท่อ โภชนาการและเมตะบอลิกอื่น ๆ'  as name,'E87' as code1,'E90' as code2 
           union 
     select 16 as id,'F00-F03 สมองเสื่อม' as name,'F00' as code1,'F03' as code2      
         union 
     select 17 as id,'F10 ความผิดปกติของพฤติกรรมและจิตประสาทที่เกิดจากการเสพอัลคอฮอ'as name,'F10' as code1,'F10' as code2     
         union 
     select 18 as id,'F11-F19 ความผิดปกติทางพฤติกรรมและจิตประสาทที่เกิดจากการใช้วัตถุออกฤทธิ์ต่อจิตประสาทอื่น ๆ' as name,'F11' as code1,'F49' as code2   
          union 
     select 19 as id,'F20-F29 จิตเภท พฤติกรรมแบบจิตเภทและความหลงผิด' as name,'F20' as code1,'F29' as code2   
          union 
     select 20 as id,'F30-F39 ความผิดปกติทางอารมณ์'as name,'F30' as code1,'F39' as code2   
          union 
     select 21 as id,'F40-F48 โรคประสาท อาการทางกายที่เกิดจากจิตใจและความเครียด' as name,'F40' as code1,'F48' as code2   
          union 
     select 22 as id,'F70-F79 ภาวะปัญญาอ่อน' as name,'F70' as code1,'F79' as code2   
          union  
     select 23 as id,'F04-F09, F50-F69, F80-F99 ความผิดปกติทางจิตและพฤติกรรมอื่น ๆ' as name,'F04' as code1,'F09' as code2   
          union 
             select 23 as id,'F04-F09, F50-F69, F80-F99 ความผิดปกติทางจิตและพฤติกรรมอื่น ๆ'  as name,'F50' as code1,'F69' as code2   
          union 
             select 23 as id,'F04-F09, F50-F69, F80-F99 ความผิดปกติทางจิตและพฤติกรรมอื่น ๆ'  as name,'F80' as code1,'F99' as code2   
          union 
     select 24 as id,'A33 บาดทะยักในทารกแรกเกิด' as name,'A33' as code1,'A33' as code2    union 
     select 25 as id,'G00-G09 การอักเสบของระบบประสาทส่วนกลาง'as name,'G00' as code1,'G09' as code2   union 
     select 26 as id,'G20 โรคพาคินซัน'as name,'G20' as code1,'G20'as code2 union 
         select 27 as id,'G30 โรคแอลไซเมอร์'as name,'G30' as code1,'G30' as code2   union
         select 28 as id,'G35 มัลติเปิล สเคลอโรสิส' as name,'G35' as code1,'G35' as code2   union
         select 29 as id,'G40-G41 ลมบ้าหมู' as name,'G40' as code1,'G41' as code2   union
         select 30 as id,'G43-G44 โรคไมเกรนและกลุ่มอาการปวดศีรษะอื่น ๆ' as name,'G43' as code1,'G44' as code2   union
         select 31 as id,'G45 โรคเลือดไปเลี้ยงสมองน้อยชั่วคราวและกลุ่มอาการต่อเนื่อง' as name,'G45' as code1,'G45' as code2   union
         select 32 as id,'G50-G59 ความผิดปกติของส้นประสาท รากประสาทและปมประสาท'as name,'G50' as code1,'G59' as code2   union
         select 33 as id,'G80-G83 สมองพิการและกลุ่มอาการอัมพาตอื่น ๆ' as name,'G80' as code1,'G83' as code2   union
         select 34 as id,'G10-G13, G21-G26, G31-G32, G36-G37, G46-G47, G60-G73, G90-G99 โรคของระบบประสาทอื่น ๆ'as name,'G10' as code1,'G13' as code2   union
         select 34 as id,'G10-G13, G21-G26, G31-G32, G36-G37, G46-G47, G60-G73, G90-G99 โรคของระบบประสาทอื่น ๆ'as name,'G21' as code1,'G26' as code2   union
         select 34 as id,'G10-G13, G21-G26, G31-G32, G36-G37, G46-G47, G60-G73, G90-G99 โรคของระบบประสาทอื่น ๆ' as name,'G31' as code1,'G32' as code2   union
         select 34 as id,'G10-G13, G21-G26, G31-G32, G36-G37, G46-G47, G60-G73, G90-G99 โรคของระบบประสาทอื่น ๆ' as name,'G36' as code1,'G37' as code2   union
         select 34 as id,'G10-G13, G21-G26, G31-G32, G36-G37, G46-G47, G60-G73, G90-G99 โรคของระบบประสาทอื่น ๆ' as name,'G46' as code1,'G47' as code2   union
         select 34 as id,'G10-G13, G21-G26, G31-G32, G36-G37, G46-G47, G60-G73, G90-G99 โรคของระบบประสาทอื่น ๆ' as name,'G60' as code1,'G73' as code2   union
         select 34 as id,'G10-G13, G21-G26, G31-G32, G36-G37, G46-G47, G60-G73, G90-G99 โรคของระบบประสาทอื่น ๆ' as name,'A34' as code1,'A35' as code2   union
          select 35 as id,'A34-A35 บาดทะยัก' as name,'A34' as code1,'A35' as code2   union
            select 36 as id,'H00-H01 การอักเสบของหนังตา' as name,'H00' as code1,'H01' as code2   union
             
              select 37 as id,'H10-H13 เยื่อบุตาอักเสบและความผิดปกติของเยื่อบุตาอื่น ๆ' as name,'H10' as code1,'H013' as code2   union
                 select 38 as id,'H15-H19 กระจกตาอักเสบและความผิดปกติของตาขาวและกระจกตาอื่น ๆ' as name, 'H15' as code1,'H19' as code2   union
                  select 39 as id,'H25-H28 ต้อกระจกและความผิดปกติของเลนส์อื่น ๆ' as name,'H25' as code1,'H28' as code2   union
                     select 40 as id,'H33 จอประสาทตาหลุดออกและรอยฉีกของจอประสาทตา' as name,'H33' as code1,'H33' as code2   union
                      select 41 as id,'H40-H42 ต้อหิน' as name,'H40'  as code1,'H42' as code2   union
                         select 42 as id,'H49-H50 ตาเหล่' as name,'H49' as code1,'H50' as code2   union
                         select 43 as id,'H52 ความผิดปกติของสายตาและการเพ่งมอง' as name,'H52' as code1,'H52' as code2   union
                         select 44 as id,'H54 ตาบอดและสายตาเลือนลาง' as name,'H54' as code1,'H54' as code2   union
                         select 45 as id,'H02-H06, H20-H22, H30-H32, H34-H36, H43-H48, H51, H53, H55-H59 โรคของตาและส่วนประกอบของตาอื่น ๆ' as name,'H02' as code1,'H06' as code2   union
                         select 45 as id,'H02-H06, H20-H22, H30-H32, H34-H36, H43-H48, H51, H53, H55-H59 โรคของตาและส่วนประกอบของตาอื่น ๆ' as name,'H20' as code1,'H22' as code2   union
                         select 45 as id,'H02-H06, H20-H22, H30-H32, H34-H36, H43-H48, H51, H53, H55-H59 โรคของตาและส่วนประกอบของตาอื่น ๆ'as name,'H30' as code1,'H32' as code2   union
                         select 45 as id,'H02-H06, H20-H22, H30-H32, H34-H36, H43-H48, H51, H53, H55-H59 โรคของตาและส่วนประกอบของตาอื่น ๆ' as name,'H34' as code1,'H36' as code2   union
                         select 45 as id,'H02-H06, H20-H22, H30-H32, H34-H36, H43-H48, H51, H53, H55-H59 โรคของตาและส่วนประกอบของตาอื่น ๆ' as name,'H43' as code1,'H48' as code2   union
                         select 45 as id,'H02-H06, H20-H22, H30-H32, H34-H36, H43-H48, H51, H53, H55-H59 โรคของตาและส่วนประกอบของตาอื่น ๆ' as name,'H51' as code1,'H51' as code2   union
                         select 45 as id,'H02-H06, H20-H22, H30-H32, H34-H36, H43-H48, H51, H53, H55-H59 โรคของตาและส่วนประกอบของตาอื่น ๆ' as name,'H53' as code1,'H53' as code2   union
                         select 45 as id,'H02-H06, H20-H22, H30-H32, H34-H36, H43-H48, H51, H53, H55-H59 โรคของตาและส่วนประกอบของตาอื่น ๆ' as name,'H55' as code1,'H59' as code2   union
                         select 46 as id,'A36 โรคคอตีบ' as name,'A36' as code1,'A36' as code2   union
                         select 47 as id,'H65-H75  หูชั้นกลางอักเสบและความผิดปกติของหูชั้นกลางและปุ่มกกหูอื่น ๆ'as name,'H65' as code1,'H75' as code2   union
                         select 48 as id,'H90-H91 การสูญเสียการได้ยิน' as name,'H90' as code1,'H91' as code2   union
                         select 49 as id,'H60-H62, H80-H83, H92-H95 โรคของหูและปุ่มกกหูอื่น ๆ' as name,'H60' as code1,'H62' as code2   union
                          select 49 as id,'H60-H62, H80-H83, H92-H95 โรคของหูและปุ่มกกหูอื่น ๆ' as name,'H80' as code1,'H83' as code2   union
                             select 49 as id,'H60-H62, H80-H83, H92-H95 โรคของหูและปุ่มกกหูอื่น ๆ' as name,'H92' as code1,'H95' as code2   union
                         select 50 as id,'I00-I02 ไข้รูมาติกเฉียบพลัน'as name,'I00' as code1,'I02' as code2   union
                         select 51 as id,'I05-I09 โรคหัวใจรูมาติกเรื้อรัง' as name,'I05' as code1,'I09' as code2   union
                         select 52 as id,'I10 ความดันโลหิตสูงที่ไม่มีสาเหตุนำ'  as name,'I10' as code1,'I10' as code2   union
                         select 53 as id,'I11-I15 โรคความดันโลหิตสูงอื่น ๆ'  as name,'I11' as code1,'I15' as code2   union
                         select 54 as id,'I21-I22 กล้ามเนื้อหัวใจตายเฉียบพลัน' as name,'I21' as code1,'I22' as code2   union
                         select 55 as id,'I20, I23-I25 โรคหัวใจขาดเลือดอื่น ๆ' as name,'I20' as code1,'I20' as code2 union
                         select 55 as id,'I20, I23-I25 โรคหัวใจขาดเลือดอื่น ๆ' as name,'I23' as code1,'I25' as code2 union
                          select 56 as id,'I26 ก้อนเลือดอุดตันในหลอดเลือดใหญ่ของปอด' as name,'I26' as code1,'I26' as code2 union
                            select 57 as id,'A37 โรคไอกรน'  as name,'A37' as code1,'A37' as code2 union
                            select 58 as id,'I44-I49 ความผิดปกติของการนำกระแสไฟฟ้าหัวใจและหัวใจเต้นผิดจังหวะ' as name,'I44' as code1,'I49' as code2 union
                            select 59 as id,'I50 หัวใจล้มเหลว' as name,'I50' as code1,'I50' as code2 union
                            select 60 as id,'I27-I43, I51-I52 โรคหัวใจอื่น ๆ'  as name,'I27' as code1,'I43' as code2 union
                            select 60 as id,'I27-I43, I51-I52 โรคหัวใจอื่น ๆ'   as name,'I51' as code1,'I52' as code2 union
                            select 61 as id,'I60-I62 เลือดออกในสมอง' as name,'I60' as code1,'I62' as code2 union
                            select 62 as id,'I63 เนื้อสมองตาย' as name,'I63' as code1,'I63'  as code2 union
                            select 63 as id,'I64 เป็นลมหมดสติที่ไม่จัดกลุ่มว่าเป็นจากเลือดออกในสมองหรือเนื้อสมองตายจากการขาดเลือด' as name,'I64' as code1,'I64' as code2 union
                            select 64 as id,'I65-I69 Other cerebrovascular diseases' as name,'I65' as code1,'I69' as code2 union
                            select 65 as id,'I70 อะเธอโรสเคลอโรสิส' as name,'I70' as code1,'I70' as code2 union
                            select 66 as id,'I73 โรคหลอดเลือดส่วนปลายอื่น ๆ' as name,'I73' as code1,'I73' as code2 union
                            select 67 as id,'I74 ลิ่มเลือดและก้อนเลือดอุดตันที่หลอดเลือดแดง'  as name,'I74' as code1,'I74' as code2 union
                            select 68 as id,'A39 การติดเชื้อเมนิงโกค็อกคัส'  as name,'A39' as code1,'A39' as code2 union
                            select 69 as id,'I71-I72, I77-I79 โรคของหลอดเลือดแดง หลอดเลือดแดงย่อยและแคปิลารีอื่น ๆ' as name,'I71' as code1,'I72' as code2 union
                            select 69 as id,'I71-I72, I77-I79 โรคของหลอดเลือดแดง หลอดเลือดแดงย่อยและแคปิลารีอื่น ๆ' as name,'I77' as code1,'I79' as code2 union
                            select 70 as id,'I80-I82 หลอดเลือดดำอักเสบ หลอดเลือดดำอักเสบมีลิ่มเลือดก้อนเลือดและลิ่มเลือดในหลอดเลือดดำ' as name,'I80' as code1,'I81' as code2 union
                            select 71 as id,'I83 หลอดเลือดดำขอดของระยางส่วนล่าง'  as name,'I83' as code1,'I83' as code2 union
                            select 72 as id,'I84 ริดสีดวงทวาร'  as name,'I84' as code1,'I84' as code2 union
                            select 73 as id,'I85-I99 โรคอื่น ๆ ของระบบไหลเวียนโลหิต' as name,'I84' as code1,'I99' as code2 union
                            select 74 as id,'J02-J03 คออักเสบเฉียบพลันและต่อมทอนซิลอักเสบเฉียบพลัน' as name,'J02' as code1,'J03' as code2 union
                            select 75 as id,'J04 กล่องเสียงและหลอดลมใหญ่อักเสบเฉียบพลัน' as name,'J04' as code1,'J04' as code2 union
                            select 76 as id,'J00-J01, J05-J06 การติดเชื้อของทางเดินหายใจส่วนบนแบบเฉียบพลันอื่น ๆ' as name,'J00' as code1,'J01' as code2 union
                            select 76 as id,'J00-J01, J05-J06 การติดเชื้อของทางเดินหายใจส่วนบนแบบเฉียบพลันอื่น ๆ' as name,'J05' as code1,'J06' as code2 union
                            select 77 as id,'J09-J11 ไข้หวัดใหญ่' as name,'J09' as code1,'J11' as code2 union
                            select 78 as id,'J12-J18 ปอดบวม'  as name,'J12' as code1,'J18' as code2 union
                            select 79 as id,'A40-A41 โลหิตเป็นพิษ' as name,'A40' as code1,'A41' as code2 union
                            select 80 as id,'J20-J21 หลอดลมอักเสบเฉียบพลันและหลอดลมเล็กอักเสบเฉียบพลัน'  as name,'J20' as code1,'J21' as code2 union
                            select 81 as id,'J32 ไซนัสอักเสบเรื้อรัง' as name,'J32' as code1,'J32' as code2 union
                            select 82 as id,'J30-J31, J33-J34 โรคอื่นของจมูกและไซนัส' as name,'J30' as code1,'J31' as code2 union
                            select 82 as id,'J30-J31, J33-J34 โรคอื่นของจมูกและไซนัส' as name,'J33' as code1,'J34' as code2 union
                            select 83 as id,'J35 โรคเรื้อรังของต่อมทอนซิลและต่อมน้ำเหลืองในคอ'  as name,'J35' as code1,'J35' as code2 union
                            select 84 as id,'J36-J39 โรคอื่น ๆ ของระบบหายใจส่วนบน'as name,'J36' as code1,'J39' as code2 union
                            select 85 as id,'J40-J44 โรคหลอดลมอักเสบ ถุงลมโป่งพองและปอดชนิดอุดกั้นแบบเรื้อรังอื่น' as name,'J40' as code1,'J44' as code2 union
                            select 86 as id,'J45-J46 โรคหืด'  as name,'J45' as code1,'J46' as code2 union
                            select 87 as id,'J47 โรคหลอดลมเล็กโป่งพอง' as name,'J47' as code1,'J47' as code2 union
                            select 88 as id,'J60-J65 โรคฝุ่นสะสมในปอด' as name,'J60' as code1,'J65' as code2 union
                            select 89 as id,'J22, J66-J99 โรคอื่น ๆ ของระบบทางเดินหายใจ' as name,'J22' as code1,'J22' as code2 union
                                select 89 as id,'J22, J66-J99 โรคอื่น ๆ ของระบบทางเดินหายใจ' as name,'J66' as code1,'J99' as code2 union
                            select 90 as id,'A21-A22, A24-A28,A31-A32, A38, A42-A49  โรคจากแบคทีเรียอื่น ๆ' as name,'A21' as code1,'A22' as code2 union
                            select 90 as id,'A21-A22, A24-A28,A31-A32, A38, A42-A49  โรคจากแบคทีเรียอื่น ๆ' as name,'A24' as code1,'A28' as code2 union
                            select 90 as id,'A21-A22, A24-A28,A31-A32, A38, A42-A49  โรคจากแบคทีเรียอื่น ๆ' as name,'A31' as code1,'A32' as code2 union
                            select 90 as id,'A21-A22, A24-A28,A31-A32, A38, A42-A49  โรคจากแบคทีเรียอื่น ๆ' as name,'A38' as code1,'A38' as code2 union
                            select 90 as id,'A21-A22, A24-A28,A31-A32, A38, A42-A49  โรคจากแบคทีเรียอื่น ๆ' as name,'A42' as code1,'A49' as code2 union
                            select 91 as id,'K02 ฟันผุ'  as name,'K02' as code1,'K02' as code2 union
                            select 92 as id,'K00-K01, K03-K08 ความผิดปกติอื่น ๆ ของฟันและโครงสร้าง' as name,'K00' as code1,'K01' as code2 union
                            select 92 as id,'K00-K01, K03-K08 ความผิดปกติอื่น ๆ ของฟันและโครงสร้าง' as name,'K03' as code1,'K08' as code2 union
                            select 93 as id,'K09-K14 โรคอื่น ๆ ของช่องปาก ต่อมน้ำลายและขากรรไกร' as name,'K09' as code1,'K14' as code2 union
                            select 94 as id,'K25-K27 แผลเปื่อยของกระเพาะอาหารดูโอเดนัม'  as name,'K25' as code1,'K27' as code2 union
                            select 95 as id,'K29 กระเพาะอาหารอักเสบและดูโอเดนัมอักเสบ' as name,'K29' as code1,'K29' as code2 union
                            select 96 as id,'K20-K23, K28, K30-K31 โรคอื่น ๆ ของหลอดอาหาร กระเพาะและดูโอเดนัม' as name,'K20' as code1,'K23' as code2 union
                            select 96 as id,'K20-K23, K28, K30-K31 โรคอื่น ๆ ของหลอดอาหาร กระเพาะและดูโอเดนัม' as name,'K28' as code1,'K28' as code2 union
                            select 96 as id,'K20-K23, K28, K30-K31 โรคอื่น ๆ ของหลอดอาหาร กระเพาะและดูโอเดนัม' as name,'K30' as code1,'K31' as code2 union
                            select 97 as id,'K35-K38 โรคของไส้ติ่ง'  as name,'K35' as code1,'K38' as code2 union
                            select 98 as id,'K40 ไส้เลื่อนที่บริเวณขาหนีบ' as name,'K40' as code1,'K40' as code2 union
                            select 99 as id,'K41-K46 ไส้เลื่อนอื่น ๆ' as name,'K41' as code1,'K46' as code2 union
                            select 100 as id,'K50-K51 โรคโครนและลำไส้ใหญ่อักเสบแผลเปื่อย' as name,'K50' as code1,'K51' as code2 union
                            select 101 as id,'A50 ซิฟิลิสแต่กำเนิด' as name,'A50' as code1,'A50' as code2 union
                            select 102 as id,'K56 ลำไส้ไม่ทำงานและลำไส้เกิดอุดตันแบบไม่มีไส้เลื่อน' as name,'K56' as code1,'K56' as code2 union
                            select 103 as id,'K57 Paralytic ileus and intestinal obstruction without hernia' as name,'K57' as code1,'K57' as code2 union
                            select 104 as id,'K52-K55, K58-K67 โรคอื่น ๆ ของลำไส้และเยื่อบุช่องท้อง'  as name,'K52' as code1,'K55' as code2 union
                            select 104 as id,'K52-K55, K58-K67 โรคอื่น ๆ ของลำไส้และเยื่อบุช่องท้อง'  as name,'K58' as code1,'K67' as code2 union
                            select 105 as id,'K70 โรคตับเกี่ยวกับอัลกอฮอล์' as name,'K70' as code1,'K70' as code2 union
                            select 106 as id,'K71-K77 โรคอื่น ๆ ของตับ' as name,'K71' as code1,'K77' as code2 union
                            select 107 as id,'K80-K81 โรคนิ่วในระบบน้ำดีและถุงน้ำดีอักเสบ'  as name,'K80' as code1,'K81' as code2 union
                            select 108 as id,'K85-K86 ตับอ่อนอักเสบเฉียบพลันและโรคอื่น ๆ ของตับอ่อน' as name,'K85' as code1,'K86' as code2 union
                            select 109 as id,'K82-K83, K87-K93 โรคอื่น ๆ ของระบบย่อยอาหาร' as name,'K82' as code1,'K83' as code2 union
                                    select 109 as id,'K82-K83, K87-K93 โรคอื่น ๆ ของระบบย่อยอาหาร' as name,'K87' as code1,'K93' as code2 union
                            select 110 as id,'L00-L08 โรคอักเสบติดเชื้อของผิวหนังและนื้อเยื่อใต้ผิวหนัง' as name,'L00' as code1,'L08' as code2 union
                            select 111 as id,'L10-L99 โรคอื่น ๆ ของผิวหนังและเนื้อเยื่อใต้ผิวหนัง'  as name,'L10' as code1,'L99' as code2 union
                            select 112 as id,'A01 ไข้รากสาดน้อยและไข้รากสาดเทียม' as name,'A01' as code1,'A01' as code2 union
                            select 113 as id,'A51 ซิฟิลิสระยะเริ่ม' as name,'A51' as code1,'A51' as code2 union
                            select 114 as id,'M05-M14 ข้ออักเสบรูห์มาตอยและข้ออักเสบหลายข้อ' as name,'M05' as code1,'M14' as code2 union
                            select 115 as id,'M15-M19 โรคข้อเสื่อม' as name,'M15' as code1,'M19' as code2 union
                            select 116 as id,'M20-M21 ความพิการของแขนขา' as name,'M20' as code1,'M21' as code2 union
                            select 117 as id,'M00-M03, M22-M25 ความผิดปกติอื่น ๆ ของข้อ'  as name,'M00' as code1,'M03' as code2 union
                            select 117 as id,'M00-M03, M22-M25 ความผิดปกติอื่น ๆ ของข้อ'  as name,'M22' as code1,'M25' as code2 union
                            select 118 as id,'M30-M36 ความผิดปกติของระบบเนื้อเยื่อประสาน'as name,'M30' as code1,'M36' as code2 union
                            select 119 as id,'M50-M51 กระดูกสันหลังและหมอนรองกระดูกสันหลังอื่น ๆ ผิดปกติ' as name,'M50' as code1,'M51' as code2 union
                            select 120 as id,'M40-M49, M53-M54 พยาธิสภาพของหลังส่วนอื่น ๆ'  as name,'M40' as code1,'M49' as code2 union
                                    select 120 as id,'M40-M49, M53-M54 พยาธิสภาพของหลังส่วนอื่น ๆ'  as name,'M53' as code1,'M54' as code2 union
                            select 121 as id,'M60-M79 เนื้อเยื่อผิดปกติ'  as name,'M60' as code1,'M79' as code2 union
                            select 122 as id,'M80-M85 ความผิดปกติของความหนาแน่นของเนื้อกระดูกและโครงสร้าง' as name,'M80' as code1,'M85' as code2 union
                            select 123 as id,'M86 กระดูกอักเสบ'  as name,'M86' as code1,'M86' as code2 union
                            select 124 as id,'A52-A53 ซิฟิลิสอื่น ๆ' as name,'A52' as code1,'A53' as code2 union
                            select 125 as id,'M87-M99 โรคอื่น ๆ ของระบบกล้ามเนื้อและเนื้อเยื่อประสาน' as name,'M87' as code1,'M99' as code2 union
                            select 126 as id,'N00-N01 กลุ่มอาการไตอักเสบเฉียบพลันและชนิดกำเริบเร็ว' as name,'N00' as code1,'N01' as code2 union
                            select 127 as id,'N02-N08 โรคของหน่วยไตอื่น ๆ' as name,'N02' as code1,'N08' as code2 union
                            select 128 as id,'N10-N16 โรคของท่อและเนื้อเยื่อระหว่างท่อในไต' as name,'N10' as code1,'N16' as code2 union
                            select 129 as id,'N17-N19 ไตวาย' as name,'N17' as code1,'N19'as code2 union
                            select 130 as id,'N20-N23 นิ่วในระบบทางเดินปัสสาวะ'  as name,'N20' as code1,'N23' as code2 union
                            select 131 as id,'N30 กระเพาะปัสสาวะอักเสบ' as name,'N30' as code1,'N30' as code2 union
                            select 132 as id,'N25-N29, N31-N39 โรคอื่น ๆ ของระบบทางเดินปัสสาวะ' as name,'N25' as code1,'N29' as code2 union
                                    select 132 as id,'N25-N29, N31-N39 โรคอื่น ๆ ของระบบทางเดินปัสสาวะ' as name,'N31' as code1,'N39' as code2 union
                            select 133 as id,'N40 ต่อมลูกหมากโตจากการเพิ่มจำนวนเซล' as name,'N40' as code1,'N40' as code2 union
                            select 134 as id,'N41-N42 ความผิดปกติอื่น ๆ ของต่อมลูกหมาก'  as name,'N41' as code1,'N42' as code2 union
                            select 135 as id,'A54 การติดเชื้อหนองใน' as name,'A54' as code1,'A51' as code2 union
                            select 136 as id,'N43 ถุงน้ำและถุงที่มีอสุจิที่อัณทะ' as name,'N43' as code1,'N43' as code2 union
                            select 137 as id,'N47 หนังหุ้มปลายองคชาติยาวเกินไป ปลายตีบรูเปิดไม่ได้หรือเปิดลำบาก' as name,'N47' as code1,'N47' as code2 union
                            select 138 as id,'N44-N46, N48-N51 โรคอื่น ๆ ของอวัยวะสืบพันธุ์ชาย'  as name,'N44' as code1,'N46' as code2 union
                            select 138 as id,'N44-N46, N48-N51 โรคอื่น ๆ ของอวัยวะสืบพันธุ์ชาย'  as name,'N48' as code1,'N51' as code2 union
                            select 139 as id,'N60-N64 ความผิดปกติของเต้านม'  as name,'N60' as code1,'N64' as code2 union
                            select 140 as id,'N70 ปีกมดลูกและรังไข่อักเสบ' as name,'N70' as code1,'N70' as code2 union
                            select 141 as id,'N72 ปากมดลูกอักเสบ' as name,'N72' as code1,'N72' as code2 union
                            select 142 as id,'N71, N73-N77 การอักเสบอื่น ๆ ของอวัยวะในอุ้งเชิงกรานสตรี' as name,'N71' as code1,'N71' as code2 union
                                        select 142 as id,'N71, N73-N77 การอักเสบอื่น ๆ ของอวัยวะในอุ้งเชิงกรานสตรี' as name,'N73' as code1,'N77' as code2 union
                            select 143 as id,'N80 เยื่อบุมดลูกอยู่ผิดที่' as name,'N80' as code1,'N80' as code2 union
                            select 144 as id,'N81 การหย่อนตัวออกมาของอวัยวะสืบพันธุ์สตรี' as name,'N81' as code1,'N81' as code2 union
                            select 145 as id,'N83 ความผิดปกติอื่นที่ไม่ใช่การอักเสบของรังไข่ ท่อรังไข่และเอ็นยึดมดลูก' as name,'N83' as code1,'N83' as code2 union
                            select 146 as id,'A55-A56 โรคติดต่อทางเพศสัมพันธ์จากเชื้อคลามัยเดีย'  as name,'A55' as code1,'A56' as code2 union
                                select 147 as id,'N91-N92 ความผิดปกติของระดู'  as name,'N91' as code1,'N92' as code2 union
                                    select 148 as id,'N95 การหมดประจำเดือนและความผิดปกติอื่นในระยะหมดประจำเดือน' as name,'N95' as code1,'N95' as code2 union
                                        select 149 as id,'N97 ภาวะมีบุตรยากในสตรี' as name,'N97' as code1,'N97' as code2 union
                            select 150 as id,'N82, N84-N90, N93-N94, N96, N98-N99 ความผิดปกติอื่น ๆ ของท่อทางเดินปัสสาวะและสืบพันธุ์' as name,'N82' as code1,'N82' as code2 union
                                select 150 as id,'N82, N84-N90, N93-N94, N96, N98-N99 ความผิดปกติอื่น ๆ ของท่อทางเดินปัสสาวะและสืบพันธุ์' as name,'N84' as code1,'N90' as code2 union
                                    select 150 as id,'N82, N84-N90, N93-N94, N96, N98-N99 ความผิดปกติอื่น ๆ ของท่อทางเดินปัสสาวะและสืบพันธุ์' as name,'N93' as code1,'N94' as code2 union
                                        select 150 as id,'N82, N84-N90, N93-N94, N96, N98-N99 ความผิดปกติอื่น ๆ ของท่อทางเดินปัสสาวะและสืบพันธุ์' as name,'N96' as code1,'N96' as code2 union
                                            select 150 as id,'N82, N84-N90, N93-N94, N96, N98-N99 ความผิดปกติอื่น ๆ ของท่อทางเดินปัสสาวะและสืบพันธุ์' as name,'N98' as code1,'N99' as code2 union
                            select 151 as id,'O03 แท้งเอง' as name,'O03' as code1,'O03' as code2 union
                            select 152 as id,'O04 การทำแท้งโดยเหตุผลทางการแพทย์'  as name,'O04' as code1,'O04' as code2 union
                            select 153 as id,'O00-O02, O05-O08 การตั้งครรภ์อื่น ๆ ที่สิ้นสุดโดยการแท้ง'  as name,'O00' as code1,'O02' as code2 union
                                select 153 as id,'O00-O02, O05-O08 การตั้งครรภ์อื่น ๆ ที่สิ้นสุดโดยการแท้ง'  as name,'O05' as code1,'O08' as code2 union
                            select 154 as id,'O10-O16 การบวม การมีโปรตีนในปัสสาวะ และความดันโลหิตสูงขณะตั้งครรภ์ ระยะคลอด และระยะหลังคลอด'  as name,'O10' as code1,'O16' as code2 union
                            select 155 as id,'O44-O46 รกเกาะต่ำ รกลอกตัวก่อนกำหนด และตกเลือดก่อนคลอด' as name,'O44' as code1,'O46' as code2 union
                            select 156 as id,'O30-O43, O47-O48 การดูแลมารดาอื่น ๆ ที่มีปัญหาเกี่ยวกับทารกในครรภ์ และถุงน้ำคร่ำ และปัญหาที่อาจจะเกิดได้ในระยะคลอด' as name,'O30' as code1,'O43' as code2 union
                                select 156 as id,'O30-O43, O47-O48 การดูแลมารดาอื่น ๆ ที่มีปัญหาเกี่ยวกับทารกในครรภ์ และถุงน้ำคร่ำ และปัญหาที่อาจจะเกิดได้ในระยะคลอด' as name,'O47' as code1,'O48' as code2 union
                            select 157 as id,'A57-A64 โรคติดเชื้ออื่น ๆ ที่ติดต่อทางเพศสัมพันธ์เป็นส่วนมาก' as name,'A57' as code1,'A64' as code2 union
                            select 158 as id,'O64-O66 การคลอดติดขัด' as name,'O64' as code1,'O66' as code2 union
                            select 159 as id,'O72 ตกเลือดหลังคลอด' as name,'O72' as code1,'O72' as code2 union
                            select 160 as id,'O20-O29, O60-O63, O67-O71, O73-O75, O81-O84 ภาวะแทรกซ้อนอื่น ๆของการตั้งครรภ์ และการคลอด' as name,'O20' as code1,'O29' as code2 union
                                select 160 as id,'O20-O29, O60-O63, O67-O71, O73-O75, O81-O84 ภาวะแทรกซ้อนอื่น ๆของการตั้งครรภ์ และการคลอด' as name,'O60' as code1,'O63' as code2 union
                                    select 160 as id,'O20-O29, O60-O63, O67-O71, O73-O75, O81-O84 ภาวะแทรกซ้อนอื่น ๆของการตั้งครรภ์ และการคลอด' as name,'O67' as code1,'O71' as code2 union
                                        select 160 as id,'O20-O29, O60-O63, O67-O71, O73-O75, O81-O84 ภาวะแทรกซ้อนอื่น ๆของการตั้งครรภ์ และการคลอด' as name,'O73' as code1,'O75' as code2 union
                                            select 160 as id,'O20-O29, O60-O63, O67-O71, O73-O75, O81-O84 ภาวะแทรกซ้อนอื่น ๆของการตั้งครรภ์ และการคลอด' as name,'O81' as code1,'O84' as code2 union
                            select 161 as id,'O80 การคลอดของครรภ์เดี่ยว'  as name,'O80' as code1,'O80' as code2 union
                            select 162 as id,'O85-O99 ภาวะแทรกซ้อนที่ส่วนใหญ่พบในระยะหลังคลอด และภาวะทางสูติกรรมอื่น ๆ ที่มิได้ระบุรายละเอียด' as name,'O85' as code1,'O99' as code2 union
                            select 163 as id,'P00-P04 ทารกในครรภ์และแรกเกิดที่ได้รับผลจากปัจจัยทางมารดา และโรคแทรกในระยะตั้งครรภ์ เจ็บครรภ์ และคลอด' as name,'P00' as code1,'P04' as code2 union
                            select 164 as id,'P05-P07 ทารกในครรภ์โตช้า ทารกในครรภ์ขาดสารอาหาร และความผิดปกติเกี่ยวกับการตั้งครรภ์ระยะสั้น และน้ำหนักทารกแรกเกิดน้อย'  as name,'P05' as code1,'P06' as code2 union
                            select 165 as id,'P10-P15 บาดเจ็บจากการคลอด' as name,'P10' as code1,'P15' as code2 union
                            select 166 as id,'P20-P21 ขาดออกซิเจนขณะอยู่ในโพรงมดลูก และภาวะแอสฟิกเซียเมื่อแรกเกิด' as name,'P20' as code1,'P21' as code2 union
                            select 167 as id,'P22-P28 ภาวะหายใจผิดปกติอื่น ๆ ในระยะปริกำเปิด' as name,'P22' as code1,'P28' as code2 union
                            select 168 as id,'A68 ไข้กลับซ้ำ' as name,'A68' as code1,'A68' as code2 union
                            select 169 as id,'P35-P37 การติดเชื้อแต่กำเนิดและโรคปาราสิต'  as name,'P35' as code1,'P37' as code2 union
                            select 170 as id,'P38-P39 การติดเชื้อเฉพาะอื่น ๆ ในระยะปริกำเนิด' as name,'P38' as code1,'P39' as code2 union
                            select 171 as id,'P55 โรคเม็ดเลือดแตกของทารกในครรภ์และแรกเกิด' as name,'P55' as code1,'P55' as code2 union
                            select 172 as id,'P08, P29, P50-P54, P56-P96 ภาวะอื่น ๆ ในระยะปริกำเนิด' as name,'P08' as code1,'P08' as code2 union
                                select 172 as id,'P08, P29, P50-P54, P56-P96 ภาวะอื่น ๆ ในระยะปริกำเนิด' as name,'P29' as code1,'P29' as code2 union
                                    select 172 as id,'P08, P29, P50-P54, P56-P96 ภาวะอื่น ๆ ในระยะปริกำเนิด' as name,'P50' as code1,'P54' as code2 union
                                        select 172 as id,'P08, P29, P50-P54, P56-P96 ภาวะอื่น ๆ ในระยะปริกำเนิด' as name,'P56' as code1,'P96' as code2 union
                                
                            select 173 as id,'Q05 กระดูกสันหลังแยก' as name,'Q05' as code1,'Q05' as code2 union
                            select 174 as id,'Q00-Q04, Q06-Q07 ความผิดปกติอื่น ๆ แต่กำเนิดของระบบประสาท' as name,'Q00' as code1,'Q04' as code2 union
                                select 174 as id,'Q00-Q04, Q06-Q07 ความผิดปกติอื่น ๆ แต่กำเนิดของระบบประสาท' as name,'Q06' as code1,'Q07' as code2 union
                            select 175 as id,'Q20-Q28 ความผิดปกติแต่กำเนิดของระบบไหลเวียนโลหิต' as name,'Q20' as code1,'Q28' as code2 union
                            select 176 as id,'Q35-Q37 ปากแหว่งและเพดานโหว่' as name,'Q35' as code1,'Q37' as code2 union
                            select 177 as id,'Q41 ลำไส้เล็กไม่มี ตันและตีบ' as name,'Q41' as code1,'Q41' as code2 union
                            select 178 as id,'Q38-Q40, Q42-Q45 ความผิดปกติแต่กำเนิดอื่น ๆ ของระบบย่อยอาหาร' as name,'Q38' as code1,'Q40' as code2 union
                                select 178 as id,'Q38-Q40, Q42-Q45 ความผิดปกติแต่กำเนิดอื่น ๆ ของระบบย่อยอาหาร' as name,'Q42' as code1,'Q45' as code2 union
                            select 179 as id,'A71 โรคริดสีดวงตา'  as name,'A71' as code1,'A71' as code2 union
                            select 180 as id,'Q53 อัณฑะไม่ลงถุง'  as name,'Q53' as code1,'Q53' as code2 union
                            select 181 as id,'Q50-Q52, Q54-Q64 ความผิดปกติอื่น ๆ ของระบบสืบพันธุ์และทางเดินปัสสาวะ' as name,'Q50' as code1,'Q52' as code2 union
                                select 181 as id,'Q50-Q52, Q54-Q64 ความผิดปกติอื่น ๆ ของระบบสืบพันธุ์และทางเดินปัสสาวะ' as name,'Q54' as code1,'Q64' as code2 union
                            select 182 as id,'Q65 ความพิการแต่กำเนิดของสะโพก' as name,'Q65' as code1,'Q65' as code2 union
                            select 183 as id,'Q66 ความพิการแต่กำเนิดของเท้า'  as name,'Q66' as code1,'Q66' as code2 union
                            select 184 as id,'Q67-Q79 ความผิดปกติและความพิการแต่กำเนิดอื่น ๆ ของระบบกล้ามเนื้อและโครงร่าง' as name,'Q67' as code1,'Q79' as code2 union
                            select 185 as id,'Q10-Q18, Q30-Q34, Q80-Q89 ความผิดปกติแต่กำเนิดอื่น ๆ' as name,'Q10' as code1,'Q18' as code2 union
                                select 185 as id,'Q10-Q18, Q30-Q34, Q80-Q89 ความผิดปกติแต่กำเนิดอื่น ๆ' as name,'Q30' as code1,'Q34' as code2 union
                                    select 185 as id,'Q10-Q18, Q30-Q34, Q80-Q89 ความผิดปกติแต่กำเนิดอื่น ๆ' as name,'Q80' as code1,'Q89' as code2 union
                            select 186 as id,'Q90-Q99 ความผิดปกติของโครโมโซมที่มิได้มีรหัสระบุไว้ที่อื่น' as name,'Q90' as code1,'Q99' as code2 union
                            select 187 as id,'R10 ปวดท้องและปวดอุ้งเชิงกราน' as name,'R10' as code1,'R10' as code2 union
                            select 188 as id,'R50 ไข้ไม่ทราบสาเหตุ' as name,'R50' as code1,'R50' as code2 union
                            select 189 as id,'R54 ชราภาพ' as name,'R54' as code1,'R54' as code2 union
                            select 190 as id,'A75 ไข้รากสาดใหญ่' as name,'A75' as code1,'A75' as code2 union
                            select 191 as id,'R00-R09, R11-R49, R51-R53, R55-R99 อาการ อาการแสดงและสิ่งผิดปกติที่พบจากการตรวจทางคลีนิกและตรวจทางห้องปฏิบัติการที่มิได้มีรหัสะบุไว้' as name,'R00' as code1,'R09' as code2 union
                                select 191 as id,'R00-R09, R11-R49, R51-R53, R55-R99 อาการ อาการแสดงและสิ่งผิดปกติที่พบจากการตรวจทางคลีนิกและตรวจทางห้องปฏิบัติการที่มิได้มีรหัสะบุไว้' as name,'R11' as code1,'R49' as code2 union
                                    select 191 as id,'R00-R09, R11-R49, R51-R53, R55-R99 อาการ อาการแสดงและสิ่งผิดปกติที่พบจากการตรวจทางคลีนิกและตรวจทางห้องปฏิบัติการที่มิได้มีรหัสะบุไว้' as name,'R51' as code1,'R53' as code2 union
                                        select 191 as id,'R00-R09, R11-R49, R51-R53, R55-R99 อาการ อาการแสดงและสิ่งผิดปกติที่พบจากการตรวจทางคลีนิกและตรวจทางห้องปฏิบัติการที่มิได้มีรหัสะบุไว้' as name,'R55' as code1,'R99' as code2 union
                            select 192 as id,'S02 กระดูกแตกหักบริเวณกระโหลกศีรษะและกระดูกหน้า' as name,'S02' as code1,'S02' as code2 union
                            select 193 as id,'S12, S22, S32, T08 กระดูกคอ กระดูกซี่โครง หรือกระดูกเชิงกรานหัก' as name,'S12' as code1,'S12' as code2 union
                                select 193 as id,'S12, S22, S32, T08 กระดูกคอ กระดูกซี่โครง หรือกระดูกเชิงกรานหัก' as name,'S22' as code1,'S22' as code2 union
                                    select 193 as id,'S12, S22, S32, T08 กระดูกคอ กระดูกซี่โครง หรือกระดูกเชิงกรานหัก' as name,'S32' as code1,'S32' as code2 union
                                        select 193 as id,'S12, S22, S32, T08 กระดูกคอ กระดูกซี่โครง หรือกระดูกเชิงกรานหัก' as name,'T08' as code1,'T08' as code2 union
                                
                            select 194 as id,'S72 กระดูกต้นขาแตก หัก ร้าว' as name,'S72' as code1,'S72' as code2 union
                            select 195 as id,'S42, S52, S62, S82, S92, T10, T12 กระดูกแตกหักของแขนขาอื่น ๆ' as name,'S42' as code1,'S42' as code2 union
                                select 195 as id,'S42, S52, S62, S82, S92, T10, T12 กระดูกแตกหักของแขนขาอื่น ๆ' as name,'S52' as code1,'S52' as code2 union
                                    select 195 as id,'S42, S52, S62, S82, S92, T10, T12 กระดูกแตกหักของแขนขาอื่น ๆ' as name,'S62' as code1,'S62' as code2 union
                                        select 195 as id,'S42, S52, S62, S82, S92, T10, T12 กระดูกแตกหักของแขนขาอื่น ๆ' as name,'S82' as code1,'S82' as code2 union
                                            select 195 as id,'S42, S52, S62, S82, S92, T10, T12 กระดูกแตกหักของแขนขาอื่น ๆ' as name,'S92' as code1,'S92' as code2 union
                                                select 195 as id,'S42, S52, S62, S82, S92, T10, T12 กระดูกแตกหักของแขนขาอื่น ๆ' as name,'T10' as code1,'T10' as code2 union
                                                    select 195 as id,'S42, S52, S62, S82, S92, T10, T12 กระดูกแตกหักของแขนขาอื่น ๆ' as name,'T12' as code1,'T12' as code2 union
                                        
                            select 196 as id,'T02 กระดูกแตกหักหลายบริเวณในร่างกาย' as name,'T02' as code1,'T02' as code2 union
                            select 197 as id,'S03, S13, S23, S33, S43,S53, S63, S73, S83, S93,T03 กระดูกเคลื่อน เคล็ด ขัด บริเวณร่างกายหลายแห่งที่ระบุเฉพาะ'  as name,'S03' as code1,'S03' as code2 union
                                select 197 as id,'S03, S13, S23, S33, S43,S53, S63, S73, S83, S93,T03 กระดูกเคลื่อน เคล็ด ขัด บริเวณร่างกายหลายแห่งที่ระบุเฉพาะ'  as name,'S13' as code1,'S13' as code2 union
                                    select 197 as id,'S03, S13, S23, S33, S43,S53, S63, S73, S83, S93,T03 กระดูกเคลื่อน เคล็ด ขัด บริเวณร่างกายหลายแห่งที่ระบุเฉพาะ'  as name,'S23' as code1,'S23' as code2 union
                                        select 197 as id,'S03, S13, S23, S33, S43,S53, S63, S73, S83, S93,T03 กระดูกเคลื่อน เคล็ด ขัด บริเวณร่างกายหลายแห่งที่ระบุเฉพาะ'  as name,'S33' as code1,'S33' as code2 union
                                            select 197 as id,'S03, S13, S23, S33, S43,S53, S63, S73, S83, S93,T03 กระดูกเคลื่อน เคล็ด ขัด บริเวณร่างกายหลายแห่งที่ระบุเฉพาะ'  as name,'S43' as code1,'S43' as code2 union
                                                select 197 as id,'S03, S13, S23, S33, S43,S53, S63, S73, S83, S93,T03 กระดูกเคลื่อน เคล็ด ขัด บริเวณร่างกายหลายแห่งที่ระบุเฉพาะ'  as name,'S53' as code1,'S53' as code2 union
                                                    select 197 as id,'S03, S13, S23, S33, S43,S53, S63, S73, S83, S93,T03 กระดูกเคลื่อน เคล็ด ขัด บริเวณร่างกายหลายแห่งที่ระบุเฉพาะ'  as name,'S63' as code1,'S63' as code2 union
                                                        select 197 as id,'S03, S13, S23, S33, S43,S53, S63, S73, S83, S93,T03 กระดูกเคลื่อน เคล็ด ขัด บริเวณร่างกายหลายแห่งที่ระบุเฉพาะ'  as name,'S73' as code1,'S73' as code2 union
                                                            select 197 as id,'S03, S13, S23, S33, S43,S53, S63, S73, S83, S93,T03 กระดูกเคลื่อน เคล็ด ขัด บริเวณร่างกายหลายแห่งที่ระบุเฉพาะ'  as name,'S83' as code1,'S83' as code2 union
                                                                select 197 as id,'S03, S13, S23, S33, S43,S53, S63, S73, S83, S93,T03 กระดูกเคลื่อน เคล็ด ขัด บริเวณร่างกายหลายแห่งที่ระบุเฉพาะ'  as name,'S93' as code1,'S93' as code2 union
                                                                        select 197 as id,'S03, S13, S23, S33, S43,S53, S63, S73, S83, S93,T03 กระดูกเคลื่อน เคล็ด ขัด บริเวณร่างกายหลายแห่งที่ระบุเฉพาะ'  as name,'T03' as code1,'T03' as code2 union
                            select 198 as id,'S05 การบาดเจ็บของตาและเบ้าตา'  as name,'S05' as code1,'S05' as code2 union
                            select 199 as id,'S06 การบาดเจ็บภายในกระโหลกศีรษะ' as name,'S06' as code1,'S06' as code2 union
                            select 200 as id,'S26-S27, S36-S37 การบาดเจ็บของอวัยวะภายในอื่น ๆ' as name,'S26' as code1,'S27' as code2 union
                                select 200 as id,'S26-S27, S36-S37 การบาดเจ็บของอวัยวะภายในอื่น ๆ' as name,'S36' as code1,'S37' as code2 union
                            select 201 as id,'A80 โรคโปลิโอเฉียบพลัน' as name,'A80' as code1,'A80' as code2 union
                            select 202 as id,'S07-S08, S17-S18, S28, S38, S47-S48, S57-S58, S67-S68, S77-S78, S87-S88, S97-S98, T04-T05 การบาดเจ็บจากการบดอัดและการบาดเจ็บที่เกิดจากตัดขาบริเวณร่างกายหลายแห่งที่ระบุเฉพาะ' as name,'S07' as code1,'S08' as code2 union
                                select 202 as id,'S07-S08, S17-S18, S28, S38, S47-S48, S57-S58, S67-S68, S77-S78, S87-S88, S97-S98, T04-T05 การบาดเจ็บจากการบดอัดและการบาดเจ็บที่เกิดจากตัดขาบริเวณร่างกายหลายแห่งที่ระบุเฉพาะ' as name,'S17' as code1,'S18' as code2 union
                                    select 202 as id,'S07-S08, S17-S18, S28, S38, S47-S48, S57-S58, S67-S68, S77-S78, S87-S88, S97-S98, T04-T05 การบาดเจ็บจากการบดอัดและการบาดเจ็บที่เกิดจากตัดขาบริเวณร่างกายหลายแห่งที่ระบุเฉพาะ' as name,'S28' as code1,'S28' as code2 union
                                        select 202 as id,'S07-S08, S17-S18, S28, S38, S47-S48, S57-S58, S67-S68, S77-S78, S87-S88, S97-S98, T04-T05 การบาดเจ็บจากการบดอัดและการบาดเจ็บที่เกิดจากตัดขาบริเวณร่างกายหลายแห่งที่ระบุเฉพาะ' as name,'S38' as code1,'S38' as code2 union
                                            select 202 as id,'S07-S08, S17-S18, S28, S38, S47-S48, S57-S58, S67-S68, S77-S78, S87-S88, S97-S98, T04-T05 การบาดเจ็บจากการบดอัดและการบาดเจ็บที่เกิดจากตัดขาบริเวณร่างกายหลายแห่งที่ระบุเฉพาะ' as name,'S47' as code1,'S48' as code2 union
                                                select 202 as id,'S07-S08, S17-S18, S28, S38, S47-S48, S57-S58, S67-S68, S77-S78, S87-S88, S97-S98, T04-T05 การบาดเจ็บจากการบดอัดและการบาดเจ็บที่เกิดจากตัดขาบริเวณร่างกายหลายแห่งที่ระบุเฉพาะ' as name,'S57' as code1,'S58' as code2 union
                                                    select 202 as id,'S07-S08, S17-S18, S28, S38, S47-S48, S57-S58, S67-S68, S77-S78, S87-S88, S97-S98, T04-T05 การบาดเจ็บจากการบดอัดและการบาดเจ็บที่เกิดจากตัดขาบริเวณร่างกายหลายแห่งที่ระบุเฉพาะ' as name,'S67' as code1,'S68' as code2 union
                                                        select 202 as id,'S07-S08, S17-S18, S28, S38, S47-S48, S57-S58, S67-S68, S77-S78, S87-S88, S97-S98, T04-T05 การบาดเจ็บจากการบดอัดและการบาดเจ็บที่เกิดจากตัดขาบริเวณร่างกายหลายแห่งที่ระบุเฉพาะ' as name,'S77' as code1,'S78' as code2 union
                                                            select 202 as id,'S07-S08, S17-S18, S28, S38, S47-S48, S57-S58, S67-S68, S77-S78, S87-S88, S97-S98, T04-T05 การบาดเจ็บจากการบดอัดและการบาดเจ็บที่เกิดจากตัดขาบริเวณร่างกายหลายแห่งที่ระบุเฉพาะ' as name,'S87' as code1,'S88' as code2 union
                                                                select 202 as id,'S07-S08, S17-S18, S28, S38, S47-S48, S57-S58, S67-S68, S77-S78, S87-S88, S97-S98, T04-T05 การบาดเจ็บจากการบดอัดและการบาดเจ็บที่เกิดจากตัดขาบริเวณร่างกายหลายแห่งที่ระบุเฉพาะ' as name,'S97' as code1,'S98' as code2 union
                                                                    select 202 as id,'S07-S08, S17-S18, S28, S38, S47-S48, S57-S58, S67-S68, S77-S78, S87-S88, S97-S98, T04-T05 การบาดเจ็บจากการบดอัดและการบาดเจ็บที่เกิดจากตัดขาบริเวณร่างกายหลายแห่งที่ระบุเฉพาะ' as name,'T04' as code1,'T05' as code2 union
                                            select 203 as id,'S00-S01,S04,S09-S11,S14-S16,S19-S21,S24-S25, S29-S31,S34-S35,S39-S41,S44-S46,S49-S51,S54-S56,S59-S61,S64-S66,S69-S71,S74-S76,S79-S81,S84-S86,S89-S91,S94-S96,S99,T00-T01, T06-T07,T09,T11,T13-T14 การบาดเจ็บระบุเฉพาะอื่น ๆ , ไม่ระบุเฉพาะและหลายบริเวณในร่างกาย' as name,'S00' as code1,'S01' as code2 union
                                                select 203 as id,'S00-S01,S04,S09-S11,S14-S16,S19-S21,S24-S25, S29-S31,S34-S35,S39-S41,S44-S46,S49-S51,S54-S56,S59-S61,S64-S66,S69-S71,S74-S76,S79-S81,S84-S86,S89-S91,S94-S96,S99,T00-T01, T06-T07,T09,T11,T13-T14 การบาดเจ็บระบุเฉพาะอื่น ๆ , ไม่ระบุเฉพาะและหลายบริเวณในร่างกาย' as name,'S04' as code1,'S04' as code2 union
                                                    select 203 as id,'S00-S01,S04,S09-S11,S14-S16,S19-S21,S24-S25, S29-S31,S34-S35,S39-S41,S44-S46,S49-S51,S54-S56,S59-S61,S64-S66,S69-S71,S74-S76,S79-S81,S84-S86,S89-S91,S94-S96,S99,T00-T01, T06-T07,T09,T11,T13-T14 การบาดเจ็บระบุเฉพาะอื่น ๆ , ไม่ระบุเฉพาะและหลายบริเวณในร่างกาย' as name,'S09' as code1,'S11' as code2 union
                                                        select 203 as id,'S00-S01,S04,S09-S11,S14-S16,S19-S21,S24-S25, S29-S31,S34-S35,S39-S41,S44-S46,S49-S51,S54-S56,S59-S61,S64-S66,S69-S71,S74-S76,S79-S81,S84-S86,S89-S91,S94-S96,S99,T00-T01, T06-T07,T09,T11,T13-T14 การบาดเจ็บระบุเฉพาะอื่น ๆ , ไม่ระบุเฉพาะและหลายบริเวณในร่างกาย' as name,'S14' as code1,'S16' as code2 union
                                                            select 203 as id,'S00-S01,S04,S09-S11,S14-S16,S19-S21,S24-S25, S29-S31,S34-S35,S39-S41,S44-S46,S49-S51,S54-S56,S59-S61,S64-S66,S69-S71,S74-S76,S79-S81,S84-S86,S89-S91,S94-S96,S99,T00-T01, T06-T07,T09,T11,T13-T14 การบาดเจ็บระบุเฉพาะอื่น ๆ , ไม่ระบุเฉพาะและหลายบริเวณในร่างกาย' as name,'S19' as code1,'S21' as code2 union
                                                                select 203 as id,'S00-S01,S04,S09-S11,S14-S16,S19-S21,S24-S25, S29-S31,S34-S35,S39-S41,S44-S46,S49-S51,S54-S56,S59-S61,S64-S66,S69-S71,S74-S76,S79-S81,S84-S86,S89-S91,S94-S96,S99,T00-T01, T06-T07,T09,T11,T13-T14 การบาดเจ็บระบุเฉพาะอื่น ๆ , ไม่ระบุเฉพาะและหลายบริเวณในร่างกาย' as name,'S24' as code1,'S25' as code2 union
                                                                    select 203 as id,'S00-S01,S04,S09-S11,S14-S16,S19-S21,S24-S25, S29-S31,S34-S35,S39-S41,S44-S46,S49-S51,S54-S56,S59-S61,S64-S66,S69-S71,S74-S76,S79-S81,S84-S86,S89-S91,S94-S96,S99,T00-T01, T06-T07,T09,T11,T13-T14 การบาดเจ็บระบุเฉพาะอื่น ๆ , ไม่ระบุเฉพาะและหลายบริเวณในร่างกาย' as name,'S29' as code1,'S31' as code2 union
                                                                        select 203 as id,'S00-S01,S04,S09-S11,S14-S16,S19-S21,S24-S25, S29-S31,S34-S35,S39-S41,S44-S46,S49-S51,S54-S56,S59-S61,S64-S66,S69-S71,S74-S76,S79-S81,S84-S86,S89-S91,S94-S96,S99,T00-T01, T06-T07,T09,T11,T13-T14 การบาดเจ็บระบุเฉพาะอื่น ๆ , ไม่ระบุเฉพาะและหลายบริเวณในร่างกาย' as name,'S34' as code1,'S35' as code2 union
                                                                            select 203 as id,'S00-S01,S04,S09-S11,S14-S16,S19-S21,S24-S25, S29-S31,S34-S35,S39-S41,S44-S46,S49-S51,S54-S56,S59-S61,S64-S66,S69-S71,S74-S76,S79-S81,S84-S86,S89-S91,S94-S96,S99,T00-T01, T06-T07,T09,T11,T13-T14 การบาดเจ็บระบุเฉพาะอื่น ๆ , ไม่ระบุเฉพาะและหลายบริเวณในร่างกาย' as name,'S39' as code1,'S41' as code2 union
                                                                                select 203 as id,'S00-S01,S04,S09-S11,S14-S16,S19-S21,S24-S25, S29-S31,S34-S35,S39-S41,S44-S46,S49-S51,S54-S56,S59-S61,S64-S66,S69-S71,S74-S76,S79-S81,S84-S86,S89-S91,S94-S96,S99,T00-T01, T06-T07,T09,T11,T13-T14 การบาดเจ็บระบุเฉพาะอื่น ๆ , ไม่ระบุเฉพาะและหลายบริเวณในร่างกาย' as name,'S44' as code1,'S46' as code2 union
                                                                                    select 203 as id,'S00-S01,S04,S09-S11,S14-S16,S19-S21,S24-S25, S29-S31,S34-S35,S39-S41,S44-S46,S49-S51,S54-S56,S59-S61,S64-S66,S69-S71,S74-S76,S79-S81,S84-S86,S89-S91,S94-S96,S99,T00-T01, T06-T07,T09,T11,T13-T14 การบาดเจ็บระบุเฉพาะอื่น ๆ , ไม่ระบุเฉพาะและหลายบริเวณในร่างกาย' as name,'S49' as code1,'S51' as code2 union
                                                                                        select 203 as id,'S00-S01,S04,S09-S11,S14-S16,S19-S21,S24-S25, S29-S31,S34-S35,S39-S41,S44-S46,S49-S51,S54-S56,S59-S61,S64-S66,S69-S71,S74-S76,S79-S81,S84-S86,S89-S91,S94-S96,S99,T00-T01, T06-T07,T09,T11,T13-T14 การบาดเจ็บระบุเฉพาะอื่น ๆ , ไม่ระบุเฉพาะและหลายบริเวณในร่างกาย' as name,'S54' as code1,'S56' as code2 union
                                                                                            select 203 as id,'S00-S01,S04,S09-S11,S14-S16,S19-S21,S24-S25, S29-S31,S34-S35,S39-S41,S44-S46,S49-S51,S54-S56,S59-S61,S64-S66,S69-S71,S74-S76,S79-S81,S84-S86,S89-S91,S94-S96,S99,T00-T01, T06-T07,T09,T11,T13-T14 การบาดเจ็บระบุเฉพาะอื่น ๆ , ไม่ระบุเฉพาะและหลายบริเวณในร่างกาย' as name,'S59' as code1,'S61' as code2 union
                                                                                                select 203 as id,'S00-S01,S04,S09-S11,S14-S16,S19-S21,S24-S25, S29-S31,S34-S35,S39-S41,S44-S46,S49-S51,S54-S56,S59-S61,S64-S66,S69-S71,S74-S76,S79-S81,S84-S86,S89-S91,S94-S96,S99,T00-T01, T06-T07,T09,T11,T13-T14 การบาดเจ็บระบุเฉพาะอื่น ๆ , ไม่ระบุเฉพาะและหลายบริเวณในร่างกาย' as name,'S64' as code1,'S66' as code2 union
                                                                                                    select 203 as id,'S00-S01,S04,S09-S11,S14-S16,S19-S21,S24-S25, S29-S31,S34-S35,S39-S41,S44-S46,S49-S51,S54-S56,S59-S61,S64-S66,S69-S71,S74-S76,S79-S81,S84-S86,S89-S91,S94-S96,S99,T00-T01, T06-T07,T09,T11,T13-T14 การบาดเจ็บระบุเฉพาะอื่น ๆ , ไม่ระบุเฉพาะและหลายบริเวณในร่างกาย' as name,'S69' as code1,'S71' as code2 union
                                                                                                        select 203 as id,'S00-S01,S04,S09-S11,S14-S16,S19-S21,S24-S25, S29-S31,S34-S35,S39-S41,S44-S46,S49-S51,S54-S56,S59-S61,S64-S66,S69-S71,S74-S76,S79-S81,S84-S86,S89-S91,S94-S96,S99,T00-T01, T06-T07,T09,T11,T13-T14 การบาดเจ็บระบุเฉพาะอื่น ๆ , ไม่ระบุเฉพาะและหลายบริเวณในร่างกาย' as name,'S74' as code1,'S76' as code2 union
                                                                                                            select 203 as id,'S00-S01,S04,S09-S11,S14-S16,S19-S21,S24-S25, S29-S31,S34-S35,S39-S41,S44-S46,S49-S51,S54-S56,S59-S61,S64-S66,S69-S71,S74-S76,S79-S81,S84-S86,S89-S91,S94-S96,S99,T00-T01, T06-T07,T09,T11,T13-T14 การบาดเจ็บระบุเฉพาะอื่น ๆ , ไม่ระบุเฉพาะและหลายบริเวณในร่างกาย' as name,'S79' as code1,'S81' as code2 union
                                                                                                                select 203 as id,'S00-S01,S04,S09-S11,S14-S16,S19-S21,S24-S25, S29-S31,S34-S35,S39-S41,S44-S46,S49-S51,S54-S56,S59-S61,S64-S66,S69-S71,S74-S76,S79-S81,S84-S86,S89-S91,S94-S96,S99,T00-T01, T06-T07,T09,T11,T13-T14 การบาดเจ็บระบุเฉพาะอื่น ๆ , ไม่ระบุเฉพาะและหลายบริเวณในร่างกาย' as name,'S84' as code1,'S86' as code2 union
                                                                                                                
                                                                                                                    select 203 as id,'S00-S01,S04,S09-S11,S14-S16,S19-S21,S24-S25, S29-S31,S34-S35,S39-S41,S44-S46,S49-S51,S54-S56,S59-S61,S64-S66,S69-S71,S74-S76,S79-S81,S84-S86,S89-S91,S94-S96,S99,T00-T01, T06-T07,T09,T11,T13-T14 การบาดเจ็บระบุเฉพาะอื่น ๆ , ไม่ระบุเฉพาะและหลายบริเวณในร่างกาย' as name,'S89' as code1,'S91' as code2 union
                                                                                                                
                                                                                                                        select 203 as id,'S00-S01,S04,S09-S11,S14-S16,S19-S21,S24-S25, S29-S31,S34-S35,S39-S41,S44-S46,S49-S51,S54-S56,S59-S61,S64-S66,S69-S71,S74-S76,S79-S81,S84-S86,S89-S91,S94-S96,S99,T00-T01, T06-T07,T09,T11,T13-T14 การบาดเจ็บระบุเฉพาะอื่น ๆ , ไม่ระบุเฉพาะและหลายบริเวณในร่างกาย' as name,'S94' as code1,'S96' as code2 union
                                                                                                                                select 203 as id,'S00-S01,S04,S09-S11,S14-S16,S19-S21,S24-S25, S29-S31,S34-S35,S39-S41,S44-S46,S49-S51,S54-S56,S59-S61,S64-S66,S69-S71,S74-S76,S79-S81,S84-S86,S89-S91,S94-S96,S99,T00-T01, T06-T07,T09,T11,T13-T14 การบาดเจ็บระบุเฉพาะอื่น ๆ , ไม่ระบุเฉพาะและหลายบริเวณในร่างกาย' as name,'S99' as code1,'S99' as code2 union
                                                                                                                                    select 203 as id,'S00-S01,S04,S09-S11,S14-S16,S19-S21,S24-S25, S29-S31,S34-S35,S39-S41,S44-S46,S49-S51,S54-S56,S59-S61,S64-S66,S69-S71,S74-S76,S79-S81,S84-S86,S89-S91,S94-S96,S99,T00-T01, T06-T07,T09,T11,T13-T14 การบาดเจ็บระบุเฉพาะอื่น ๆ , ไม่ระบุเฉพาะและหลายบริเวณในร่างกาย' as name,'S99' as code1,'S99' as code2 union
                                                                                                                                        select 203 as id,'S00-S01,S04,S09-S11,S14-S16,S19-S21,S24-S25, S29-S31,S34-S35,S39-S41,S44-S46,S49-S51,S54-S56,S59-S61,S64-S66,S69-S71,S74-S76,S79-S81,S84-S86,S89-S91,S94-S96,S99,T00-T01, T06-T07,T09,T11,T13-T14 การบาดเจ็บระบุเฉพาะอื่น ๆ , ไม่ระบุเฉพาะและหลายบริเวณในร่างกาย' as name,'T00' as code1,'T01' as code2 union
                                                                                                                                            select 203 as id,'S00-S01,S04,S09-S11,S14-S16,S19-S21,S24-S25, S29-S31,S34-S35,S39-S41,S44-S46,S49-S51,S54-S56,S59-S61,S64-S66,S69-S71,S74-S76,S79-S81,S84-S86,S89-S91,S94-S96,S99,T00-T01, T06-T07,T09,T11,T13-T14 การบาดเจ็บระบุเฉพาะอื่น ๆ , ไม่ระบุเฉพาะและหลายบริเวณในร่างกาย' as name,'T06' as code1,'T07' as code2 union
                                                                                                                                                select 203 as id,'S00-S01,S04,S09-S11,S14-S16,S19-S21,S24-S25, S29-S31,S34-S35,S39-S41,S44-S46,S49-S51,S54-S56,S59-S61,S64-S66,S69-S71,S74-S76,S79-S81,S84-S86,S89-S91,S94-S96,S99,T00-T01, T06-T07,T09,T11,T13-T14 การบาดเจ็บระบุเฉพาะอื่น ๆ , ไม่ระบุเฉพาะและหลายบริเวณในร่างกาย' as name,'T09' as code1,'T09' as code2 union
                                                                                                                                                        select 203 as id,'S00-S01,S04,S09-S11,S14-S16,S19-S21,S24-S25, S29-S31,S34-S35,S39-S41,S44-S46,S49-S51,S54-S56,S59-S61,S64-S66,S69-S71,S74-S76,S79-S81,S84-S86,S89-S91,S94-S96,S99,T00-T01, T06-T07,T09,T11,T13-T14 การบาดเจ็บระบุเฉพาะอื่น ๆ , ไม่ระบุเฉพาะและหลายบริเวณในร่างกาย' as name,'T11' as code1,'T11' as code2 union
                                                                                                                                                            select 203 as id,'S00-S01,S04,S09-S11,S14-S16,S19-S21,S24-S25, S29-S31,S34-S35,S39-S41,S44-S46,S49-S51,S54-S56,S59-S61,S64-S66,S69-S71,S74-S76,S79-S81,S84-S86,S89-S91,S94-S96,S99,T00-T01, T06-T07,T09,T11,T13-T14 การบาดเจ็บระบุเฉพาะอื่น ๆ , ไม่ระบุเฉพาะและหลายบริเวณในร่างกาย' as name,'T13' as code1,'T14' as code2 union
                                                                                                                
                                                                                                                
                                                                                                
                                                                                                
                                                                            
                                                            
                            select 204 as id,'T15-T19 ผลของวัตถุแปลกปลอมผ่านเข้าทางทวารธรรมชาติของร่างกาย' as name,'T15' as code1,'T19' as code2 union
                            select 205 as id,'T20-T32 แผลถูกความร้อนและถูกสารกัดกร่อน' as name,'T20' as code1,'T32' as code2 union
                            select 206 as id,'T36-T50 การเป็นพิษจากยา เครื่องยาและชีววัตถุ' as name,'T36' as code1,'T50' as code2 union
                            select 207 as id,'T51-T65 การเป็นพิษจากสารที่โดยส่วนใหญ่แล้วไม่ได้ใช้เป็นยา' as name,'T51' as code1,'T65' as code2 union
                            select 208 as id,'T74 กลุ่มอาการจากการทารุณ' as name,'T74' as code1,'T74' as code2 union
                            select 209 as id,'T33-T35, T66-T73, T75-T78 อื่น ๆ และที่มิได้ระบุผลของสาเหตุภายนอก'  as name,'T33' as code1,'T35' as code2 union
                                select 209 as id,'T33-T35, T66-T73, T75-T78 อื่น ๆ และที่มิได้ระบุผลของสาเหตุภายนอก'  as name,'T66' as code1,'T73' as code2 union
                                    select 209 as id,'T33-T35, T66-T73, T75-T78 อื่น ๆ และที่มิได้ระบุผลของสาเหตุภายนอก'  as name,'T75' as code1,'T78' as code2 union
                            select 210 as id,'T79-T88 ภาวะแทรกซ้อนระยะแรกของการบาดเจ็บบางชนิดและภาวะแทรกซ้อนของการรักษาทางศัลยกรรมและอายุรกรรมที่มิได้มีรหัสระบุไว้ที่อื่น' as name,'t79' as code1,'T88' as code2 union
                            select 211 as id,'T90-T98 ผลระยะล่าของการบาดเจ็บ การเป็นพิษและผลที่ตามมาจากสาเหตุภายนอกอื่น ๆ' as name,'T90' as code1,'T98' as code2 union
                            select 212 as id,'A82 โรคพิษสุนัขบ้า' as name,'A82' as code1,'A82' as code2 union
                            select 213 as id,'Z00-Z13 บุคคลขอรับบริการเพื่อการตรวจและชันสูตร' as name,'Z00' as code1,'Z13' as code2 union
                            select 214 as id,'Z21 การติดเชื้อไวรัสโดยไม่มีอาการ' as name,'Z21' as code1,'Z21' as code2 union
                            select 215 as id,'Z20, Z22-Z29 บุคคลที่มีอาการที่น่าจะเป็นอันตรายต่อสุขภาพที่เกี่ยวเนื่องกับโรคติดต่อ'  as name,'Z20' as code1,'Z20' as code2 union
                                select 215 as id,'Z20, Z22-Z29 บุคคลที่มีอาการที่น่าจะเป็นอันตรายต่อสุขภาพที่เกี่ยวเนื่องกับโรคติดต่อ'  as name,'Z22' as code1,'Z29' as code2 union
                            select 216 as id,'Z30 การรับบริการคุมกำเนิด' as name,'Z30' as code1,'Z30' as code2 union
                            select 217 as id,'Z34-Z36 การตรวจคัดกรองก่อนการคลอด และการให้คำแนะนำเกี่ยวกับการตั้งครรภ์อื่น ๆ'  as name,'Z34' as code1,'Z36' as code2 union
                            select 218 as id,'Z38 การเกิดของทารกตามสถานที่เกิด'  as name,'Z38' as code1,'Z38' as code2 union
                            select 219 as id,'Z39 การดูแลและการตรวจหลังคลอด' as name,'Z39' as code1,'Z39' as code2 union
                            select 220 as id,'Z40-Z54 บุคคลขอรับบริการสุขภาพ เพื่อหัตถการหรือการบริการสุขภาพที่ระบุเฉพาะ' as name,'Z40' as code1,'Z54' as code2 union
                            select 221 as id,'Z31-Z33, Z37, Z55-Z99 บุคคลขอรับบริการสุขภาพด้วยเหตุผลอื่น' as name,'Z31' as code1,'Z33' as code2 union
                                select 221 as id,'Z31-Z33, Z37, Z55-Z99 บุคคลขอรับบริการสุขภาพด้วยเหตุผลอื่น' as name,'Z55' as code1,'Z99' as code2 union
                            select 222 as id,'A03 โรคบิดจากเชื้อชิเกลลา' as name,'A03' as code1,'A03' as code2 union
                            select 223 as id,'A83-A86 สมองอักเสบจากไวรัส' as name,'A83' as code1,'A86' as code2 union
                            select 224 as id,'A95 ไข้เหลือง'  as name,'A95' as code1,'A95' as code2 union
                            select 225 as id,'A90-A94, A96-A99 ไข้จากไวรัสที่นำโดยแมลงและไข้เลือดออกที่เกิดจากไวรัสอื่น ๆ' as name,'A90' as code1,'A94' as code2 union
                                select 225 as id,'A90-A94, A96-A99 ไข้จากไวรัสที่นำโดยแมลงและไข้เลือดออกที่เกิดจากไวรัสอื่น ๆ' as name,'A96' as code1,'A99' as code2 union
                            select 226 as id,'B00 เริม (เฮอร์ปีส ซิมเพล็กซ์)' as name,'B00' as code1,'B00' as code2 union
                            select 227 as id,'B01-B02 อีสุกอีใสและงูสวัส' as name,'B01' as code1,'B02' as code2 union
                            select 228 as id,'B05 หัด' as name,'B05' as code1,'B05' as code2 union
                            select 229 as id,'B06 หัดเยอรมัน (รูเบลลา)' as name,'B06' as code1,'B06' as code2 union
                            select 230 as id,'B16 ตับอักเสบเฉียบพลันชนิดบี' as name,'B16' as code1,'B16' as code2 union
                            select 231 as id,'B15, B17-B19 ตับอักเสบจากไวรัสอื่น ๆ' as name,'B15' as code1,'B15' as code2 union
                                select 231 as id,'B15, B17-B19 ตับอักเสบจากไวรัสอื่น ๆ' as name,'B17' as code1,'B17' as code2 union
                            select 232 as id,'B20-B24 ภูมิคุ้มกันบกพร่องเนื่องจากไวรัส (HIV)' as name,'B20' as code1,'B24' as code2 union
                            select 233 as id,'A06 โรคบิดมีตัว' as name,'A06' as code1,'A06' as code2 union
                            select 234 as id,'B26 คางทูม' as name,'B26' as code1,'B26' as code2 union
                            select 235 as id,'A81, A87-A89, B03-B04, B07-B09, B25, B27-B34 โรคจากไวรัสอื่น' as name,'A81' as code1,'A81' as code2 union
                                select 235 as id,'A81, A87-A89, B03-B04, B07-B09, B25, B27-B34 โรคจากไวรัสอื่น' as name,'A87' as code1,'A89' as code2 union
                                    select 235 as id,'A81, A87-A89, B03-B04, B07-B09, B25, B27-B34 โรคจากไวรัสอื่น' as name,'B03' as code1,'B04' as code2 union
                                        select 235 as id,'A81, A87-A89, B03-B04, B07-B09, B25, B27-B34 โรคจากไวรัสอื่น' as name,'B07' as code1,'B09' as code2 union
                                            select 235 as id,'A81, A87-A89, B03-B04, B07-B09, B25, B27-B34 โรคจากไวรัสอื่น' as name,'B25' as code1,'B25' as code2 union
                                                select 235 as id,'A81, A87-A89, B03-B04, B07-B09, B25, B27-B34 โรคจากไวรัสอื่น' as name,'B27' as code1,'B34' as code2 union
                                    
                            select 236 as id,'B35-B49 โรคติดเชื้อรา' as name,'B35' as code1,'B49' as code2 union
                            select 237 as id,'B50-B54 มาลาเรีย' as name,'B50' as code1,'B54' as code2 union
                            select 238 as id,'B55 โรคติดเชื้อลิชมาเนีย' as name,'B55' as code1,'B55' as code2 union
                            select 239 as id,'B56-B57 โรคทริปาโนโซม' as name,'B56' as code1,'B57' as code2 union
                            select 240 as id,'B65 โรคติดเชื้อซิสโตโซม' as name,'B65' as code1,'B65' as code2 union
                            select 241 as id,'B66 โรคพยาธิใบไม้อื่น' as name,'B66' as code1,'B66' as code2 union
                            select 242 as id,'B67 โรคพยาธิเอไคโนค็อกคัส' as name,'B67' as code1,'B67' as code2 union
                            select 243 as id,'B72 โรคพยาธิดราคันคูลัส' as name,'B72' as code1,'B72' as code2 union
                            select 244 as id,'A09 อาการท้องร่วงกระเพาะและลำไส้อักเสบซึ่งสันนิษฐานว่าเกิดจากการติดเชื้อ' as name,'A09' as code1,'A09' as code2 union
                            select 245 as id,'B73 โรคพยาธิออนโคเซอร์คา' as name,'B73' as code1,'B73' as code2 union
                            select 246 as id,'B74 โรคพยาธิฟิลาเรีย'as name,'B74' as code1,'B74' as code2 union
                            select 247 as id,'B76 โรคพยาธิปากขอ'  as name,'B76' as code1,'B76' as code2 union
                            select 248 as id,'B68-B71, B75, B77-B83 โรคพยาธิตัวตืด' as name,'B68' as code1,'B71' as code2 union
                                select 248 as id,'B68-B71, B75, B77-B83 โรคพยาธิตัวตืด' as name,'B75' as code1,'B75' as code2 union
                                    select 248 as id,'B68-B71, B75, B77-B83 โรคพยาธิตัวตืด' as name,'B77' as code1,'B83' as code2 union
                            select 249 as id,'B90 ผลที่ตามมาของวัณโรค' as name,'B90' as code1,'B90' as code2 union
                        
                            /**/
                            select 250 as id,'B91 ผลที่ตามมาของโรคโปลิโอ'as name,'B91' as code1,'B91' as code2 
     union 
select 251 as id,'B92 ผลที่ตามมาของโรคเรื้อน' as name,'B92' as code1,'B92' as code2 
     union 
select 252 as id,'A65-A67, A69-A70, A74, A77-A79, B58-B64, B85-B89, B94, B99 โรคติดเชื้อและปรสิตอื่น ๆ' as name,'A65' as code1,'A67'  as code2 
     union 
select 252 as id,'A65-A67, A69-A70, A74, A77-A79, B58-B64, B85-B89, B94, B99 โรคติดเชื้อและปรสิตอื่น ๆ'as name,'A69' as code1,'A70'  as code2 
     union 
select 252 as id,'A65-A67, A69-A70, A74, A77-A79, B58-B64, B85-B89, B94, B99 โรคติดเชื้อและปรสิตอื่น ๆ'as name,'A74' as code1,'A74'  as code2 
     union      
select 252 as id,'A65-A67, A69-A70, A74, A77-A79, B58-B64, B85-B89, B94, B99 โรคติดเชื้อและปรสิตอื่น ๆ'as name,'A77' as code1,'A79'  as code2 
     union      
select 252 as id,'A65-A67, A69-A70, A74, A77-A79, B58-B64, B85-B89, B94, B99 โรคติดเชื้อและปรสิตอื่น ๆ' as name,'B58' as code1,'B64'  as code2 
     union          
select 252 as id,'A65-A67, A69-A70, A74, A77-A79, B58-B64, B85-B89, B94, B99 โรคติดเชื้อและปรสิตอื่น ๆ' as name,'B85' as code1,'B89'  as code2 
     union      
select 252 as id,'A65-A67, A69-A70, A74, A77-A79, B58-B64, B85-B89, B94, B99 โรคติดเชื้อและปรสิตอื่น ๆ'as name,'B94' as code1,'B94'  as code2 
     union          
select 252 as id,'A65-A67, A69-A70, A74, A77-A79, B58-B64, B85-B89, B94, B99 โรคติดเชื้อและปรสิตอื่น ๆ'as name,'B99' as code1,'B99'  as code2 
     union      
select 253 as id,'C00-C14 เนื้องอกร้ายของริมฝีปาก ช่องปากและคอหอย' as name,'C00' as code1,'C14'  as code2 
     union      
select 254 as id,'C15 เนื้องอกร้ายที่หลอดอาหาร' as name,'C15' as code1,'C15'  as code2 
     union     
select 255 as id,'A02, A04-A05, A07-A08 โรคลำไส้อักเสบอื่น ๆ' as name,'A02' as code1,'A02'  as code2 
     union     
select 255 as id,'A02, A04-A05, A07-A08 โรคลำไส้อักเสบอื่น ๆ'as name,'A04' as code1,'A05'  as code2 
     union     
select 255 as id,'A02, A04-A05, A07-A08 โรคลำไส้อักเสบอื่น ๆ' as name,'A07' as code1,'A08'  as code2 
     union     
select 256 as id,'C16 เนื้องอกร้ายที่กระเพาะอาหาร'as name,'C16' as code1,'C16'  as code2 
     union     
select 257 as id,'C18 เนื้องอกร้ายของลำไส้ใหญ่' as name,'C18' as code1,'C18'  as code2 
     union 
select 258 as id,'C19-C21 เนื้องอกร้ายที่รอยต่อลำไส้ใหญ่เร็คตัมและซิกมอยด์ เร็คตัม ทวารหนักและช่องทวารหนัก' as name,'C19' as code1,'C21'  as code2 
     union 
select 259 as id,'C22 เนื้องอกร้ายที่ตับและท่อน้ำดีในตับ'as name,'C22' as code1,'C22'  as code2 
     union
select 260 as id,'C25 เนื้องอกร้ายที่ตับอ่อน'as name,'C25' as code1,'C25'  as code2 
     union
select 261 as id,'C17, C23-C24, C26 เนื้องอกร้ายที่อวัยวะย่อยอาหารอื่น ๆ' as name,'C17' as code1,'C17'  as code2 
     union 
select 261 as id,'C17, C23-C24, C26 เนื้องอกร้ายที่อวัยวะย่อยอาหารอื่น ๆ' as name,'C23' as code1,'C24'  as code2 
     union
select 261 as id,'C17, C23-C24, C26 เนื้องอกร้ายที่อวัยวะย่อยอาหารอื่น ๆ' as name,'C26' as code1,'C26'  as code2 
     union
select 262 as id,'C32 เนื้องอกร้ายที่กล่องเสียง' as name,'C32' as code1,'C32'  as code2 
     union 
select 263 as id,'C33-C34 เนื้องอกร้ายที่หลอดคอ หลอดลม และปอด'as name,'C33' as code1,'C34'  as code2 
     union 
select 264 as id,'C30-C31, C37-C39 เนื้องอกร้ายที่อวัยวะหายใจและอวัยวะช่องอก'as name,'C30' as code1,'C31'  as code2 
     union 
select 264 as id,'C30-C31, C37-C39 เนื้องอกร้ายที่อวัยวะหายใจและอวัยวะช่องอก'as name,'C37' as code1,'C39'  as code2 
     union     
select 265 as id,'C40-C41 เนื้องอกร้ายที่กระดูกและกระดูกอ่อนผิวข้อ' as name,'C40' as code1,'C41'  as code2 
     union      
select 266 as id,'A15-A16 วัณโรคทางเดินหายใจ' as name,'A15' as code1,'A16'  as code2 
     union      
select 267 as id,'C43 เนื้องอกร้ายที่เมลาโนม่าของผิวหนัง'as name,'C43' as code1,'C43'  as code2 
     union      
select 268 as id,'C44 เนื้องอกร้ายที่ผิวหนังอื่น ๆ'as name,'C44' as code1,'C44'  as code2 
     union      
select 269 as id,'C45-C49 เนื้องอกร้ายที่เมโสชีเรียลและเนื้อเยื่ออ่อน'as name,'C45' as code1,'C49'  as code2 
     union     
select 270 as id,'C50 เนื้องอกร้ายที่เต้านม' as name,'C50' as code1,'C50'  as code2 
     union  
select 271 as id,'C53 เนื้องอกร้ายที่ปากมดลูก' as name,'C53' as code1,'C53'  as code2 
     union     
select 272 as id,'C54-C55 เนื้องอกร้ายอื่น ๆ ที่มิได้ระบุส่วนของมดลูก'as name,'C54' as code1,'C55'  as code2 
     union 
select 273 as id,'C51-C52, C56-C58 เนื้องอกร้ายของอวัยวะสืบพันธุ์หญิง' as name,'C51' as code1,'C52'  as code2 
     union
select 273 as id,'C51-C52, C56-C58 เนื้องอกร้ายของอวัยวะสืบพันธุ์หญิง' as name,'C56' as code1,'C58'  as code2 
     union
select 274 as id,'C61 เนื้องอกร้ายที่ต่อมลูกหมาก' as name,'C61' as code1,'C61'  as code2 
     union 
select 275 as id,'C60, C62-C63 เนื้องอกร้ายของอวัยวะสืบพันธุ์ชาย' as name,'C60' as code1,'C60'  as code2 
     union
select 275 as id,'C60, C62-C63 เนื้องอกร้ายของอวัยวะสืบพันธุ์ชาย'as name,'C62' as code1,'C63'  as code2 
     union
select 276 as id,'C67 เนื้องอกร้ายที่กระเพาะปัสสาวะ'as name,'C67' as code1,'C67'  as code2 
     union
select 277 as id,'A17-A19 วัณโรคอื่น ๆ' as name,'A17' as code1,'A19'  as code2 
     union
select 278 as id,'C64-C66, C68 เนื้องอกร้ายอื่น ๆ ที่ท่อปัสสาวะ' as name,'C64' as code1,'C66'  as code2 
     union 
select 278 as id,'C64-C66, C68 เนื้องอกร้ายอื่น ๆ ที่ท่อปัสสาวะ' as name,'C68' as code1,'C68'  as code2 
     union 
select 279 as id,'C69 เนื้องอกร้ายของตาและส่วนประกอบ'as name,'C69' as code1,'C69'  as code2 
     union 
select 280 as id,'C71 เนื้องอกร้ายของสมอง' as name,'C71' as code1,'C71'  as code2 
     union 
select 281 as id,'C70, C72 เนื้องอกร้ายที่ส่วนอื่น ๆ ของระบบประสาทส่วนกลาง' as name,'C70' as code1,'C72'  as code2 
     union 
select 282 as id,'C73-C80, C97 เนื้องอกอื่น ๆ และที่ไม่ทราบสาเหตุ เนื้องอกทุติยภูมิที่มิได้ระบุรายละเอียดและเกิดขึ้นหลายแห่ง'as name,'C73' as code1,'C80'  as code2 
     union 
select 282 as id,'C73-C80, C97 เนื้องอกอื่น ๆ และที่ไม่ทราบสาเหตุ เนื้องอกทุติยภูมิที่มิได้ระบุรายละเอียดและเกิดขึ้นหลายแห่ง' as name,'C97' as code1,'C97'  as code2 
     union      
select 283 as id,'C81 โรคฮอดกินส์' as name,'C81' as code1,'C81'  as code2 
     union 
select 284 as id,'C82-C85 เนื้องอกร้ายลิมโฟมาที่มิใช่โรคฮอดกินส์'as name,'C82' as code1,'C85'  as code2 
     union
select 285 as id,'C91-C95 ลิวคีเมีย' as name,'C91' as code1,'C95'  as code2 
     union 
select 286 as id,'C88-C90, C96 เนื้องอกร้ายอื่น ๆ ของลิมฟอยด์ ระบบสร้างเม็ดเลือดและเนื้อเยื่อ' as name,'C88' as code1,'C90'  as code2 
     union 
select 286 as id,'C88-C90, C96 เนื้องอกร้ายอื่น ๆ ของลิมฟอยด์ ระบบสร้างเม็ดเลือดและเนื้อเยื่อ' as name,'C96' as code1,'C96'  as code2 
     union 
select 287 as id,'D06 มะเร็งจำกัดเฉพาะที่ของปากมดลูก' as name,'D06' as code1,'D06'  as code2 
     union 
select 288 as id,'A20 กาฬโรค'as name,'A20' as code1,'A20'  as code2 
     union
select 289 as id,'D22-D23 เนื้องอกไม่ร้ายของผิวหนัง'as name,'D22' as code1,'D23'  as code2 
     union
select 290 as id,'D24 เนื้องอกไม่ร้ายของเต้านม' as name,'D24' as code1,'D24'  as code2 
     union
select 291 as id,'D25 โลโอไมโอมาที่มดลูก' as name,'D25' as code1,'D25'  as code2 
     union
select 292 as id,'D27 เนื้องอกไม่ร้ายที่รังไข่'as name,'D27' as code1,'D27'  as code2 
     union
select 293 as id,'D30 เนื้องอกไม่ร้ายที่ระบบปัสสาวะ' as name,'D30' as code1,'D30'  as code2 
     union 
select 294 as id,'D33 เนื้องอกไม่ร้ายของสมองและส่วนอื่นของระบบประสาทส่วนกลาง' as name,'D33' as code1,'D33'  as code2 
     union 
select 295 as id,'D00-D05, D07-D21, D26,D28-D29 D31-D32, D34-D48 เนื้องอกไม่ร้ายจำกัดเฉพาะที่อื่น ๆและเนื้องอกบางชนิดที่ไม่ทราบพฤติกรรม' as name,'D00' as code1,'D05'  as code2 
     union 
select 295 as id,'D00-D05, D07-D21, D26,D28-D29 D31-D32, D34-D48 เนื้องอกไม่ร้ายจำกัดเฉพาะที่อื่น ๆและเนื้องอกบางชนิดที่ไม่ทราบพฤติกรรม'as name,'D07' as code1,'D21'  as code2 
     union 
select 295 as id,'D00-D05, D07-D21, D26,D28-D29 D31-D32, D34-D48 เนื้องอกไม่ร้ายจำกัดเฉพาะที่อื่น ๆและเนื้องอกบางชนิดที่ไม่ทราบพฤติกรรม' as name,'D26' as code1,'D26'  as code2 
     union 
select 295 as id,'D00-D05, D07-D21, D26,D28-D29 D31-D32, D34-D48 เนื้องอกไม่ร้ายจำกัดเฉพาะที่อื่น ๆและเนื้องอกบางชนิดที่ไม่ทราบพฤติกรรม' as name,'D28' as code1,'D29'  as code2 
     union 
select 295 as id,'D00-D05, D07-D21, D26,D28-D29 D31-D32, D34-D48 เนื้องอกไม่ร้ายจำกัดเฉพาะที่อื่น ๆและเนื้องอกบางชนิดที่ไม่ทราบพฤติกรรม'as name,'D31' as code1,'D32'  as code2 
     union 
select 295 as id,'D00-D05, D07-D21, D26,D28-D29 D31-D32, D34-D48 เนื้องอกไม่ร้ายจำกัดเฉพาะที่อื่น ๆและเนื้องอกบางชนิดที่ไม่ทราบพฤติกรรม' as name,'D34' as code1,'D48'  as code2 
     union 
select 296 as id,'D50 โลหิตจางจากการขาดธาตุเหล็ก' as name,'D50' as code1,'D50'  as code2 
     union 
select 297 as id,'D51-D64 โลหิตจางอื่น ๆ' as name,'D51' as code1,'D64'  as code2 
     union 
select 298 as id,'D65-D77 ภาวะเลือดออกอื่น ๆ โรคเลือดและอวัยวะที่สร้างเลือด' as name,'D65' as code1,'D77'  as code2 
                            /**/
                        
                            
                         
                         
         
     )tmpz 
     left join ovstdiag od on od.icd10 between tmpz.code1 and tmpz.code2 
     LEFT OUTER JOIN doctor d ON d.code = od.doctor 
     WHERE od.diagtype = '1'  AND d.spclty = '01' and od.vstdate between '2024-10-01' and '2025-02-28'
     group by id, rpt_name
     ORDER BY cc_hn DESC
