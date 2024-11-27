set search_path to concept, dcc_pedsnet;

--Dialysis
--Diagnosis codeset, including 'history of'

--string matching
select concept_id, concept_code, concept_name, vocabulary_id,
	case when vocabulary_id = 'ICD9CM' then '09'
		when vocabulary_id in ('ICD10', 'ICD10CM') then '10'
		when vocabulary_id = 'SNOMED' then 'SM'
	end pcornet_vocabulary_id
from concept
where (lower(concept_name) like '%dialysis%')
	and lower(concept_name) not like '%iridodialysis%'
	and lower(concept_name) not like '%cyclodialysis%'
	and lower(concept_name) not like '%retina%'
	and lower(concept_name) not like '%transplant association%'
	and lower(concept_name) not like '%fluoroscop%'
	and lower(concept_name) not like '%ultrason%'
	and lower(concept_name) not like '%radionuclide%'
	and lower(concept_name) not like '%angiography%'
	and lower(concept_name) not like '%venogram%'
	and lower(concept_name) not like '%angiography%'
	and lower(concept_name) not like '%arteriogram%'
	and lower(concept_name) not like '%anesthesia%'
	and lower(concept_name) not like '%trabeculodialysis%'
	and vocabulary_id in ('ICD9CM', 'ICD10', 'ICD10CM', 'SNOMED')
	and concept_class_id not in ('Pharma/Biol Product', 'Physical Object', 'Context-dependent')
	and domain_id not in ('Measurement')
order by vocabulary_id, concept_name

--SCRATCHWORK
--to consider using SM descendants + string matching (in SM, catches non-standard codes in case other sites are using)
select concept_id, concept_code, concept_name, vocabulary_id,
	case when vocabulary_id = 'ICD9CM' then '09'
		when vocabulary_id in ('ICD10', 'ICD10CM') then '10'
		when vocabulary_id = 'SNOMED' then 'SM'
	end pcornet_vocabulary_id
from concept where concept_id in (
select descendant_concept_id
from concept_ancestor
where ancestor_concept_id in (443601, 443597) --only stage 2 and 3 SNOMED descendants
)
union

select * from condition_occurrence_concept_name
where condition_concept_id in (
select concept_id from concept
where (lower(concept_name) like '%dialysis%')
	and lower(concept_name) not like '%iridodialysis%'
	and lower(concept_name) not like '%cyclodialysis%'
	and lower(concept_name) not like '%retina%'
	and lower(concept_name) not like '%transplant association%'
	and lower(concept_name) not like '%fluoroscop%'
	and lower(concept_name) not like '%ultrason%'
	and lower(concept_name) not like '%radionuclide%'
	and lower(concept_name) not like '%angiography%'
	and lower(concept_name) not like '%venogram%'
	and lower(concept_name) not like '%angiography%'
	and lower(concept_name) not like '%arteriogram%'
	and lower(concept_name) not like '%anesthesia%'
	and lower(concept_name) not like '%trabeculodialysis%'
	and vocabulary_id in ('ICD9CM', 'ICD10', 'ICD10CM', 'SNOMED')
	and concept_class_id not in ('Pharma/Biol Product', 'Physical Object', 'Context-dependent')
	and domain_id not in ('Measurement')
order by vocabulary_id, concept_name
) order by count desc;

select


SNOMED CKD 709044004
select * from concept
where concept_code = '709044004'
and vocabulary_id = 'SNOMED';

select * from concept where concept_id in (
select descendant_concept_id
from concept_ancestor
where ancestor_concept_id in (46271022)
)

--descendants of stage 2-3...
select * from concept where concept_id in (
select descendant_concept_id
from concept_ancestor
where ancestor_concept_id in (443601, 443597)
)

----ICD codes, 9 and 10
--stage 2
ICD9 585.2
ICD10 N18.2
--stage 3
ICD9 585.3
ICD10 N18.3, .30, .31, .32

select * from concept where concept_code like 'N18%' and vocabulary_id like '%ICD%'

select * from concept where concept_code = 'N18.31'

select * from concept
where concept_code in ('585.2', 'N18.3', 'N18.30', 'N18.31', 'N18.32') 
and vocabulary_id in ('ICD9CM', 'ICD10', 'ICD10CM');
44830173