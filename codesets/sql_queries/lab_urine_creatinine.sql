set search_path to concept, dcc_pedsnet;

--urine creatinine
select concept_id, concept_code, concept_name, vocabulary_id,
	case when vocabulary_id = 'LOINC' then 'LC'
	end pcornet_vocabulary_id
from concept
where lower(concept_name) like '%creatinine%'
	and lower(concept_name) like '%urine%'
	and vocabulary_id in ('LOINC')
and lower(concept_name) not like '%/creatinine%'
and lower(concept_name) not like '%creatinine/%'
and lower(concept_name) not like '%blood%'
and lower(concept_name) not like '%plasma%'
and lower(concept_name) not like '%peritoneal%'
and lower(concept_name) not like '%glomerular%'
and lower(concept_name) not like '%ratio%'
and lower(concept_name) not like '%predicted%'
and lower(concept_name) not like '%clearance%'
and lower(concept_name) not like '%transferrin%'
and lower(concept_name) not like '%dialysis fluid%'
and lower(concept_name) not like '%vanill%'
and lower(concept_name) not like '%catechol%'
and lower(concept_name) not like '%metaneph%'
and lower(concept_name) not like '%porph%'
and lower(concept_name) not like '%hydroxy%'
and lower(concept_name) not like '%morp%'
and lower(concept_name) not like '%methadone%'
and lower(concept_name) not like '%methyl%'
and lower(concept_name) not like '%fentanyl%'
and lower(concept_name) not like '%codone%'
and lower(concept_name) not like '%guanid%'
and lower(concept_name) not like '%sulfocyst%'
and lower(concept_name) not like '%opc3373%'
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
	and lower(measurement_concept_name) like '%urine%'
	and lower(measurement_concept_name) not like '%/creatinine%'
and lower(measurement_concept_name) not like '%creatinine/%'
--		 or lower(measurement_concept_name) like '%plasma%'
--		 or lower(measurement_concept_name) like '%blood%'))
order by count desc;

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


select * from measurement_concept_name
where measurement_concept_id in (
select concept_id
from concept
where lower(concept_name) like '%creatinine%'
	and lower(concept_name) like '%urine%'
	and vocabulary_id in ('LOINC')
and lower(concept_name) not like '%/creatinine%'
and lower(concept_name) not like '%creatinine/%'
and lower(concept_name) not like '%blood%'
and lower(concept_name) not like '%plasma%'
and lower(concept_name) not like '%peritoneal%'
and lower(concept_name) not like '%glomerular%'
and lower(concept_name) not like '%ratio%'
and lower(concept_name) not like '%predicted%'
and lower(concept_name) not like '%clearance%'
and lower(concept_name) not like '%transferrin%'
and lower(concept_name) not like '%dialysis fluid%'
and lower(concept_name) not like '%vanill%'
and lower(concept_name) not like '%catechol%'
and lower(concept_name) not like '%metaneph%'
and lower(concept_name) not like '%porphobilin%'
)
order by count desc;
;