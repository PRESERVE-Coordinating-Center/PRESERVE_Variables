set search_path to vocabulary, dcc_pedsnet;

--CAKUT disease
--Diagnosis codeset

--SNOMED descendants
select * from concept where concept_code = '253859003' and vocabulary_id = 'SNOMED' --id: 4108905, Congenital malformation of the urinary system

select distinct concept_id, concept_code, concept_name, vocabulary_id,
	case when vocabulary_id = 'ICD9CM' then '09'
		when vocabulary_id in ('ICD10', 'ICD10CM') then '10'
		when vocabulary_id = 'SNOMED' then 'SM'
	end pcornet_vocabulary_id
from concept where concept_id in (
select descendant_concept_id
from concept_ancestor
where ancestor_concept_id in (4108905)
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
		where ancestor_concept_id in (4108905)
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
where (concept_code like 'Q60%' --Congenital malformations of the urinary system Q60-Q64
       or concept_code like 'Q61%'
       or concept_code like 'Q62%'
       or concept_code like 'Q63%'
       or concept_code like 'Q64%'
       or concept_code like '753%' --Congenital anomalies of urinary system 753
)
and vocabulary_id in ('ICD9CM', 'ICD10', 'ICD10CM')
order by vocabulary_id, concept_code

--scratch work