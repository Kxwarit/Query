SELECT nc.nutri_consult_id, nc.nutri_consult_confirm_date, ncs.nutri_consult_screen_note , ncr.nutri_consult_report_note1 
FROM nutri_consult nc 
LEFT JOIN nutri_consult_screen ncs ON ncs.nutri_consult_id = nc.nutri_consult_id 
LEFT JOIN nutri_consult_report ncr ON ncr.nutri_consult_id = nc.nutri_consult_id 
WHERE nc.hn = "6410301" AND nc.nutri_consult_confirm = "Y" AND (ncs.nutri_consult_screen_note <> E"\\x" OR ncr.nutri_consult_report_note1 <> E"\\x")
GROUP BY nc.nutri_consult_id, nc.nutri_consult_confirm_date, ncs.nutri_consult_screen_note, ncr.nutri_consult_report_note1
ORDER BY nc.nutri_consult_id DESC 
LIMIT 1