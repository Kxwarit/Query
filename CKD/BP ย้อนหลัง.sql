SELECT os.vstdate, os.bpd, os.bps
FROM opdscreen os
WHERE os.hn = (SELECT hn FROM opdscreen WHERE vn = '680520000417' )
AND os.vstdate BETWEEN (SELECT vstdate - INTERVAL '12 months' FROM opdscreen WHERE vn = '680520000417' )
AND ( SELECT vstdate FROM opdscreen WHERE vn = '680520000417' )
ORDER BY os.vstdate
LIMIT 1
