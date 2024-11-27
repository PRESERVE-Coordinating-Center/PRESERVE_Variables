-- Cancer Codeset

select distinct concept_id, concept_code, concept_name, vocabulary_id,
case when vocabulary_id in ('ICD9CM', 'ICD9') then '09'
when vocabulary_id in ('ICD10CM', 'ICD10') then '10'
when vocabulary_id in ('ICD11CM', 'ICD11') then '11'
when vocabulary_id in ('SNOMED') then 'SM'
end pcornet_vocabulary_id

from vocabulary.concept where (concept_id in (
	select descendant_concept_id 
	from vocabulary.concept_ancestor
	where ancestor_concept_id = 4312326 -- "Neoplasm, malignant (primary)"
	or ancestor_concept_id = 4032806) -- "Neoplasm, metastatic"
	or (vocabulary_id in ('ICD9CM', 'ICD9') and
		cast(substring(concept_code FROM '[0-9.]+') as numeric) >= 140 and -- ICD9 range 140-239
		cast(substring(concept_code FROM '[0-9.]+') as numeric) < 240)
	or vocabulary_id in ('ICD10CM', 'ICD10') 
	and (left(concept_code, 1) = 'C')
    or left(concept_code, 1) = 'D' 
	and cast(substring(concept_code FROM '[0-9.]+') as numeric) < 50) -- ICD10 range C00-D49
	
	and vocabulary_id in ('ICD9CM', 'ICD9', 'ICD10CM', 'ICD10', 'ICD11CM', 'ICD11', 'SNOMED')
	and domain_id in ('Condition', 'Observation')
	and not ((concept_name ilike '%benign%' 
			  and not (concept_name ilike '%brain%' 
					   and concept_name ilike '%neoplasm%' 
					   and concept_name ilike '%benign%'))
			 or concept_name ilike '%hemangioma%'
			 or (concept_name ilike '%essential%' 
				 and concept_name ilike '%thrombocythemia%')
			 or (concept_name ilike '%melanocytic%' 
				 and (concept_name ilike '%nevi%' 
					  or concept_name ilike '%nevus%'
					  or concept_name ilike '%naevi%' 
					  or concept_name ilike '%naevus%'))
			 or concept_name ilike '%lipoma%'
			 or concept_name ilike '%neurofibromatosis%'
			 or concept_name ilike '%schwannomatosis%')
	and not concept_name ilike '%family history%'
	and not concept_name ilike '%history of%'
	and not concept_name ilike '%fh:%'

order by concept_code;