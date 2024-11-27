set search_path to concept, dcc_pedsnet;

--stomatitis

select * from concept where concept_code = '61170000' and vocabulary_id = 'SNOMED'; --"Stomatitis"

--SM descendants 
select distinct concept_id, concept_code, concept_name, vocabulary_id,
	case when vocabulary_id = 'ICD9CM' then '09'
		when vocabulary_id in ('ICD10', 'ICD10CM') then '10'
		when vocabulary_id = 'SNOMED' then 'SM'
	end pcornet_vocabulary_id
from concept where concept_id in (
select descendant_concept_id
from concept_ancestor
where ancestor_concept_id in (138455) -- Stomatitis
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
		where ancestor_concept_id in (138455)
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
where ((lower(concept_name) like '%stomatitis%')
	and lower(concept_name) not like '%fh:%'
	and lower(concept_name) not like '%family history%')
	
	--and concept_class_id not in ('Context-dependent')
	and domain_id not in ('Drug', 'Procedure', 'Measurement', 'Type Concept', 'Metadata')
	and concept_class_id not in ('Body Structure','Morph Abnormality')
	and vocabulary_id in ('ICD9CM', 'ICD10', 'ICD10CM', 'SNOMED')
union
--adds additional ICD codes
select distinct concept_id, concept_code, concept_name, vocabulary_id,
	case when vocabulary_id = 'ICD9CM' then '09'
		when vocabulary_id in ('ICD10', 'ICD10CM') then '10'
		when vocabulary_id = 'SNOMED' then 'SM'
	end pcornet_vocabulary_id
from concept
where (concept_code like 'K12%' or concept_code like '528%')
and vocabulary_id in ('ICD9CM', 'ICD10', 'ICD10CM')
order by vocabulary_id, concept_code

--SCRATCHWORK
