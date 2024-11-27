--birth weight
select concept_id, concept_code, concept_name, vocabulary_id,
	case when vocabulary_id = 'LOINC' then 'LC'
	end pcornet_vocabulary_id
from vocabulary.concept
where concept_code = '8339-4'
order by concept_code;