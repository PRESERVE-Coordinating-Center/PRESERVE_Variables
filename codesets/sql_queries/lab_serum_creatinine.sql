set search_path to concept, dcc_pedsnet;

--serum creatinine
select concept_id, concept_code, concept_name, vocabulary_id,
	case when vocabulary_id = 'LOINC' then 'LC'
	end pcornet_vocabulary_id
from concept
where lower(concept_name) like '%creatinine%'
	and (lower(concept_name) like '%serum%'
		 or lower(concept_name) like '%plasma%'
		 or lower(concept_name) like '%blood%')
	and vocabulary_id in ('LOINC')
and lower(concept_name) not like '%/creatinine%'
and lower(concept_name) not like '%creatinine/%'
and lower(concept_name) not like '%urine%'
and lower(concept_name) not like '%peritoneal%'
and lower(concept_name) not like '%glomerular%'
and lower(concept_name) not like '%ratio%'
and lower(concept_name) not like '%predicted%'
and lower(concept_name) not like '%clearance%'
and lower(concept_name) not like '%transferrin%'
and lower(concept_name) not like '%dialysis fluid%'
order by concept_code
;


--SCRATCHWORK
select * from concept where concept_id in (
select descendant_concept_id
from concept_ancestor
where ancestor_concept_id in (4074815, 34000006, 81893)
)
and vocabulary_id = 'SNOMED';

select * from measurement_concept_name
where lower(measurement_concept_name) like '%creatinine%'
--	and (lower(measurement_concept_name) like '%serum%'
--		 or lower(measurement_concept_name) like '%plasma%'
--		 or lower(measurement_concept_name) like '%blood%'))

select * from measurement_concept_name where measurement_concept_id in (

	select concept_id from concept
where lower(concept_name) like '%creatinine%'
	and (lower(concept_name) like '%serum%'
		 or lower(concept_name) like '%plasma%'
		 or lower(concept_name) like '%blood%')
	and vocabulary_id in ('LOINC')
and lower(concept_name) not like '%/creatinine%'
and lower(concept_name) not like '%creatinine/%'
and lower(concept_name) not like '%urine%'
and lower(concept_name) not like '%peritoneal%'
and lower(concept_name) not like '%glomerular%'
and lower(concept_name) not like '%ratio%'
and lower(concept_name) not like '%predicted%'
and lower(concept_name) not like '%clearance%'
)