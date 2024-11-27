set search_path to concept, dcc_pedsnet;

--urine protein qual
select concept_id, concept_code, concept_name, vocabulary_id,
	case when vocabulary_id = 'LOINC' then 'LC'
	end pcornet_vocabulary_id
from concept
where lower(concept_name) like '%protein%'
	and lower(concept_name) like '%urine%'
	and vocabulary_id in ('LOINC')
	and (lower(concept_name) like '%strip%' or lower(concept_name) like '%presence%')
    and lower(concept_name) not like '%mouse%'
    and lower(concept_name) not like '%rat%'
    and lower(concept_name) not like '%swine%'
    and lower(concept_name) not like '%rabbit%'
    and lower(concept_name) not like '%nuclear%'
    and lower(concept_name) not like '%insulin%'
    and lower(concept_name) not like '%glyco%'
	and lower(concept_name) not like '%glucose%'
order by concept_name
;


--SCRATCHWORK
select * from measurement_concept_name
where lower(measurement_concept_name) like '%protein%'
	and lower(measurement_concept_name) like '%urine%'

--		 or lower(measurement_concept_name) like '%plasma%'
--		 or lower(measurement_concept_name) like '%blood%'))
order by count desc;


