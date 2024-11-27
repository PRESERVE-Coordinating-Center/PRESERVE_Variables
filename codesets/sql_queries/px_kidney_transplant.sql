set search_path to concept, dcc_pedsnet;

select distinct vocabulary_id from vocabulary.concept
order by vocabulary_id asc;

select concept_id, concept_code, concept_name, vocabulary_id,
	case when vocabulary_id = 'ICD9Proc' then '9'
		when vocabulary_id in ('ICD10PCS') then '10'
		when vocabulary_id in ('CPT4', 'HCPCS') then 'CH'
		when vocabulary_id in ('SNOMED') then 'OT'
	end pcornet_vocabulary_id
	from concept
where (lower(concept_name) like '%kidney%' or lower(concept_name) like '%renal%')
	and (lower(concept_name) like '%transplant%')
	and lower(concept_name) not like '%transplant association%'
	and lower(concept_name) not like '%wait%'
	and lower(concept_name) not like '%ultrason%'
	and lower(concept_name) not like '%ultrasound%'
	and lower(concept_name) not like '%scan%'
	and lower(concept_name) not like '%biopsy%'
	and lower(concept_name) not like '%adrenal%'
	and lower(concept_name) not like '%aberrant%'
	and lower(concept_name) not like '%fluoroscop%'
	and lower(concept_name) not like '%evaluation%'
	and lower(concept_name) not like '%pre-transplant%'
	and lower(concept_name) not like '%planned%'
	and lower(concept_name) not like '%arteriogram%'
	and lower(concept_name) not like '%radionuclide%'
	and lower(concept_name) not like '%angiography%'
	and lower(concept_name) not like '%venogram%'
	and lower(concept_name) not like '%angiography%'
	and lower(concept_name) not like '%discussion%'
	and lower(concept_name) not like '%anesthesia%'
	and lower(concept_name) not like '%donor of%'
	and lower(concept_name) not like '%donor for%'
	and lower(concept_name) not like '%examination of live donor after kidney transplant%'
	and lower(concept_name) not like '%post-transplantation of kidney examination, live donor%'
	and lower(concept_name) not like '%autotransp%'
	and lower(concept_name) not like '%imaging%'
	and lower(concept_name) not like '%radiography%'
	and lower(concept_name) not like '%thrombosis%'
	and lower(concept_name) not like '%complication of%'
	and lower(concept_name) not like '%rejection%'
	and lower(concept_name) not like '%aneurysm%'
	and lower(concept_name) not like '%graft-versus-host%'
	and lower(concept_name) not like '%history of%'
	and lower(concept_name) not like '%stenosis%'
	and lower(concept_name) not like '%regime%'
	and lower(concept_name) not like '%rupture%'
	and lower(concept_name) not like '%structure%'
	and lower(concept_name) not like '%disorder%'
	and lower(concept_name) not like '%failed%'
	and lower(concept_name) not like '%dysfunction%'
	and lower(concept_name) not like '%tissue%'
	and lower(concept_name) not like '%sampling%'
	and vocabulary_id in ('ICD9Proc', 'ICD10PCS', 'CPT4', 'HCPCS', 'SNOMED')
	and concept_class_id not in ('Clinical Finding', 'Body Structure')
	and concept_id not in (1314395, 1389533, 44786436, 1314423, 1314421, 40664909, 2109588, 2003622, 4126132, 4126137, 45765975, 3570635, 3525427, 4172369, 4032294, 45768672)		  
order by vocabulary_id, concept_name

select * from concept where concept_id = 3545903; 

--and vocabulary_id in ('SNOMED', 'LOINC', 'CPT4', 'HCPCS

--SNOMED Proc code: 70536003

select procedure_concept_id, procedure_concept_name, vocabulary_id, count(person_id)
from procedure_occurrence p
	inner join concept c on c.concept_id = p.procedure_concept_id
where procedure_concept_id in (
45887599, 2109583, 2109584, 2109582, 2109581, 45887600, 2109586, 2109587, 45888790, 2721092, 2833286, 2890060, 2827873, 2877118, 2799812, 2877119, 2774520, 2774521, 2774522, 2774517, 2774518, 2774519, 2003626, 2003624, 46272953, 3525419, 44791130, 3525420, 44790290, 3578423, 3569403, 46273963, 35623146, 35623147, 4021107, 37018761, 606401, 199991, 4324887, 4197300, 4125970, 37115323, 4094173, 4324754, 3546756, 4019782, 4127554, 4178312, 3554589, 44790243, 3554239, 3554593, 36714220, 44792553, 37204160, 4022805, 765054, 43021422, 3578431, 3568494, 3536596, 4022475, 4126132, 4126137, 45765975, 3570635, 3525427, 4172369, 4032294, 45768672, 4180416, 4176579, 40315157, 40440911, 44811577, 4347789, 4236275, 36717743, 3567661, 4316597, 3536597, 4022806, 42539502, 40409737, 4322471, 35610634, 4172368, 3545878, 44794448, 40525341, 4343000, 3545903
)
group by procedure_concept_id, procedure_concept_name, vocabulary_id
order by count(person_id) desc