set search_path to vocabulary, dcc_pedsnet;

--PKD disease
--Diagnosis codeset

select v.*, c.concept_name from dcc_pedsnet.condition_occurrence_source_value v
	inner join vocabulary.concept c on c.concept_id = v.condition_concept_id
where condition_source_value ilike '%753.12%'
order by count desc;

select v.*, c.concept_name from dcc_pedsnet.condition_occurrence_source_value v
	inner join vocabulary.concept c on c.concept_id = v.condition_concept_id
where condition_source_value ilike '%q61.1%'
order by count desc;



--SNOMED descendants
select * from concept where concept_code = '28770003' and vocabulary_id = 'SNOMED' --id: 201675, "Polycystic kidney disease, infantile type"
select * from concept where concept_code = '765330003' and vocabulary_id = 'SNOMED' --id: 35623051, "Autosomal dominant polycystic kidney disease"

select distinct concept_id, concept_code, concept_name, vocabulary_id,
	case when vocabulary_id = 'ICD9CM' then '09'
		when vocabulary_id in ('ICD10', 'ICD10CM') then '10'
		when vocabulary_id = 'SNOMED' then 'SM'
	end pcornet_vocabulary_id
from concept where concept_id in (
select descendant_concept_id
from concept_ancestor
where ancestor_concept_id in (201675, 35623051)
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
		where ancestor_concept_id in (201675, 35623051)
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
where (concept_code in ('Q61.1', 'Q61.19', 'Q61.2')
        or concept_code in ('753.13', '753.14')
)
and vocabulary_id in ('ICD9CM', 'ICD10', 'ICD10CM')
order by vocabulary_id, concept_code