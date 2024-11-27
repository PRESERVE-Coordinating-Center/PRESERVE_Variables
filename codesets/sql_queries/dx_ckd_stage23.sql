set search_path to concept, dcc_pedsnet;

--chronic kidney disease
--Diagnosis codeset for chronic kidney disease, stages 2, 3, 3a, or 3b

--SM descendants + string matching (in SM, catches non-standard codes in case other sites are using)
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
select concept_id, concept_code, concept_name, vocabulary_id,
	case when vocabulary_id = 'ICD9CM' then '9'
		when vocabulary_id in ('ICD10', 'ICD10CM') then '10'
		when vocabulary_id = 'SNOMED' then 'SM'
	end pcornet_vocabulary_id
from concept
where (lower(concept_name) like '%chronic kidney disease%' or lower(concept_name) like '%chronic renal disease%')
	and (lower(concept_name) like '%stage 2%' or lower(concept_name) like '%stage ii%'
		 or lower(concept_name) like '%stage 3%' or lower(concept_name) like '%stage iii%')
	and vocabulary_id in ('ICD9CM', 'ICD10', 'ICD10CM', 'SNOMED') --excluded 'ICD10' b/c duplicates with 'ICD10CM'
order by vocabulary_id, concept_name

--SCRATCHWORK
----SNOMED
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