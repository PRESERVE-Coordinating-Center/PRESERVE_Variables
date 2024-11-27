set search_path to vocabulary, dcc_pedsnet;

--urine protein creatinine
select concept_id, concept_code, concept_name, vocabulary_id,
	case when vocabulary_id = 'LOINC' then 'LC'
	end pcornet_vocabulary_id
from concept
where (lower(concept_name) like '%protein/creatinine%' or lower(concept_name) like '%creatinine/protein%')
		 and lower(concept_name) like '%urine%'
	and lower(concept_name) not like '%alpha%'
	and vocabulary_id in ('LOINC')
and lower(concept_name) not like 'glomerular filtration%'
order by concept_id
;


--SCRATCHWORK
