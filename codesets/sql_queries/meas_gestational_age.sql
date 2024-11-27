--gestational age
select concept_id, concept_code, concept_name, vocabulary_id,
	case when vocabulary_id = 'LOINC' then 'LC'
	end pcornet_vocabulary_id
from vocabulary.concept
where concept_code = '18185-9'
order by concept_code;