-- initial work for quick turnaround requirement for "alpha blocker" ingredients
select distinct concept_id, concept_name, concept_code, vocabulary_id from vocabulary.concept
where concept_class_id = 'Ingredient'
and vocabulary_id = 'RxNorm'
and standard_concept = 'S'
and (concept_id in
(select distinct descendant_concept_id from vocabulary.concept_ancestor
where ancestor_concept_id in (21600410, -- Alpha-adrenoreceptor antagonists
							  21602667, -- Alpha-adrenoreceptor antagonists
							  21601698)) -- Alpha and beta blocking agents
or (concept_class_id = 'Ingredient'
and (lower(concept_name) in ('phenoxybenzamine',
							 'phentolamine',
							 'tolazoline',
							 'trazodone',
							 'atipamezole',
							 'idazoxan',
							 'mirtazapine',
							 'yohimbine'))));