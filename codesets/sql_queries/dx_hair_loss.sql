set search_path to vocabulary, dcc_pedsnet;

--hair loss - as condition
select * from concept where concept_code = '56317004' and vocabulary_id = 'SNOMED'; --alopecia
select * from concept where concept_code = '278040002' and vocabulary_id = 'SNOMED'; --loss of hair

--SM descendants 
select distinct concept_id, concept_code, concept_name, vocabulary_id,
	case when vocabulary_id = 'ICD9CM' then '09'
		when vocabulary_id in ('ICD10', 'ICD10CM') then '10'
		when vocabulary_id = 'SNOMED' then 'SM'
	end pcornet_vocabulary_id
from concept where concept_id in (
select descendant_concept_id
from concept_ancestor
where ancestor_concept_id in (133280, 4175525) --alopecia, loss of hair
and vocabulary_id in ('ICD9CM', 'ICD10', 'ICD10CM', 'SNOMED')
and lower(concept_name) not like '%congenital%'
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
		where ancestor_concept_id in (133280, 4175525)
))
and vocabulary_id in ('ICD9CM', 'ICD10', 'ICD10CM', 'SNOMED')
and lower(concept_name) not like '%congenital%'
union
--string matching (in SM, catches non-standard codes in case other sites are using)
select distinct concept_id, concept_code, concept_name, vocabulary_id,
	case when vocabulary_id = 'ICD9CM' then '09'
		when vocabulary_id in ('ICD10', 'ICD10CM') then '10'
		when vocabulary_id = 'SNOMED' then 'SM'
	end pcornet_vocabulary_id
from concept
where (lower(concept_name) like '%hair%' and lower(concept_name) like '%loss%'
	or lower(concept_name) like '%alopecia%'
	  )--inclusion
	and (lower(concept_name) not like '%testing%'
	and lower(concept_name) not like '%measurement%'
	and lower(concept_name) not like '%fh:%'
	and lower(concept_name) not like '%history%'
	and lower(concept_name) not like '%congenital%'
	and lower(concept_name) not like '%score%'
	and lower(concept_name) not like '%tool%'
	and lower(concept_name) not like '%solution%'	 
	)--exclusion
	and domain_id not in ('Drug', 'Procedure', 'Measurement', 'Type Concept', 'Metadata')
	and vocabulary_id in ('ICD9CM', 'ICD10', 'ICD10CM', 'SNOMED')
order by vocabulary_id, concept_code
