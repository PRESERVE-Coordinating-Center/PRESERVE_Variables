set search_path to concept, dcc_pedsnet;

--urine protein quant
select concept_id, concept_code, concept_name, vocabulary_id,
	case when vocabulary_id = 'LOINC' then 'LC'
	end pcornet_vocabulary_id
from concept
where lower(concept_name) like '%protein%'
	and lower(concept_name) like '%urine%'
	and vocabulary_id in ('LOINC')
	and lower(concept_name) not like '%protein/%'
	and lower(concept_name) not like '%/protein%'
	and lower(concept_name) not like '%strip%'
	and lower(concept_name) not like '%presence%'
    and lower(concept_name) not like '%mouse%'
    and lower(concept_name) not like '%rat%'
    and lower(concept_name) not like '%swine%'
    and lower(concept_name) not like '%rabbit%'
    and lower(concept_name) not like '%nuclear%'
    and lower(concept_name) not like '%insulin%'
    and lower(concept_name) not like '%glyco%'
	and lower(concept_name) not like '%glucose%'
	and lower(concept_name) not like '%adenosine%'
	and lower(concept_name) not like '%binding%'
	and lower(concept_name) not like '%monoclonal%'
	and lower(concept_name) not like '%band%'
	and lower(concept_name) not like '%nitrogen%'
	and lower(concept_name) not like '%pattern%'
	and lower(concept_name) not like '%electrophoresis%'
order by concept_name
;


--SCRATCHWORK
select * from measurement_concept_name
where lower(measurement_concept_name) like '%protein%'
	and lower(measurement_concept_name) like '%urine%'

--		 or lower(measurement_concept_name) like '%plasma%'
--		 or lower(measurement_concept_name) like '%blood%'))
order by count desc;

select * from measurement_concept_name
where measurement_concept_id in (
select concept_id

from concept
where lower(concept_name) like '%protein%'
	and lower(concept_name) like '%urine%'
	and vocabulary_id in ('LOINC')
	and lower(concept_name) not like '%protein/%'
	and lower(concept_name) not like '%/protein%'
	and lower(concept_name) not like '%strip%'
	and lower(concept_name) not like '%presence%'
    and lower(concept_name) not like '%mouse%'
    and lower(concept_name) not like '%rat%'
    and lower(concept_name) not like '%swine%'
    and lower(concept_name) not like '%rabbit%'
    and lower(concept_name) not like '%nuclear%'
    and lower(concept_name) not like '%insulin%'
    and lower(concept_name) not like '%glyco%'
	and lower(concept_name) not like '%glucose%'
	and lower(concept_name) not like '%adenosine%'
	and lower(concept_name) not like '%binding%'
	and lower(concept_name) not like '%monoclonal%'
	and lower(concept_name) not like '%band%'
	and lower(concept_name) not like '%nitrogen%'
	and lower(concept_name) not like '%pattern%'
	and lower(concept_name) not like '%electrophoresis%'

)
;