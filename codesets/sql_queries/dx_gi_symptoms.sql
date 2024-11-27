set search_path to vocabulary, dcc_pedsnet;

--Gastrointestinal symptoms (vomiting, diarrhea, or abdominal pain) 

select * from concept where concept_code = '300359004' and vocabulary_id = 'SNOMED'; --"vomiting" clinical finding
select * from concept where concept_code = '62315008' and vocabulary_id = 'SNOMED'; --"diarrhea" clinical finding
select * from concept where concept_code = '21522001' and vocabulary_id = 'SNOMED'; --"abdominal pain" clinical finding

--SM descendants 
select distinct concept_id, concept_code, concept_name, vocabulary_id,
	case when vocabulary_id = 'ICD9CM' then '09'
		when vocabulary_id in ('ICD10', 'ICD10CM') then '10'
		when vocabulary_id = 'SNOMED' then 'SM'
	end pcornet_vocabulary_id
from concept where concept_id in (
select descendant_concept_id
from concept_ancestor
where ancestor_concept_id in (4101344, 196523, 200219)
and vocabulary_id in ('ICD9CM', 'ICD10', 'ICD10CM', 'SNOMED')
)
and lower(concept_name) not like '%no history of%'	   
	and lower(concept_name) not like '%no h/o%'
	and lower(concept_name) not like '%no abdominal pain%'

	and lower(concept_name) not like 'at risk%'
	and lower(concept_name) not like 'frequency of%'
	and lower(concept_name) not like 'time since last episode%'	   
	and lower(concept_name) not like '%no vomit%'
	and lower(concept_name) not like '%antidiarr%'
   
	and lower(concept_name) not like '%fh:%'
	and lower(concept_name) not like '%family history%'
	and lower(concept_name) not like '%pregnancy%'
	and lower(concept_name) not like '%gestational%'
	and lower(concept_name) not like '%gravidarum%'
	
 	and lower(concept_name) not like '%neonatal%'
 	and lower(concept_name) not like '%newborn%'

 	and lower(concept_name) not like '%bovine%'
 	and lower(concept_name) not like '%calf%'
 	and lower(concept_name) not like '%cannabis%'
  	and lower(concept_name) not like '%radiation%'
 
 	and lower(concept_name) not like '%management%'
	and lower(concept_name) not like '%vomit sent%'
    and lower(concept_name) not like '%referral%'
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
		where ancestor_concept_id in  (4101344, 196523, 200219)
))
and vocabulary_id in ('ICD9CM', 'ICD10', 'ICD10CM', 'SNOMED')
and lower(concept_name) not like '%no history of%'	   
	and lower(concept_name) not like '%no h/o%'
	and lower(concept_name) not like '%no abdominal pain%'

	and lower(concept_name) not like 'at risk%'
	and lower(concept_name) not like 'frequency of%'
	and lower(concept_name) not like 'time since last episode%'	   
	and lower(concept_name) not like '%no vomit%'
	and lower(concept_name) not like '%antidiarr%'
   
	and lower(concept_name) not like '%fh:%'
	and lower(concept_name) not like '%family history%'
	and lower(concept_name) not like '%pregnancy%'
	and lower(concept_name) not like '%gestational%'
	and lower(concept_name) not like '%gravidarum%'
	
 	and lower(concept_name) not like '%neonatal%'
 	and lower(concept_name) not like '%newborn%'

 	and lower(concept_name) not like '%bovine%'
 	and lower(concept_name) not like '%calf%'
 	and lower(concept_name) not like '%cannabis%'
   	and lower(concept_name) not like '%radiation%'
	
 	and lower(concept_name) not like '%management%'
	and lower(concept_name) not like '%vomit sent%'
    and lower(concept_name) not like '%referral%'
union
--string matching (in SM, catches non-standard codes in case other sites are using)
select distinct concept_id, concept_code, concept_name, vocabulary_id,
	case when vocabulary_id = 'ICD9CM' then '09'
		when vocabulary_id in ('ICD10', 'ICD10CM') then '10'
		when vocabulary_id = 'SNOMED' then 'SM'
	end pcornet_vocabulary_id
from concept
where ((lower(concept_name) like '%vomit%'
	   or lower(concept_name) like '%diarrhea%'
	   or lower(concept_name) like '%abdominal pain%')  
	and lower(concept_name) not like '%no history of%'	   
	and lower(concept_name) not like '%no h/o%'
	and lower(concept_name) not like '%no abdominal pain%'

	and lower(concept_name) not like 'at risk%'
	and lower(concept_name) not like 'frequency of%'
	and lower(concept_name) not like 'time since last episode%'	   
	and lower(concept_name) not like '%no vomit%'
	and lower(concept_name) not like '%antidiarr%'
   
	and lower(concept_name) not like '%fh:%'
	and lower(concept_name) not like '%family history%'
	and lower(concept_name) not like '%pregnancy%'
	and lower(concept_name) not like '%gestational%'
	and lower(concept_name) not like '%gravidarum%'
	
 	and lower(concept_name) not like '%neonatal%'
 	and lower(concept_name) not like '%newborn%'

 	and lower(concept_name) not like '%bovine%'
 	and lower(concept_name) not like '%calf%'
 	and lower(concept_name) not like '%cannabis%'
  	and lower(concept_name) not like '%radiation%'
  
 	and lower(concept_name) not like '%management%'
	and lower(concept_name) not like '%vomit sent%'
    and lower(concept_name) not like '%referral%'	  
	and domain_id not in ('Drug', 'Procedure', 'Measurement', 'Type Concept', 'Metadata', 'Device')
	--and concept_class_id not in ('Body Structure','Morph Abnormality')
	and vocabulary_id in ('ICD9CM', 'ICD10', 'ICD10CM', 'SNOMED')
)
order by vocabulary_id, concept_code

--SCRATCHWORK
