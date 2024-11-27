-- Nephrotoxic chemotherapies
-- All RxNorm and NDC descendants of ATC classes
-- for nephrotoxic chemotherapies listed in
-- https://doi.org/10.1053/j.ackd.2019.08.005
-- and cabroplatin, melphalan, carmustine, lomustine, and azacitidine per Charles Bailey, MD
-- "L04AX04"	"lenalidomide; oral"
-- "L01XG02"	"carfilzomib; parenteral"
-- "L01XG01"	"bortezomib; parenteral"
-- "L01BA04"	"pemetrexed; inhalant, parenteral"
-- "L01AA03"	"melphalan; systemic"
-- "L01EA02"	"dasatinib; oral"
-- "L01EX02"	"sorafenib; oral"
-- "L01ED01"	"crizotinib; oral"
-- "L01XC06"	"cetuximab; parenteral"
-- "L01XA02"	"carboplatin; inhalant, parenteral"
-- "L01BC07"	"azacitidine; systemic"
-- "L01AD02"	"lomustine; oral"
-- "L01XC07"	"bevacizumab; ophthalmic, parenteral"
-- "L01AA06"	"ifosfamide; parenteral"
-- "L01BC05"	"gemcitabine; parenteral"
-- "L01XA01"	"cisplatin; inhalant, parenteral"
-- "L01AD01"	"carmustine; parenteral, topical, transdermal"
-- "L01EC02"	"dabrafenib; oral"
-- "L04AA18"	"everolimus; oral (selective immunosuppressants)"
-- "L01EC01"	"vemurafenib; oral"
-- "L01EX01"	"sunitinib; oral"
-- "L01EL01"	"ibrutinib; oral"
-- "L01XX52"	"venetoclax; oral"
-- "L01XC08"	"panitumumab; parenteral"
-- "L04AX03"	"methotrexate; systemic (immunosuppressants)"
-- "L01EG01"	"temsirolimus; parenteral"
-- "L01EA01"	"imatinib; oral (bcr-abl tyrosine kinase inhibitors)"
select concept_id, concept_name, concept_code, vocabulary_id,
case when vocabulary_id = 'NDC' then 'ND'
when vocabulary_id in ('RxNorm', 'RxNorm Extension') then 'RX'
end pcornet_vocabulary_id,
atc_code, atc_name
from
(select ancestor_concept_id, descendant_concept_id,
atc_code, atc_name from
(select concept_id,
concept_code as atc_code,
concept_name as atc_name
from vocabulary.concept
where (concept_code in
('L01AA06',
'L01BA04',
'L01BC05',
'L01EA01',
'L01EA02',
'L01EC01',
'L01EC02',
'L01ED01',
'L01EG01',
'L01EL01',
'L01EX01',
'L01EX02',
'L01XA01',
'L01XC06',
'L01XC07',
'L01XC08',
'L01XG01',
'L01XG02',
'L01XX52',
'L04AA18',
'L04AX03',
'L04AX04',
'L01XA02',
'L01AA03',
'L01AD01',
'L01AD02',
'L01BC07'
) -- ATC classes for nephrotoxic chemotherapies listed https://doi.org/10.1053/j.ackd.2019.08.005
and vocabulary_id = 'ATC')) as nt_chemo
inner join vocabulary.concept_ancestor as ancestors
on nt_chemo.concept_id = ancestors.ancestor_concept_id) as descendants
inner join vocabulary.concept as concept
on descendants.descendant_concept_id = concept.concept_id
where concept.vocabulary_id in ('RxNorm', 'NDC', 'RxNorm Extension')
and domain_id = 'Drug'; 