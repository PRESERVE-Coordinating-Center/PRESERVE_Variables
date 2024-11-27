set search_path to vocabulary, dcc_pedsnet;

--bbs
--"Medication codeset for the following ingredients:, Acebutolol, Atenolol, Betaxolol,Bisoprolol, Carteolol, Carvediol, Labetalol, Metoprolol, Nadolol, Nebivolol, Penbutolol, Pindolol, Propanolol, Sotalol, Timolol - For commonly occurring medications, we will create indicator variables for the specific ingredient."
drop table bbs;

create temporary table bbs as (
with ing as (
	select * from concept
	where concept_id in (
1322081,--	"betaxolol"
902427,--	"timolol"
1314002,--	"atenolol"
1346823,--	"carvedilol"
1319998,--	"acebutolol"
1338005,--	"bisoprolol"
950370,--	"carteolol"
1314577,--	"nebivolol"
1386957,--	"labetalol"
1307046,--	"metoprolol"
1313200,--	"nadolol"
1327978,--	"penbutolol"
1345858,--	"pindolol"
1353766,--	"propranolol"
1370109--	"sotalol"
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
lower(concept_name) like '%acebutolol%' or
lower(concept_name) like '%atenolol%' or
lower(concept_name) like '%betaxolol%' or
lower(concept_name) like '%bisoprolol%' or
lower(concept_name) like '%carteolol%' or
lower(concept_name) like '%carvedilol%' or
lower(concept_name) like '%labetalol%' or		
lower(concept_name) like '%metoprolol%' or
lower(concept_name) like '%nadolol%' or
lower(concept_name) like '%nebivolol%' or
lower(concept_name) like '%penbutolol%' or
lower(concept_name) like '%pindolol%' or
lower(concept_name) like '%propranolol%' or
lower(concept_name) like '%sotalol%' or
lower(concept_name) like '%timolol%'
)
	and lower(c.concept_name) not like '%cream%'
	and lower(c.concept_name) not like '%ointment%'
	and lower(c.concept_name) not like '%buccal%'
	and lower(c.concept_name) not like '%ophthalmic%'
	and lower(c.concept_name) not like '%ocular%'
order by vocabulary_id, concept_code 
)

select * from bbs;

--SCRATCH

select * from concept where lower(concept_name) in ('acebutolol',
'atenolol',
'betaxolol',
'bisoprolol',
'carteolol',
'carvedilol',
'labetalol',
'metoprolol',
'nadolol',
'nebivolol',
'penbutolol',
'pindolol',
'propranolol',
'sotalol',
'timolol')
and concept_class_id = 'Ingredient'
and vocabulary_id = 'RxNorm'

select vocabulary_id, count(concept_id) from bbs group by vocabulary_id;

select drug_concept_id, drug_concept_name, count(drug_exposure_id)
from drug_exposure
where drug_concept_id in (select concept_id from bbs)
group by drug_concept_id, drug_concept_name
order by count(drug_exposure_id) desc;
