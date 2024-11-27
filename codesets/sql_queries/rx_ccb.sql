set search_path to vocabulary, dcc_pedsnet;

--ccbs
--Medication codeset for the following ingredients: Amlodipine, Diltiazem, Felodipine, Isradipine, Nicardipine, Nifedipine, Nisoldipine ,Verapamil For commonly occurring medications, we will create indicator variables for the specific ingredient.
drop table ccbs;

create temporary table ccbs as (
with ing as (
	select * from concept
	where concept_id in (
1307863,--	"verapamil"
1332418,--	"amlodipine"
1326012,--	"isradipine"
1328165,--	"diltiazem"
1353776,--	"felodipine"
1318853,--	"nifedipine"
1318137,--	"nicardipine"
1319880--	"nisoldipine"
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
lower(concept_name) like '%amlodipine%' or
lower(concept_name) like '%diltiazem%' or
lower(concept_name) like '%felodipine%' or
lower(concept_name) like '%isradipine%' or
lower(concept_name) like '%nicardipine%' or
lower(concept_name) like '%nifedipine%' or
lower(concept_name) like '%nisoldipine%' or		
lower(concept_name) like '%verapamil%')
	and lower(c.concept_name) not like '%cream%'
	and lower(c.concept_name) not like '%ointment%'
	and lower(c.concept_name) not like '%buccal%'
	and lower(c.concept_name) not like '%ophthalmic%'
	and lower(c.concept_name) not like '%ocular%'
order by vocabulary_id, concept_code 
)

select * from ccbs;

--SCRATCH
select * from concept where lower(concept_name) in ('amlodipine', 'diltiazem','felodipine', 'isradipine', 'nicardipine',
												   'nifedipine', 'nisoldipine', 'verapamil')
and concept_class_id = 'Ingredient'
and vocabulary_id = 'RxNorm'

select vocabulary_id, count(concept_id) from ccbs group by vocabulary_id;

select drug_concept_id, drug_concept_name, count(drug_exposure_id)
from drug_exposure
where drug_concept_id in (select concept_id from ccbs)
group by drug_concept_id, drug_concept_name
order by count(drug_exposure_id) desc;
