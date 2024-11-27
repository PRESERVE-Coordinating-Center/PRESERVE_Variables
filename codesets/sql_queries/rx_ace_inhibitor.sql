set search_path to vocabulary, dcc_pedsnet;

--ace
--"Medication codeset for the following ingredients: Benazepril, Captopril, Enalapril, Fosinopril, Lisinopril, Moexipril, Periondopril, Quinapril,Ramipril, Trandolapril For commonly occurring medications, we will create indicator variables for the specific ingredient."
drop table ace;

create temporary table ace as (
with ing as (
	select * from concept
	where concept_id in (
1335471,--	"benazepril"
1340128,--	"captopril"
1308216,--	"lisinopril"
1310756,--	"moexipril"
1331235,--	"quinapril"
1334456,--	"ramipril"
1341927,--	"enalapril"
1342439,--	"trandolapril"
1363749,--	"fosinopril"
1373225--	"perindopril"
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
lower(concept_name) like '%benazepril%' or
lower(concept_name) like '%captopril%' or
lower(concept_name) like '%enalapril%' or
lower(concept_name) like '%fosinopril%' or
lower(concept_name) like '%lisinopril%' or
lower(concept_name) like '%moexipril%' or
lower(concept_name) like '%perindopril%' or		
lower(concept_name) like '%quinapril%' or
lower(concept_name) like '%ramipril%' or
lower(concept_name) like '%trandolapril%'
)	
	and lower(c.concept_name) not like '%cream%'
	and lower(c.concept_name) not like '%ointment%'
	and lower(c.concept_name) not like '%buccal%'
	and lower(c.concept_name) not like '%ophthalmic%'
	and lower(c.concept_name) not like '%ocular%'
order by vocabulary_id, concept_code 
)

select * from ace;

--SCRATCH

select * from concept where lower(concept_name) in ('benazepril',
'captopril',
'enalapril',
'fosinopril',
'lisinopril',
'moexipril',
'perindopril',
'quinapril',
'ramipril',
'trandolapril')
and concept_class_id = 'Ingredient'
and vocabulary_id = 'RxNorm'

select vocabulary_id, count(concept_id) from ace group by vocabulary_id;

select drug_concept_id, drug_concept_name, count(drug_exposure_id)
from drug_exposure
where drug_concept_id in (select concept_id from ace)
group by drug_concept_id, drug_concept_name
order by count(drug_exposure_id) desc;
