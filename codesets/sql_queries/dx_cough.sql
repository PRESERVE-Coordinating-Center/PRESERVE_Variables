set search_path to vocabulary, dcc_pedsnet;

--cough - as condition

select * from concept where concept_code = '49727002' and vocabulary_id = 'SNOMED'; --cough

--many exclusions among SNOMED, so string matching made more sense
--string matching (in SM, catches non-standard codes in case other sites are using)
select distinct concept_id, concept_code, concept_name, vocabulary_id,
	case when vocabulary_id = 'ICD9CM' then '09'
		when vocabulary_id in ('ICD10', 'ICD10CM') then '10'
		when vocabulary_id = 'SNOMED' then 'SM'
	end pcornet_vocabulary_id
from concept
where (lower(concept_name) like '%cough%')-- and lower(concept_name) like '%difficulty%')
--inclusion
	and (lower(concept_name) not like '%testing%'
	and lower(concept_name) not like '%measurement%'
	and lower(concept_name) not like '%fh:%'
	and lower(concept_name) not like '%history%'
	and lower(concept_name) not like '%hiccough%'
	and lower(concept_name) not like '%whooping%'
	and lower(concept_name) not like '%headache%'
	and lower(concept_name) not like '%asthma%'
	and lower(concept_name) not like '%no cough%'
	and lower(concept_name) not like '%suppress%'
	and lower(concept_name) not like '%absent%'
	and lower(concept_name) not like '%hernia%'
	and lower(concept_name) not like '%unable%'
	and lower(concept_name) not like '%linctus%'
	and lower(concept_name) not like '%cough drop%'
	and lower(concept_name) not like '%incontinence%'
	and lower(concept_name) not like '%preparation%'
	and lower(concept_name) not like '%impulse%'
	and lower(concept_name) not like '%swab%'
	and lower(concept_name) not like '%meltus%'
	and lower(concept_name) not like '%benylin%'
	and lower(concept_name) not like '%vicks%'
	and lower(concept_name) not like '%arnold%'
	and lower(concept_name) not like '%syrup%'
	and lower(concept_name) not like '%difficulty%'
	and lower(concept_name) not like '%robitussin%'
	and lower(concept_name) not like '%strepsils%'
	)--exclusion
	and concept_id not in (4128691, 4082168, 4087178, 4021673, 4038065, 4010220,40413022, 4086815, 4103332, 40504199, 4117281, 4116780, 4117283, 4116782, 4142152, 4137418, 3607588, 3608270, 4146379, 4294425, 4160368, 4269128, 4278454, 4275649, 4278453, 4239599, 4144596, 4199298, 35626060, 4122563, 4128691, 4122567, 4125451, 4077210, 4140570, 4142946, 3578500, 4093342, 4091025, 3571201, 4087179, 3652045, 3657556, 35631543, 3619607, 3620844, 3620845, 3585834, 3585592, 3522838, 3585533, 35626061)
	and domain_id not in ('Drug', 'Procedure', 'Measurement', 'Type Concept', 'Metadata', 'Specimen', 'Device')
	and vocabulary_id in ('ICD9CM', 'ICD10', 'ICD10CM', 'SNOMED')
order by vocabulary_id, concept_code

--SCRATCHWORK
