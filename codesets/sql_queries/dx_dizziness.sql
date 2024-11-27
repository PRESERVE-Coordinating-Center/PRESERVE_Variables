-- Dizziness

select distinct concept_id, concept_code, concept_name, vocabulary_id,
case when vocabulary_id in ('ICD9CM', 'ICD9') then '09'
when vocabulary_id in ('ICD10CM', 'ICD10') then '10'
when vocabulary_id in ('ICD11CM', 'ICD11') then '11'
when vocabulary_id in ('SNOMED') then 'SM'
end pcornet_vocabulary_id

from vocabulary.concept
	where ((vocabulary_id in ('ICD9CM') and concept_code = '780.4') -- Dizziness and giddiness
	or (vocabulary_id in ('ICD10CM') and concept_code = 'R42')) -- Dizziness and giddiness
	and vocabulary_id in ('ICD9CM', 'ICD9', 'ICD10CM', 'ICD10', 'ICD11CM', 'ICD11', 'SNOMED')
	and domain_id in ('Condition', 'Observation')
	
order by vocabulary_id, concept_code;