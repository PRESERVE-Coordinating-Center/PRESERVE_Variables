-- Antineoplastics
-- All RxNorm and NDC descendants of ATC classes
-- for antineoplastics listed in
-- https://athena.ohdsi.org/search-terms/terms/21601387
-- "L01" Antineoplastic Agents
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
('L01') -- ATC classes for antineoplastics listed in 
	    -- https://athena.ohdsi.org/search-terms/terms/21601387
and vocabulary_id = 'ATC')) as anti_np
inner join vocabulary.concept_ancestor as ancestors
on anti_np.concept_id = ancestors.ancestor_concept_id) as descendants
inner join vocabulary.concept as concept
on descendants.descendant_concept_id = concept.concept_id
where concept.vocabulary_id in ('RxNorm', 'NDC', 'RxNorm Extension')
and domain_id = 'Drug';