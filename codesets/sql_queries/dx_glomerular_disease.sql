set search_path to concept, dcc_pedsnet;

--Glomerular disease
--Diagnosis codeset

--SNOMED descendants
select * from concept where concept_code = '197679002' and vocabulary_id = 'SNOMED' --id: 4059452

select distinct concept_id, concept_code, concept_name, vocabulary_id,
	case when vocabulary_id = 'ICD9CM' then '09'
		when vocabulary_id in ('ICD10', 'ICD10CM') then '10'
		when vocabulary_id = 'SNOMED' then 'SM'
	end pcornet_vocabulary_id
from concept where concept_id in (
select descendant_concept_id
from concept_ancestor
where ancestor_concept_id in (4059452)
)
and vocabulary_id in ('ICD9CM', 'ICD10', 'ICD10CM', 'SNOMED')
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
		where ancestor_concept_id in (4059452)
))
and vocabulary_id in ('ICD9CM', 'ICD10', 'ICD10CM', 'SNOMED')
union
--based on ICD
select distinct concept_id, concept_code, concept_name, vocabulary_id,
	case when vocabulary_id = 'ICD9CM' then '09'
		when vocabulary_id in ('ICD10', 'ICD10CM') then '10'
		when vocabulary_id = 'SNOMED' then 'SM'
	end pcornet_vocabulary_id
from concept
where (concept_code like 'N00%'
       or concept_code like 'N01%'
       or concept_code like 'N02%'
       or concept_code like 'N03%'
       or concept_code like 'N04%'
       or concept_code like 'N05%'
       or concept_code like 'N06%'
       or concept_code like 'N07%'
       or concept_code like 'N08%'
       or concept_code like '580%'
       or concept_code like '581%'
       or concept_code like '582%'
       or concept_code like '583%')
and concept_id not in (40475150) --N00-N08 Glomerular diseases
and vocabulary_id in ('ICD9CM', 'ICD10', 'ICD10CM')
order by vocabulary_id, concept_code

--SCRATCHWORK

--string matching
select distinct concept_id, concept_code, concept_name, vocabulary_id,
	case when vocabulary_id = 'ICD9CM' then '09'
		when vocabulary_id in ('ICD10', 'ICD10CM') then '10'
		when vocabulary_id = 'SNOMED' then 'SM'
	end pcornet_vocabulary_id
from concept
where (lower(concept_name) like '%hypertension%' or lower(concept_name) like '%hypertensive%')

	and vocabulary_id in ('ICD9CM', 'ICD10', 'ICD10CM') --did not include SNOMED, relying on descendants instead
	and concept_class_id not in ('ICD10 SubChapter')
	--and concept_class_id not in ('Pharma/Biol Product', 'Physical Object', 'Context-dependent')
	--and domain_id not in ('Measurement')
order by vocabulary_id, concept_code