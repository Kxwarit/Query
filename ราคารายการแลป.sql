SELECT n.icode,
  n.name,
  n.income AS income,
  n.price AS price,
  n.ipd_price AS ipd_price,
  n.istatus AS istatus,
  i.name AS income_name,
  n.use_paidst,
  p3.name AS paidst_name,
  n.lockprint,
  nac.nhso_adp_type_name,
  n.no_substock,
  n.unit,
  n.inv_map_update,
  n.billcode,
  n.billnumber,
  n.ucef_code,
  p2.*,
  n2.nondrugitems_type_name,
  n.is_accm,
  n.is_food,
  CAST(Concat(sb.code, ' : ', sb.name) AS VARCHAR(250)) AS simb_name,
  n.sks_rev_date,
  sct.sks_claim_category_type_name,
  n.nhso_adp_code,
  nd2.nhso_adp_code_name,
  nd1.nhso_adp_type_name,
  n.sks_tmlt_code,
  lx.tmlt_name,
  ip.income_phdb_code,
  ip.income_phdb_name
FROM nondrugitems n
  LEFT OUTER JOIN income i ON i.income = n.income
  LEFT OUTER JOIN nhso_adp_type nac ON nac.nhso_adp_type_id = n.nhso_adp_type_id
  LEFT OUTER JOIN paidst p3 ON p3.paidst = n.paidst
  LEFT OUTER JOIN pttype_item_price_summary p2 ON p2.icode = n.icode
  LEFT OUTER JOIN nondrugitems_type n2 ON n2.nondrugitems_type_id = n.nondrugitems_type_id
  LEFT OUTER JOIN simb_2005 sb ON sb.code = n.simb_2005
  LEFT OUTER JOIN sks_claim_category_type sct ON sct.sks_claim_category_type_id = n.sks_claim_category_type_id
  LEFT OUTER JOIN nhso_adp_type nd1 ON nd1.nhso_adp_type_id = n.nhso_adp_type_id
  LEFT OUTER JOIN nhso_adp_code nd2 ON nd2.nhso_adp_code = n.nhso_adp_code
  LEFT OUTER JOIN lab_items_tmlt lx ON lx.tmlt_code = n.sks_tmlt_code
  LEFT OUTER JOIN income_phdb_code ip ON ip.income_phdb_code = n.income_phdb_code
WHERE 1 = 1 AND Upper(n.name) ILIKE '%ABNORMAL%' AND n.istatus = 'Y' AND n.income = '07'
ORDER BY income,
  n.name

-----------
SELECT li.lab_items_name, n.icode,
  n.name,
  n.income AS income,
  n.price AS price,
  n.ipd_price AS ipd_price,
  n.istatus AS istatus,
  i.name AS income_name,
  n.use_paidst,
  p3.name AS paidst_name,
  n.lockprint,
  nac.nhso_adp_type_name,
  n.no_substock,
  n.unit,
  n.inv_map_update,
  n.billcode,
  n.billnumber,
  n.ucef_code,
  p2.*,
  n2.nondrugitems_type_name,
  n.is_accm,
  n.is_food,
  CAST(Concat(sb.code, ' : ', sb.name) AS VARCHAR(250)) AS simb_name,
  n.sks_rev_date,
  sct.sks_claim_category_type_name,
  n.nhso_adp_code,
  nd2.nhso_adp_code_name,
  nd1.nhso_adp_type_name,
  n.sks_tmlt_code,
  lx.tmlt_name,
  ip.income_phdb_code,
  ip.income_phdb_name
FROM nondrugitems n
  LEFT OUTER JOIN income i ON i.income = n.income
  LEFT OUTER JOIN nhso_adp_type nac ON nac.nhso_adp_type_id = n.nhso_adp_type_id
  LEFT OUTER JOIN paidst p3 ON p3.paidst = n.paidst
  LEFT OUTER JOIN pttype_item_price_summary p2 ON p2.icode = n.icode
  LEFT OUTER JOIN nondrugitems_type n2 ON n2.nondrugitems_type_id = n.nondrugitems_type_id
  LEFT OUTER JOIN simb_2005 sb ON sb.code = n.simb_2005
  LEFT OUTER JOIN sks_claim_category_type sct ON sct.sks_claim_category_type_id = n.sks_claim_category_type_id
  LEFT OUTER JOIN nhso_adp_type nd1 ON nd1.nhso_adp_type_id = n.nhso_adp_type_id
  LEFT OUTER JOIN nhso_adp_code nd2 ON nd2.nhso_adp_code = n.nhso_adp_code
  LEFT OUTER JOIN lab_items_tmlt lx ON lx.tmlt_code = n.sks_tmlt_code
  LEFT OUTER JOIN income_phdb_code ip ON ip.income_phdb_code = n.income_phdb_code
  INNER JOIN lab_items li ON li.icode = n.icode
WHERE 1 = 1 AND li.service_price IS NULL 
--AND lab_items_name ILIKE '%Abnormal %' 
--n.name ILIKE '%Anisocytosis%' 
--AND n.istatus = 'Y' AND n.income = '07'
ORDER BY n.icode--lab_items_name
--income,n.name