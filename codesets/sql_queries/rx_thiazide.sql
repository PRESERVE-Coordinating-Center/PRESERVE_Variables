set search_path to vocabulary, dcc_pedsnet;

--thiazides
--Medication codeset for the following ingredients: Chlorothiazide, Chlorthalidone, Hydrochlorothiazide, Indapamide, Metolazone
drop table thiazide;

create temporary table thiazide as (
with ing as (
	select * from concept
	where concept_id in (
974166,--	"hydrochlorothiazide"
992590,--	"chlorothiazide"
1395058,--	"chlorthalidone"
978555,-- "indapamide"
907013 -- "metolazone"
	)
)

select distinct c.concept_id, c.concept_name, c.concept_code, c.vocabulary_id,
	case when c.vocabulary_id = 'NDC' then 'ND'
		 when c.vocabulary_id in ('RxNorm', 'RxNorm Extension') then 'RX'
	end pcornet_vocabulary_id
from ing c2
	left outer join concept_ancestor ca on c2.concept_id = ca.ancestor_concept_id
	left outer join concept c on ca.descendant_concept_id = c.concept_id
where c.vocabulary_id like 'RxNorm%'
	and lower(c.concept_name) not like '%cream%'
	and lower(c.concept_name) not like '%ointment%'
	and lower(c.concept_name) not like '%buccal%'
union
select distinct c.concept_id, c.concept_name, c.concept_code, c.vocabulary_id,
	case when c.vocabulary_id = 'NDC' then 'ND'
		 when c.vocabulary_id in ('RxNorm', 'RxNorm Extension') then 'RX'
	end pcornet_vocabulary_id
from concept c
where (c.vocabulary_id like 'RxNorm%' or c.vocabulary_id like 'NDC')
	and (
lower(concept_name) like '%hydrochlorothiazide%' or
lower(concept_name) like '%chlorothiazide%' or
lower(concept_name) like '%chlorthalidone%' or
lower(concept_name) like '%indapamide%' or
lower(concept_name) like '%metolazone%'
		)
	and lower(c.concept_name) not like '%cream%'
	and lower(c.concept_name) not like '%ointment%'
	and lower(c.concept_name) not like '%buccal%'
order by vocabulary_id, concept_code 
)

select * from thiazide;

--SCRATCH
select * from concept where lower(concept_name) like '%metolazone%' and concept_class_id = 'Ingredient'

select vocabulary_id, pcornet_vocabulary_id, count(concept_id) from thiazide group by vocabulary_id, pcornet_vocabulary_id;

select drug_concept_id, drug_concept_name, count(drug_exposure_id)
from drug_exposure
where drug_concept_id in (select concept_id from thiazide)
group by drug_concept_id, drug_concept_name
order by count(drug_exposure_id) desc;
	limit 10;


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

