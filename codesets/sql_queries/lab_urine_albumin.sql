set search_path to vocabulary, dcc_pedsnet;

-- urine albumin only
select concept_id, concept_code, concept_name, vocabulary_id,
	case when vocabulary_id = 'LOINC' then 'LC'
	end pcornet_vocabulary_id
from vocabulary.concept
where lower(concept_name) like '%albumin%'
	and lower(concept_name) like '%urine%'
	and vocabulary_id in ('LOINC')
-- specimen exclusions
and lower(concept_name) not like '%blood%'
and lower(concept_name) not like '%plasma%'
and lower(concept_name) not like '%peritoneal%'
and lower(concept_name) not like '%prealbumin%'
-- component exclusions
and lower(concept_name) not like '%creatinine%'
and lower(concept_name) not like '%protein%'
and lower(concept_name) not like '%globulin%'
-- other exclusions
and lower(concept_name) not like '%ratio%'
and lower(concept_name) not like '%fetus%'
order by concept_name asc;

--SNOMED to consider
--"Albumin measurement"		4097664
--"Urine albumin measurement"	4152996

-- urine albumin to creatinine ratio
select concept_id, concept_code, concept_name, vocabulary_id,
	case when vocabulary_id = 'LOINC' then 'LC'
	end pcornet_vocabulary_id
from vocabulary.concept
where lower(concept_name) like '%albumin%'
	and lower(concept_name) like '%urine%'
	and lower(concept_name) like '%creatinine%'
	and vocabulary_id in ('LOINC')
-- specimen exclusions
and lower(concept_name) not like '%blood%'
and lower(concept_name) not like '%plasma%'
and lower(concept_name) not like '%peritoneal%'
and lower(concept_name) not like '%prealbumin%'
-- component exclusions
and lower(concept_name) not like '%protein%'
-- other exclusions
and lower(concept_name) not like '%fetus%';

--SNOMED to consider
--"Albumin/creatinine ratio measurement"	4108431
--"Urine microalbumin/creatinine ratio measurement"	4150342
