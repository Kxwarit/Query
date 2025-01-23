SELECT 
    aa.hn, 
    aa.dchdate, 
    oa.nextdate,
    CASE 
        WHEN ov.vstdate IS NOT NULL THEN 'Yes'
        ELSE 'No'
    END AS visited,
    ov.ovstist,
    os.cc
FROM an_stat aa
INNER JOIN oapp oa ON oa.an = aa.an OR oa.vn = aa.vn
LEFT JOIN ovst ov ON ov.hn = aa.hn AND ov.vstdate = oa.nextdate                           
LEFT JOIN opdscreen os ON os.vn = ov.vn
WHERE aa.dchdate BETWEEN '2023-10-01' AND '2024-09-30'  AND oa.nextdate <= CURRENT_DATE
ORDER BY aa.dchdate DESC
