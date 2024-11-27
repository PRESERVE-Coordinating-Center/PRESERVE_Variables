set search_path to vocabulary, dcc_pedsnet;

--fatigue

select * from concept where concept_code = '84229001' and vocabulary_id = 'SNOMED'; --"fatigue" clinical finding

--SM descendants 
select distinct concept_id, concept_code, concept_name, vocabulary_id,
	case when vocabulary_id = 'ICD9CM' then '09'
		when vocabulary_id in ('ICD10', 'ICD10CM') then '10'
		when vocabulary_id = 'SNOMED' then 'SM'
	end pcornet_vocabulary_id
from concept where concept_id in (
select descendant_concept_id
from concept_ancestor
where ancestor_concept_id in (4223659) -- fatigue
and vocabulary_id in ('ICD9CM', 'ICD10', 'ICD10CM', 'SNOMED')
)
	and lower(concept_name) not like '%pregnancy%'
	and lower(concept_name) not like '%gestational%'
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
		where ancestor_concept_id in (4223659)
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
where ((lower(concept_name) like '%fatigue%')
	and lower(concept_name) not like '%fracture%'	   
	and lower(concept_name) not like '%no fatigue%'	   
	and lower(concept_name) not like '%no history of fatigue%'	   
	and lower(concept_name) not like '%no h/o fatigue%'	   
	and lower(concept_name) not like '%fh:%'
	and lower(concept_name) not like '%family history%'
	and lower(concept_name) not like '%pregnancy%'
	and lower(concept_name) not like '%gestational%'
	and lower(concept_name) not like '%management%'
	and lower(concept_name) not like '%score%'	   
	and lower(concept_name) not like '%level of fatigue%'	   
	and lower(concept_name) not like '%referral%'	  
	and domain_id not in ('Drug', 'Procedure', 'Measurement', 'Type Concept', 'Metadata', 'Device')
	--and concept_class_id not in ('Body Structure','Morph Abnormality')
	and vocabulary_id in ('ICD9CM', 'ICD10', 'ICD10CM', 'SNOMED')
)
order by vocabulary_id, concept_code

--SCRATCHWORK
