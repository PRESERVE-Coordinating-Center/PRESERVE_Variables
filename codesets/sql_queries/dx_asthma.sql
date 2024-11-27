set search_path to concept, dcc_pedsnet;

--asthma

select * from concept where concept_code = '195967001' and vocabulary_id = 'SNOMED';

--SM descendants 
select distinct concept_id, concept_code, concept_name, vocabulary_id,
	case when vocabulary_id = 'ICD9CM' then '09'
		when vocabulary_id in ('ICD10', 'ICD10CM') then '10'
		when vocabulary_id = 'SNOMED' then 'SM'
	end pcornet_vocabulary_id
from concept where concept_id in (
select descendant_concept_id
from concept_ancestor
where ancestor_concept_id in (317009) -- asthma SNOMED code
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
		where ancestor_concept_id in (317009)
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
where (lower(concept_name) like '%asthma%')
	and lower(concept_name) not like '%adverse%'
	and lower(concept_name) not like '%antiasthmatic%'
	and lower(concept_name) not like '%family history%'
	and lower(concept_name) not like '%poisoning%'
	and lower(concept_name) not like '%assessment%'
	and lower(concept_name) not like '%monitor%'
	and lower(concept_name) not like '%clinic%'
	and lower(concept_name) not like '%school%'
	and lower(concept_name) not like '%review%'
	and lower(concept_name) not like '%action plan%'
	and lower(concept_name) not like '%visit%'
	and lower(concept_name) not like '%symptom%'
	and lower(concept_name) not like '%test%'
	and lower(concept_name) not like '%confirmed%'
	and lower(concept_name) not like '%questionnaire%'
	and lower(concept_name) not like '%follow-up%'
	and lower(concept_name) not like '%management%'	
	and lower(concept_name) not like '%quality%'	
	and lower(concept_name) not like '%study%'
	and lower(concept_name) not like '%number%'	
	and lower(concept_name) not like '%no asthma trigger%'	
	and lower(concept_name) not like '%left ventricular%'	
	and lower(concept_name) not like '%fh%'
	and lower(concept_name) not like '%complian%'
	and lower(concept_name) not like '%disturb%'	
	and lower(concept_name) not like '%leaflet%'	
	and lower(concept_name) not like '%society%'	
	and lower(concept_name) not like '%trigger%'	
	and lower(concept_name) not like '%drug prevention%'
	and lower(concept_name) not like '%consult%'
	and lower(concept_name) not like '%at risk%'
	and lower(concept_name) not like '%limit%'
	and lower(concept_name) not like '%admission%'
	and lower(concept_name) not like '%nurse%'
	and concept_class_id not in ('Context-dependent')
	and domain_id not in ('Drug', 'Procedure', 'Measurement', 'Type Concept', 'Metadata')
	and vocabulary_id in ('ICD9CM', 'ICD10', 'ICD10CM', 'SNOMED')
order by vocabulary_id, concept_name



--SCRATCHWORK
----SNOMED
SNOMED CKD 709044004
select * from concept
where concept_code = '709044004'
and vocabulary_id = 'SNOMED';

select * from concept where concept_id in (
select descendant_concept_id
from concept_ancestor
where ancestor_concept_id in (46271022)
)

--descendants of stage 2-3...
select * from concept where concept_id in (
select descendant_concept_id
from concept_ancestor
where ancestor_concept_id in (443601, 443597)
)

----ICD codes, 9 and 10
--stage 2
ICD9 585.2
ICD10 N18.2
--stage 3
ICD9 585.3
ICD10 N18.3, .30, .31, .32

select * from concept where concept_code like 'N18%' and vocabulary_id like '%ICD%'

select * from concept where concept_code = 'N18.31'

select * from concept
where concept_code in ('585.2', 'N18.3', 'N18.30', 'N18.31', 'N18.32') 
and vocabulary_id in ('ICD9CM', 'ICD10', 'ICD10CM');
44830173