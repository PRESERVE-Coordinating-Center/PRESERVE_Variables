set search_path to concept, dcc_pedsnet;

--serum cystatin
select concept_id, concept_code, concept_name, vocabulary_id,
	case when vocabulary_id = 'LOINC' then 'LC'
	end pcornet_vocabulary_id
from concept
where lower(concept_name) like '%cystatin%'
	and (lower(concept_name) like '%serum%'
		 or lower(concept_name) like '%plasma%'
		 or lower(concept_name) like '%blood%')
	and vocabulary_id in ('LOINC')
and lower(concept_name) not like 'glomerular filtration%'

order by concept_code
;


--SCRATCHWORK
select * from measurement_concept_name
where lower(measurement_concept_name) like '%cystatin%'
order by count desc;
limit 10;
"Cystatin C [Mass/volume] in Serum or Plasma"	3030366	36564
"Glomerular filtration rate/1.73 sq M.predicted [Volume Rate/Area] in Serum, Plasma or Blood by Cystatin-based formula"	3029859	3374
