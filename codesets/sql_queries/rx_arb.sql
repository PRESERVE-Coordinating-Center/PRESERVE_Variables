set search_path to vocabulary, dcc_pedsnet;

--arbs
--"Medication codeset for the following ingredients: Azilsartan, Candesartan,Eprosartan,Irbesartan,Losartan,Olmesartan,Telmisartan, Valsartan For commonly occurring medications, we will create indicator variables for the specific ingredient."
drop table arbs;

create temporary table arbs as (
with ing as (
	select * from concept
	where concept_id in (
40235485,--	"azilsartan"
1351557,--	"candesartan"
40226742,--	"olmesartan"
1367500,--	"losartan"
1308842,--	"valsartan"
1347384,--	"irbesartan"
1317640,--	"telmisartan"
1346686--	"eprosartan"
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
	and lower(c.concept_name) not like '%ophthalmic%'
	and lower(c.concept_name) not like '%ocular%'
union
select distinct c.concept_id, c.concept_name, c.concept_code, c.vocabulary_id,
	case when c.vocabulary_id = 'NDC' then 'ND'
		 when c.vocabulary_id in ('RxNorm', 'RxNorm Extension') then 'RX'
	end pcornet_vocabulary_id
from concept c
where (c.vocabulary_id like 'RxNorm%' or c.vocabulary_id like 'NDC')
	and (
lower(concept_name) like '%azilsartan%' or
lower(concept_name) like '%candesartan%' or
lower(concept_name) like '%eprosartan%' or
lower(concept_name) like '%irbesartan%' or
lower(concept_name) like '%losartan%' or
lower(concept_name) like '%olmesartan%' or
lower(concept_name) like '%telmisartan%' or		
lower(concept_name) like '%valsartan%')	
	and lower(c.concept_name) not like '%cream%'
	and lower(c.concept_name) not like '%ointment%'
	and lower(c.concept_name) not like '%buccal%'
	and lower(c.concept_name) not like '%ophthalmic%'
	and lower(c.concept_name) not like '%ocular%'
order by vocabulary_id, concept_code 
)

select * from arbs;

--SCRATCH
select * from concept where lower(concept_name) in ('azilsartan',
'candesartan',
'eprosartan',
'irbesartan',
'losartan',
'olmesartan',
'telmisartan',
'valsartan')
and concept_class_id = 'Ingredient'
and vocabulary_id = 'RxNorm'

select vocabulary_id, count(concept_id) from arbs group by vocabulary_id;

select drug_concept_id, drug_concept_name, count(drug_exposure_id)
from drug_exposure
where drug_concept_id in (select concept_id from arbs)
group by drug_concept_id, drug_concept_name
order by count(drug_exposure_id) desc;
