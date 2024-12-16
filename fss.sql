STRING_AGG( DISTINCT CASE 
 WHEN p.hometel <> '' AND p.hometel ~ '^[0-9-]+$' AND p.hometel !~ '^(.)\1*$' THEN p.hometel 
 WHEN p.mobile_phone_number <> '' AND p.mobile_phone_number ~ '^[0-9-]+$' AND p.mobile_phone_number !~ '^(.)\1*$' THEN p.mobile_phone_number 
 WHEN p.informtel <> '' AND p.informtel ~ '^[0-9-]+$' AND p.informtel !~ '^(.)\1*$' THEN p.informtel 
ELSE NULL END, ', ') AS contact
------------
AND ( o.pttype IN ('D1', 'D2', 'K1', 'F1', 'F2') OR o.pttype LIKE 'T%' OR o.pttype LIKE 'U%'  OR o.pttype LIKE 'V%' 
OR o.pttype LIKE 'W%' OR o.pttype LIKE 'X%' OR o.pttype LIKE 'Y%' OR o.pttype BETWEEN 'Z5' AND 'Z9' )