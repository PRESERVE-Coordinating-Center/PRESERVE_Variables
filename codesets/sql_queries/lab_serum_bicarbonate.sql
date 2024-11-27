set search_path to concept, dcc_pedsnet;

--serum bicarbonate
select concept_id, concept_code, concept_name, vocabulary_id,
	case when vocabulary_id = 'LOINC' then 'LC'
	end pcornet_vocabulary_id
from concept
where lower(concept_name) like '%bicarbonate%' 
	and (lower(concept_name) like '%serum%'
		 or lower(concept_name) like '%plasma%'
		 or lower(concept_name) like '%blood%')
	and lower(concept_name) not like '%alanine%'
	and lower(concept_name) not like '%gamma%'
	
	and vocabulary_id in ('LOINC')
order by concept_code
;


--scratch work
select measurement_concept_name, measurement_concept_id, measurement_source_value, count(measurement_id)
from measurement_labs
where lower(measurement_concept_name) like '%bicarb%'
group by measurement_concept_name, measurement_concept_id, measurement_source_value
order by count(measurement_id)
