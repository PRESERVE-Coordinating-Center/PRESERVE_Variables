set search_path to concept, dcc_pedsnet;

--alanine transaminase
select concept_id, concept_code, concept_name, vocabulary_id,
	case when vocabulary_id = 'LOINC' then 'LC'
	end pcornet_vocabulary_id
from concept
where lower(concept_name) like '%alanine%' and lower(concept_name) like '%trans%'
	and (lower(concept_name) like '%serum%'
		 or lower(concept_name) like '%plasma%'
		 or lower(concept_name) like '%blood%')
	and vocabulary_id in ('LOINC')
	and lower(concept_name) not like '%aspart%'
order by concept_code
;