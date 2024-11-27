set search_path to vocabulary, dcc_pedsnet;

--headache

select * from concept where concept_code = '230461009' and vocabulary_id = 'SNOMED'; --headache

--SM descendants 
select distinct concept_id, concept_code, concept_name, vocabulary_id,
	case when vocabulary_id = 'ICD9CM' then '09'
		when vocabulary_id in ('ICD10', 'ICD10CM') then '10'
		when vocabulary_id = 'SNOMED' then 'SM'
	end pcornet_vocabulary_id
from concept where concept_id in (
select descendant_concept_id
from concept_ancestor
where ancestor_concept_id in (230461009) --headache
and vocabulary_id in ('ICD9CM', 'ICD10', 'ICD10CM', 'SNOMED')
)
union
--mapping of SM codes to ICD
select distinct concept_id, concept_code, concept_name, vocabulary_id,
	case when vocabulary_id = 'ICD9CM' then '09'
		when vocabulary_id in ('ICD10', 'ICD10CM') then '10'
		when vocabulary_id = 'SNOMED' then 'SM'
	end pcornet_vocabulary_id
from concept where concept_id in (
	select concept_id_1 from concept_relationship
	where relationship_id = 'Maps to'
		and concept_id_2 in (
		select descendant_concept_id
		from concept_ancestor
		where ancestor_concept_id in (230461009)
))
and vocabulary_id in ('ICD9CM', 'ICD10', 'ICD10CM', 'SNOMED')
union
--string matching (in SM, catches non-standard codes in case other sites are using)
select distinct concept_id, concept_code, concept_name, vocabulary_id,
	case when vocabulary_id = 'ICD9CM' then '09'
		when vocabulary_id in ('ICD10', 'ICD10CM') then '10'
		when vocabulary_id = 'SNOMED' then 'SM'
	end pcornet_vocabulary_id
from concept
where (lower(concept_name) like '%headache%' or lower(concept_name) like '%migraine%'
	)--inclusion
	and (lower(concept_name) not like '%testing%'
	and lower(concept_name) not like '%measurement%'
	and lower(concept_name) not like '%fh:%'
	and lower(concept_name) not like '%history%'
	and lower(concept_name) not like '%anaesthesia%'
	and lower(concept_name) not like '%anesthesia%'
	and lower(concept_name) not like '%prophylaxis%'
	and lower(concept_name) not like '%tablet%'
	and lower(concept_name) not like '%mg%'
	and lower(concept_name) not like '%sheet%'
	and lower(concept_name) not like '%ibuprofen%'
	and lower(concept_name) not like '%codeine%'
	and lower(concept_name) not like '%no headache%'
	and lower(concept_name) not like '%abdominal%'
	and lower(concept_name) not like '%puncture%'
	and lower(concept_name) not like '%referral%'
	and lower(concept_name) not like '%did not attend%'
	and lower(concept_name) not like '%seen by%'
	and lower(concept_name) not like '%discharged from%'
	and lower(concept_name) not like '%characteristic of%'
	and lower(concept_name) not like '%solpadeine%'
	and lower(concept_name) not like '%device%'
	and lower(concept_name) not like '%solpadeine%'
	and lower(concept_name) not like '%nurofen%'
	and lower(concept_name) not like '%antimigraine%'
	and lower(concept_name) not like '%clinic%'	 
	and lower(concept_name) not like '%stimulator%'
	and lower(concept_name) not like '%femigraine%'

	)--exclusion
	and domain_id not in ('Drug', 'Procedure', 'Measurement', 'Type Concept', 'Metadata')
	and vocabulary_id in ('ICD9CM', 'ICD10', 'ICD10CM', 'SNOMED')
order by vocabulary_id, concept_code

--SCRATCHWORK
