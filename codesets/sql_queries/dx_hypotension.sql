set search_path to concept, dcc_pedsnet;

--hypotension

select * from concept where concept_code = '45007003' and vocabulary_id = 'SNOMED';

--SM descendants 
select distinct concept_id, concept_code, concept_name, vocabulary_id,
	case when vocabulary_id = 'ICD9CM' then '09'
		when vocabulary_id in ('ICD10', 'ICD10CM') then '10'
		when vocabulary_id = 'SNOMED' then 'SM'
	end pcornet_vocabulary_id
from concept where concept_id in (
select descendant_concept_id
from concept_ancestor
where ancestor_concept_id in (317002) -- hypotension SNOMED code
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
		where ancestor_concept_id in (317002)
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
where (lower(concept_name) like '%hypotension%' or lower(concept_name) like '%hypotensive%')
	and lower(concept_name) not like '%pulmonary%'
	and lower(concept_name) not like '%antihypertens%'
	and lower(concept_name) not like '%assessment%'
	and lower(concept_name) not like '%monitoring%'
	and lower(concept_name) not like '%without hypotension%'
	and lower(concept_name) not like '%cranial%'
	and lower(concept_name) not like '%ocular%'
	and lower(concept_name) not like '%portal%'
	and lower(concept_name) not like '%chronic venous%'
	and lower(concept_name) not like '%without diagnosis of hypotension%'
	and lower(concept_name) not like '%without mention of hypotension%'
	and lower(concept_name) not like '%screening%'
	
	--and concept_class_id not in ('Context-dependent')
	and domain_id not in ('Drug', 'Procedure', 'Measurement', 'Type Concept', 'Metadata')
	and vocabulary_id in ('ICD9CM', 'ICD10', 'ICD10CM', 'SNOMED')
order by vocabulary_id, concept_code



--SCRATCHWORK
