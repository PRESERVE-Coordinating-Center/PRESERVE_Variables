set search_path to concept, dcc_pedsnet;

--nocturnal enuresis

select * from concept where concept_code = '8009008' and vocabulary_id = 'SNOMED'; --"nocturnal enuresis"

--SM descendants 
select distinct concept_id, concept_code, concept_name, vocabulary_id,
	case when vocabulary_id = 'ICD9CM' then '09'
		when vocabulary_id in ('ICD10', 'ICD10CM') then '10'
		when vocabulary_id = 'SNOMED' then 'SM'
	end pcornet_vocabulary_id
from concept where concept_id in (
select descendant_concept_id
from concept_ancestor
where ancestor_concept_id in (193874) -- nocturnal enuresis
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
		where ancestor_concept_id in (193874)
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
where ((lower(concept_name) like '%nocturnal%' and lower(concept_name) like '%enuresis%')
	and lower(concept_name) not like '%fh:%'
	and lower(concept_name) not like '%family history%'
	and domain_id not in ('Drug', 'Procedure', 'Measurement', 'Type Concept', 'Metadata')
	and concept_class_id not in ('Body Structure','Morph Abnormality')
	
	or concept_code in ('F98.0', --"Nonorganic enuresis", "Enuresis not due to a substance or known physiological condition" --not used only for nocturnal
					   '307.6')) --"Enuresis", too general, but used for sceondary nocturnal enuresis
	and vocabulary_id in ('ICD9CM', 'ICD10', 'ICD10CM', 'SNOMED')
order by vocabulary_id, concept_code

--SCRATCHWORK
select v.*, c.concept_name
from condition_occurrence_source_value v
	inner join concept c on c.concept_id = v.condition_concept_id
--where (condition_source_value like '%788.36%' or condition_source_value like '%307.6%')
--where condition_concept_id in (4009183, 193874)
where lower(concept_name) like '%nocturnal enuresis%'
order by count desc 

--other codes to consider
307.6 --"Enuresis", too general?
F98.0 --"Nonorganic enuresis", "Enuresis not due to a substance or known physiological condition" --not used only for nocturnal

