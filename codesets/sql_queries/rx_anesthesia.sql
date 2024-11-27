select distinct c.concept_id, c.concept_name, c.concept_code, c.vocabulary_id 
from vocabulary.concept a
inner join vocabulary.concept_ancestor b
on a.concept_id = b.ancestor_concept_id
inner join vocabulary.concept c
on b.descendant_concept_id = c.concept_id
where a.concept_code in ('1162323', '377483', '1808216', --propofol (intravenous)
	'1157926', '1653759', '727530',-- etomidate (intravenous)
	'372528', '1160946',-- ketamine (intravenous)
	'1164715', '379133', '1666797', '998210',-- midazolam (intravenous)
	'379186', '1735002', '2474266', '1159054', '1159056',-- fentanyl (intravenous)
	'385093', '1159834',-- nitrous oxide (inhaled)
	'1159080', '2108407',-- sevoflurane (inhaled)
	'2108330', '1157752',-- desflurane (inhaled)
	'2108461', '1159154'-- isoflurane (inhaled)
) and a.vocabulary_id ilike '%RxNorm%'

--for midazolam, 1666776 cartridge?
--for fentanyl, 1734964 cartridge?