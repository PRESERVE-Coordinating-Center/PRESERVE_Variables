select concept_id, concept_code, concept_name, vocabulary_id,
	case when vocabulary_id = 'ICD9Proc' then '09'
		when vocabulary_id in ('ICD10PCS') then '10'
		when vocabulary_id in ('CPT4', 'HCPCS') then 'CH'
		when vocabulary_id in ('SNOMED') then 'OT'
	end pcornet_vocabulary_id
from vocabulary.concept
where concept_code in ('93784', '93786', '93788', '93790')
and vocabulary_id = 'CPT4'
order by vocabulary_id, concept_name;