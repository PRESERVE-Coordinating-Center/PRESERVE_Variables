set search_path to vocabulary, dcc_pedsnet;

--edema (including angioedema codes)

select * from concept where concept_code = '267038008' and vocabulary_id = 'SNOMED'; --"edema" clinical finding
select * from concept where concept_code = '118654009' and vocabulary_id = 'SNOMED'; --"Disorder characterized by edema" disorder


--string matching (in SM, catches non-standard codes in case other sites are using)
select distinct concept_id, concept_code, concept_name, vocabulary_id,
	case when vocabulary_id = 'ICD9CM' then '09'
		when vocabulary_id in ('ICD10', 'ICD10CM') then '10'
		when vocabulary_id = 'SNOMED' then 'SM'
	end pcornet_vocabulary_id
from concept
where ((lower(concept_name) like '%edema%')
--	and lower(concept_name) not like '%angioedema%'
--	and lower(concept_name) not like '%angioneurotic%'
	and lower(concept_name) not like '%no edema%'
	and lower(concept_name) not like '%no oedema%'
    and lower(concept_name) not like '%myxedema%'
    and lower(concept_name) not like '%myxoedema%'
	and lower(concept_name) not like '%fh:%'
	and lower(concept_name) not like '%family history%'
	and lower(concept_name) not like '%macular%'
	and lower(concept_name) not like '%trauma%'
	and lower(concept_name) not like '%maternal%'	   
	and lower(concept_name) not like '%pregnancy%'
	and lower(concept_name) not like '%gestational%'
	and lower(concept_name) not like '%puerperi%'
	and lower(concept_name) not like '%mastectomy%'
	and lower(concept_name) not like '%concussion%'
	and lower(concept_name) not like '%papilledema%'
	and lower(concept_name) not like '%papilloedema%'
	and lower(concept_name) not like '%retinal%'
	and lower(concept_name) not like '%cornea%'
	and lower(concept_name) not like '%optic disc%'
	and lower(concept_name) not like '%tadpole%'
	and lower(concept_name) not like '%clostridium%'
	and lower(concept_name) not like '%fetus%'
	and lower(concept_name) not like '%newborn%'
	and lower(concept_name) not like '%cancer%'
	and lower(concept_name) not like '%gmt%'
	and lower(concept_name) not like '%garmnt%'	  
	and lower(concept_name) not like '%garment%'
	and lower(concept_name) not like '%nurse%'
	and lower(concept_name) not like '%care%'
	and lower(concept_name) not like '%clinic%'
	and lower(concept_name) not like '%quality of life%'

	and lower(concept_name) not like '%t4%'
	and lower(concept_name) not like '%tumor%'

	and domain_id not in ('Drug', 'Procedure', 'Measurement', 'Type Concept', 'Metadata', 'Device')
	--and concept_class_id not in ('Body Structure','Morph Abnormality')
	and vocabulary_id in ('ICD9CM', 'ICD10', 'ICD10CM', 'SNOMED')
)
order by vocabulary_id, concept_code

select * from concept

--SCRATCHWORK -- too many unrelated edema conditions using SNOMED ancestry
--SM descendants 
select distinct concept_id, concept_code, concept_name, vocabulary_id,
	case when vocabulary_id = 'ICD9CM' then '09'
		when vocabulary_id in ('ICD10', 'ICD10CM') then '10'
		when vocabulary_id = 'SNOMED' then 'SM'
	end pcornet_vocabulary_id
from concept where concept_id in (
select descendant_concept_id
from concept_ancestor
where ancestor_concept_id in (433595, 4040388) -- edema
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
		where ancestor_concept_id in (433595, 4040388)
))
and vocabulary_id in ('ICD9CM', 'ICD10', 'ICD10CM', 'SNOMED')

angioedema
select * from concept
where concept_id in (45551447, 19263, 45575524, 45599719, 45594876, 44831784, 604827, 40316758, 4049244, 4120778, 4125819, 4081073, 4086741, 4086742, 4084171, 4083996, 4083997, 4083998, 40440733, 4084172, 4084173, 4084174, 4086744, 40351989, 4080130, 4161207, 4223489, 4222260, 4270861, 4270862, 4299298, 4270863, 4224624, 4221673, 4270865, 4224625, 4299302, 4292365, 4292366, 4292524, 4296370, 4301157, 4297361, 432791, 4140613, 765559, 45766599, 45766602, 45766603, 37110554, 42537887, 3543544, 3543545, 4307793, 3655089, 3661528, 3655098, 3655099, 3661559)
