set search_path to concept, dcc_pedsnet;

select distinct vocabulary_id from vocabulary.concept
order by vocabulary_id asc;

select concept_id, concept_code, concept_name, vocabulary_id,
	case when vocabulary_id = 'ICD9Proc' then '09'
		when vocabulary_id in ('ICD10PCS') then '10'
		when vocabulary_id in ('CPT4', 'HCPCS') then 'CH'
		when vocabulary_id in ('SNOMED') then 'OT'
	end pcornet_vocabulary_id
	from concept
where (lower(concept_name) like '%kidney%' or lower(concept_name) like '%renal%')
	and (lower(concept_name) like '%biopsy%')
	and lower(concept_name) not like '%adrenal%'
	and lower(concept_name) not like '%renal pelvi%'
	and lower(concept_name) not like '%without biopsy%'
	and lower(concept_name) not like '%perirenal%'
	and lower(concept_name) not like '%microarray gene expression%'
	and lower(concept_name) not like '%not done%'
	and vocabulary_id in ('ICD9Proc', 'ICD10PCS', 'CPT4', 'HCPCS', 'SNOMED')
union
--icd10pcs specific
select concept_id, concept_code, concept_name, vocabulary_id,
	case when vocabulary_id = 'ICD9Proc' then '09'
		when vocabulary_id in ('ICD10PCS') then '10'
		when vocabulary_id in ('CPT4', 'HCPCS') then 'CH'
		when vocabulary_id in ('SNOMED') then 'OT'
	end pcornet_vocabulary_id
from concept
where (concept_name ilike '%excision%' or concept_name ilike '%extraction%' or concept_name ilike '%drainage%')
	and concept_name ilike '%kidney%'
	and concept_name ilike '%diagnostic%'
	and vocabulary_id in ('ICD9Proc', 'ICD10PCS', 'CPT4', 'HCPCS', 'SNOMED')
order by vocabulary_id, concept_code;