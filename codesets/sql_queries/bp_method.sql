set search_path to concept, dcc_pedsnet;

--bp method

select * from concept where lower(concept_name) like '%sphygmo%'
    and vocabulary_id in ('ICD9Proc', 'ICD10PCS', 'CPT4', 'HCPCS', 'SNOMED')

select concept_id, concept_code, concept_name, vocabulary_id,
	case when vocabulary_id = 'LOINC' then 'LC'
        when vocabulary_id = 'ICD9Proc' then '9'
		when vocabulary_id in ('ICD10PCS') then '10'
		when vocabulary_id in ('CPT4', 'HCPCS') then 'CH'
		when vocabulary_id in ('SNOMED') then 'SM'
	end pcornet_vocabulary_id
from concept
where (lower(concept_name) like '%auscultation - automatic%'
    or lower(concept_name) like 'auscultation - manual%'
    or (lower(concept_name) like '%blood pressure%' and lower(concept_name) like '%measure%')
    or (lower(concept_name) like '%blood pressure%' and lower(concept_name) like '%ambulatory%')
      )
    and lower(concept_name) not like '%decline%'
    and lower(concept_name) not like '%no documentation%'
    and lower(concept_name) not like '% not %'
    and lower(concept_name) not like '%most recent%'
    and lower(concept_name) not like '%peak%'
    and lower(concept_name) not like '%refer%'
    and lower(concept_name) not like '%recommend%'
    and lower(concept_name) not like '%removal%'
    and lower(concept_name) not like '%operative%'
    and lower(concept_name) not like '%site%'
    
    and lower(concept_name) not like '%arrhythmia%'
    and lower(concept_name) not like '%heart failure%'
    and lower(concept_name) not like '%ambulatory%' --to remove ABPM
    and lower(concept_name) not like '%monitor%' --to remove ABPM
	and lower(concept_name) not like '%recorder%'
    and concept_id not in (2102813, 2514552, 40761342, 1034824, 35613892, 4310015)
    and vocabulary_id in ('ICD9Proc', 'ICD10PCS', 'CPT4', 'HCPCS', 'SNOMED', 'LOINC')
order by vocabulary_id, concept_code

select * from concept
where (lower(concept_name) like '%blood pressure%' and lower(concept_name) like '%ambulatory%')
and vocabulary_id in ('ICD9Proc', 'ICD10PCS', 'CPT4', 'HCPCS', 'SNOMED', 'LOINC')
