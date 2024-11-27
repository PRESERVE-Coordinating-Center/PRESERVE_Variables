set search_path to concept, dcc_pedsnet;

select concept_id, concept_code, concept_name, vocabulary_id,
	case when vocabulary_id = 'ICD9Proc' then '09'
		when vocabulary_id in ('ICD10PCS') then '10'
		when vocabulary_id in ('CPT4', 'HCPCS') then 'CH'
		when vocabulary_id in ('SNOMED') then 'OT'
	end pcornet_vocabulary_id
from concept
where (lower(concept_name) like '%dialysis%'
	   or lower(concept_name) like '%urinary filtration%'
	   or lower(concept_name) like '%irrigation of peritoneal cavity using dialysate%')
	and lower(concept_name) not like '%iridodialysis%'
	and lower(concept_name) not like '%cyclodialysis%'
	and lower(concept_name) not like '%retina%'
	and lower(concept_name) not like '%transplant association%'
	and lower(concept_name) not like '%fluoroscop%'
	and lower(concept_name) not like '%ultrason%'
	and lower(concept_name) not like '%radionuclide%'
	and lower(concept_name) not like '%angiography%'
	and lower(concept_name) not like '%venogram%'
	and lower(concept_name) not like '%angiography%'
	and lower(concept_name) not like '%arteriogram%'
	and lower(concept_name) not like '%anesthesia%'
	and lower(concept_name) not like '%trabeculodialysis%'
	and lower(concept_name) not like '%radiography%'	
	and vocabulary_id in ('ICD9Proc', 'ICD10PCS', 'CPT4', 'HCPCS', 'SNOMED')
	and concept_class_id not in ('Pharma/Biol Product', 'Physical Object', 'Context-dependent')
	and domain_id not in ('Measurement')
--	and domain_id not in ('Drug', 'Condition', 'Measurement')
order by vocabulary_id, concept_name

--SCRATCHWORK
select * from concept where concept_code in
(
'84439', '84403', '84402', '39.95', '84520', '84520', '500300010', '38.95', '84439', '54.98', '4000100013', '84439', '36557', '49324', '49421', '49422', '115860.999', '36555', '36581', '84436', '84439', '36555', '39.27', '500300111', 'LAB3001618.', '36557', 'LAB0000163.', '49422', '36557', '36558', '47535', '36598', '84481', '39.42', '36870', '47535', 'B51W1ZZ', '36556', '39.43', 'B51WZZZ', '84439', '36145', '99255', '99255', '12.55', 'C1881'
) and vocabulary_id in ('ICD9Proc', 'ICD10PCS', 'CPT4', 'HCPCS', 'SNOMED')

--SNOMED Proc code: 70536003

select * from 