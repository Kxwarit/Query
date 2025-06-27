SELECT *
FROM (
    SELECT i.hn,
        left(dx.icd10, 3) as dx4,
        ic.name,
        ic.tname,
        'IPD' AS Place
    FROM
        ipt i
        LEFT JOIN iptdiag dx on i.an = dx.an AND dx.diagtype = '1'
        LEFT JOIN icd101 ic on left(dx.icd10, 3) = ic.code
        LEFT JOIN patient pt on i.hn = pt.hn
    WHERE i.dchtype in ('08', '09')
    AND i.dchdate BETWEEN '2025-03-01' AND '2025-03-31'

    union

    SELECT
        d.hn,
        left(coalesce( d.death_diag_4,coalesce(d.death_diag_3, coalesce(d.death_diag_2, d.death_diag_1) ) ),3 ) AS dx4,
        ic.name,
        ic.tname,
        dp.death_place_name AS Place
    FROM death AS d
    LEFT JOIN icd101 ic ON left(coalesce(d.death_diag_4,coalesce(d.death_diag_3,coalesce(d.death_diag_2, d.death_diag_1))),3) = ic.code
    LEFT JOIN patient pt ON d.hn = pt.hn
    LEFT JOIN death_place dp ON dp.death_place_id::TEXT = d.death_place
    WHERE death_date BETWEEN '2025-03-01' AND '2025-03-31'
) tmp
ORDER BY hn
-------------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT *
FROM (
    SELECT 
        i.dchdate as death_date,
        i.hn,
        left(dx.icd10, 3) as dx4,
        ic.name,
        ic.tname,
        'IPD' AS Place
    FROM
        ipt i
        LEFT JOIN iptdiag dx on i.an = dx.an AND dx.diagtype = '1'
        LEFT JOIN icd101 ic on left(dx.icd10, 3) = ic.code
        LEFT JOIN patient pt on i.hn = pt.hn
    WHERE i.dchtype in ('08', '09')
    AND i.dchdate BETWEEN '2025-03-01' AND '2025-03-31'

    UNION

    SELECT
        d.death_date,
        d.hn,
        left(coalesce( d.death_diag_4,coalesce(d.death_diag_3, coalesce(d.death_diag_2, d.death_diag_1) ) ),3 ) AS dx4,
        ic.name,
        ic.tname,
        dp.death_place_name AS Place
    FROM death AS d
    LEFT JOIN icd101 ic ON left(coalesce(d.death_diag_4,coalesce(d.death_diag_3,coalesce(d.death_diag_2, d.death_diag_1))),3) = ic.code
    LEFT JOIN patient pt ON d.hn = pt.hn
    LEFT JOIN death_place dp ON dp.death_place_id::TEXT = d.death_place
    WHERE death_date BETWEEN '2025-03-01' AND '2025-03-31'
) tmp
ORDER BY death_date, hn

-------------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT *
FROM (
    SELECT 
        i.dchdate as death_date,
        i.hn,
        left(dx.icd10, 3) as dx4,
        ic.name,
        ic.tname,
        'IPD' AS Place
    FROM
        ipt i
        LEFT JOIN iptdiag dx on i.an = dx.an AND dx.diagtype = '1'
        LEFT JOIN icd101 ic on left(dx.icd10, 3) = ic.code
        LEFT JOIN patient pt on i.hn = pt.hn
    WHERE i.dchtype in ('08', '09')
    AND i.dchdate BETWEEN '2025-03-01' AND '2025-03-31'

    UNION

    SELECT
        d.death_date,
        d.hn,
        left(coalesce(d.death_diag_1,coalesce(d.death_diag_2, coalesce(d.death_diag_3, d.death_diag_4) ) ),3 ) AS dx4,
        ic.name,
        ic.tname,
        dp.death_place_name AS Place
    FROM death AS d
    LEFT JOIN icd101 ic ON  left(coalesce(d.death_diag_1,coalesce(d.death_diag_2, coalesce(d.death_diag_3, d.death_diag_4) ) ),3 ) = ic.code
    LEFT JOIN patient pt ON d.hn = pt.hn
    LEFT JOIN death_place dp ON dp.death_place_id::TEXT = d.death_place
    WHERE death_date BETWEEN '2025-03-01' AND '2025-03-31'
) tmp
ORDER BY death_date, hn
------------------------
WITH ranked_icd AS (
    SELECT 
        d.code AS doctor_code,
        d.name AS doctor_name,
        ic.code AS icd10_code,
        COUNT(i.an) AS visit,
        ROW_NUMBER() OVER (PARTITION BY d.code ORDER BY COUNT(i.an) DESC) AS rn
    FROM ipt i
    LEFT OUTER JOIN iptdiag id ON id.an = i.an
    LEFT OUTER JOIN doctor d ON d.code = id.doctor
    LEFT OUTER JOIN icd101 ic ON ic.code = id.icd10
    WHERE i.dchdate BETWEEN '2025-04-01' AND '2025-04-30'
      AND id.diagtype = '1'
    GROUP BY d.code, d.name, ic.code
)

SELECT doctor_code, doctor_name, icd10_code, visit
FROM ranked_icd
WHERE rn <= 10
ORDER BY doctor_code, visit DESC;
