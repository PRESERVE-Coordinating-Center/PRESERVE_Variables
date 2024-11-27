-- Renal Artery Stenosis Codeset

select distinct concept_id, concept_code, concept_name, vocabulary_id,
case when vocabulary_id in ('ICD9CM', 'ICD9') then '09'
when vocabulary_id in ('ICD10CM', 'ICD10') then '10'
when vocabulary_id in ('ICD11CM', 'ICD11') then '11'
when vocabulary_id in ('SNOMED') then 'SM'
end pcornet_vocabulary_id

from vocabulary.concept
	where ((vocabulary_id in ('ICD9CM') and concept_code = '747.62') -- Renal vessel anomaly
	or (vocabulary_id in ('ICD10CM') and concept_code = 'Q27.1')) -- Congenital renal artery stenosis
	and vocabulary_id in ('ICD9CM', 'ICD9', 'ICD10CM', 'ICD10', 'ICD11CM', 'ICD11', 'SNOMED')
	and domain_id in ('Condition', 'Observation')
	
order by vocabulary_id, concept_code;