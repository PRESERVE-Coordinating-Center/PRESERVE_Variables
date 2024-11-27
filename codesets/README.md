# PRESERVE codesets

This repo contains codesets for the PRESERVE project. Codesets have been constructed with both the PEDSnet and PCORnet common date models as targets. Please read "notes on usage" for each target CDM. We also include what PCORnet terms valuesets in this codeset repo.

## Condition

Notes on usage in PCORnet:

-   Tables: DIAGNOSIS, CONDITION

-   Use distinct `concept_code` and `pcornet_vocabulary_id` columns

-   Where `concept_code` is included with and without decimal point removal, adjust for potential double counting in analyses

-   Join the `concept_code` column and the `pcornet_vocabulary_id` column in the codeset to the `DX` column and `DX_TYPE` column in the DIAGNOSIS table, respectively

Notes on usage in PEDSnet:

-   Tables: condition_occurrence

-   Use distinct `concept_id` and `vocabulary_id` columns

Codeset structure:

| concept_id | concept_code | concept_name | vocabulary_id | pcornet_vocabulary_id | cc_decimal_removal|
|------------|--------------|--------------|---------------|-----------------------|-------------------------------------------------------------|
|            |              |              |               |                       |flag for whether decimal has been removed from `concept_code`|

where `pcornet_vocabulary_id` is an acceptable value according to the supported values in the `VALUESET_ITEM` column below (please note leading zero for "09"):

| FIELD_NAME    | VALUESET_ITEM (pcornet_vocabulary_id) | VALUESET_ITEM_DESCRIPTOR |
|---------------|---------------------------------------|--------------------------|
| DX_TYPE       | 09                                    | 09=ICD-9-CM              |
| DX_TYPE       | 10                                    | 10=ICD-10-CM             |
| DX_TYPE       | 11                                    | 11=ICD-11-CM             |
| DX_TYPE       | SM                                    | SM=SNOMED CT             |

Codesets and valuesets:

<table>
<thead>
<tr class="header">
<th><p>Name</p></th>
<th><p>Codeset link</p></th>
<th><p>Description</p></th>
<th><p>Vocabularies</p></th>
<th><p>SQL link</p></th>
<th><p>Date developed</p></th>
<th><p>Developer</p></th>
<th><p>Status</p></th>
<th><p>Date finalized</p></th>
<th><p>Other</p></th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><p>dx_ckd_stage23</p></td>
<td><p><a href="condition/dx_ckd_stage23.csv">dx_ckd_stage23</a></p></td>
<td><p>Diagnoses for chronic kidney disease stages 2 and 3</p></td>
<td><p>ICD10, ICD10CM, ICD9CM, SNOMED</p></td>
<td><p><a href="sql_queries/dx_ckd_stage23.sql">dx_ckd_stage23.sql</a></p></td>
<td><p>2021-11</p></td>
<td><p>Levon Utidjian</p></td>
<td><p>vocab-based</p></td>
<td></td>
<td><p>ICD codes are included with and without decimal points, indicated by <code>cc_decimal_removal</code></p></td>
</tr>
<tr class="even">
<td><p>dx_kidney_transplant</p></td>
<td><p><a href="condition/dx_kidney_transplant.csv">dx_kidney_transplant</a></p></td>
<td><p>Kidney transplant diagnosis codes</p></td>
<td><p>ICD10, ICD10CM, ICD9CM, SNOMED</p></td>
<td><p><a href="sql_queries/dx_kidney_transplant.sql">dx_kidney_transplant.sql</a></p></td>
<td><p>2021-11</p></td>
<td><p>Levon Utidjian</p></td>
<td><p>vocab-based</p></td>
<td></td>
<td><p>ICD codes are included with and without decimal points, indicated by <code>cc_decimal_removal</code></p></td>
</tr>
<tr class="odd">
<td><p>dx_kidney_dialysis</p></td>
<td><p><a href="condition/dx_kidney_dialysis.csv">dx_kidney_dialysis</a></p></td>
<td><p>Kidney dialysis diagnosis codes</p></td>
<td><p>ICD10, ICD10CM, ICD9CM, SNOMED</p></td>
<td><p><a href="sql_queries/dx_kidney_dialysis.sql">dx_kidney_dialysis.sql</a></p></td>
<td><p>2021-11</p></td>
<td><p>Levon Utidjian</p></td>
<td><p>vocab-based</p></td>
<td></td>
<td><p>ICD codes are included with and without decimal points, indicated by <code>cc_decimal_removal</code></p></td>
</tr>
<tr class="even">
<td><p>dx_hypertension</p></td>
<td><p><a href="condition/dx_hypertension.csv">dx_hypertension</a></p></td>
<td><p>Hypertension diagnosis codes</p></td>
<td><p>ICD10, ICD10CM, ICD9CM, SNOMED</p></td>
<td></td>
<td><p>2022-01</p></td>
<td><p>Levon Utidjian</p></td>
<td><p>vocab-based</p></td>
<td></td>
<td><p>ICD codes are included with and without decimal points, indicated by <code>cc_decimal_removal</code></p></td>
</tr>
<tr class="odd">
<td><p>dx_asthma</p></td>
<td><p><a href="condition/dx_asthma.csv">dx_asthma</a></p></td>
<td><p>Asthma diagnosis codes</p></td>
<td><p>ICD10, ICD10CM, ICD9CM, SNOMED</p></td>
<td><p><a href="sql_queries/dx_asthma.sql">dx_asthma.sql</a></p></td>
<td><p>2022-03</p></td>
<td><p>Levon Utidjian</p></td>
<td><p>vocab-based</p></td>
<td></td>
<td><p>ICD codes are included with and without decimal points, indicated by <code>cc_decimal_removal</code></p></td>
</tr>
<tr class="even">
<td><p>dx_pericarditis</p></td>
<td><p><a href="condition/dx_pericarditis.csv">dx_pericarditis</a></p></td>
<td><p>Pericarditis diagnosis codes</p></td>
<td><p>ICD10, ICD10CM, ICD9CM, SNOMED</p></td>
<td><p><a href="sql_queries/dx_pericarditis.sql">dx_pericarditis.sql</a></p></td>
<td><p>2022-03</p></td>
<td><p>Levon Utidjian</p></td>
<td><p>vocab-based</p></td>
<td></td>
<td><p>ICD codes are included with and without decimal points, indicated by <code>cc_decimal_removal</code></p></td>
</tr>
<tr class="odd">
<td><p>dx_ckd_allstages</p></td>
<td><p><a href="condition/dx_ckd_allstages.csv">dx_ckd_allstages</a></p></td>
<td><p>Diagnoses for all chronic kidney disease stages</p></td>
<td><p>ICD10, ICD10CM, ICD9CM, SNOMED</p></td>
<td><p><a href="sql_queries/dx_ckd_allstages.sql">dx_ckd_allstages.sql</a></p></td>
<td><p>2022-03</p></td>
<td><p>Levon Utidjian</p></td>
<td><p>vocab-based</p></td>
<td></td>
<td><p>ICD codes are included with and without decimal points, indicated by <code>cc_decimal_removal</code></p></td>
</tr>
<tr class="even">
<td><p>dx_nocturnal_enuresis</p></td>
<td><p><a href="condition/dx_nocturnal_enuresis.csv">dx_nocturnal_enuresis</a></p></td>
<td><p>Diagnoses for nocturnal enuresis</p></td>
<td><p>ICD10, ICD10CM, ICD9CM, SNOMED</p></td>
<td><p><a href="sql_queries/dx_nocturnal_enuresis.sql">dx_nocturnal_enuresis.sql</a></p></td>
<td><p>2022-03</p></td>
<td><p>Levon Utidjian</p></td>
<td><p>vocab-based</p></td>
<td></td>
<td><p>ICD codes are included with and without decimal points, indicated by <code>cc_decimal_removal</code></p></td>
</tr>
<tr class="odd">
<td><p>dx_stomatitis</p></td>
<td><p><a href="condition/dx_stomatitis.csv">dx_stomatitis</a></p></td>
<td><p>Diagnoses for stomatitis</p></td>
<td><p>ICD10, ICD10CM, ICD9CM, SNOMED</p></td>
<td><p><a href="sql_queries/dx_stomatitis.sql">dx_stomatitis.sql</a></p></td>
<td><p>2022-03</p></td>
<td><p>Levon Utidjian</p></td>
<td><p>vocab-based</p></td>
<td></td>
<td><p>ICD codes are included with and without decimal points, indicated by <code>cc_decimal_removal</code></p></td>
</tr>
<tr class="even">
<td><p>dx_glomerular_disease</p></td>
<td><p><a href="condition/dx_glomerular_disease.csv">dx_glomerular_disease</a></p></td>
<td><p>Diagnoses for glomerular disease</p></td>
<td><p>ICD10, ICD10CM, ICD9CM, SNOMED</p></td>
<td><p><a href="sql_queries/dx_glomerular_disease.sql">dx_glomerular_disease.sql</a></p></td>
<td><p>2022-06</p></td>
<td><p>Levon Utidjian</p></td>
<td><p>vocab-based</p></td>
<td></td>
<td><p>ICD codes are included with and without decimal points, indicated by <code>cc_decimal_removal</code>. This codeset requires further review.</p></td>
</tr>
<tr class="odd">
<td><p>dx_glomerular_snomed</p></td>
<td><p><a href="condition/dx_glomerular_snomed.csv">dx_glomerular_snomed</a></p></td>
<td><p>SNOMED-only diagnoses for glomerular disease, developed for the FSGS project</p></td>
<td><p>SNOMED</p></td>
<td><p>NA</p></td>
<td><p>2021-03</p></td>
<td><p>Amy Goodwin Davies and Michelle Denburg</p></td>
<td><p>clinician-review</p></td>
<td></td>
<td><p>This codeset is provided as a reference for developing an updated PCORnet codeset</p></td>
</tr>
<tr class="even">
<td><p>dx_cancer</p></td>
<td><p><a href="condition/dx_cancer.csv">dx_cancer</a></p></td>
<td><p>Diagnoses for cancer malignancy</p></td>
<td><p>ICD10, ICD10CM, ICD9CM, SNOMED</p></td>
<td><p><a href="sql_queries/dx_cancer.sql">dx_cancer.sql</a></p></td>
<td><p>2022-12</p></td>
<td><p>Amy Goodwin Davies</p></td>
<td><p>vocab-based</p></td>
<td></td>
<td><p>ICD codes are included with and without decimal points, indicated by <code>cc_decimal_removal</code></p></td>
</tr>
<tr class="odd">
<td><p>dx_hypertension_no_pregnancy</p></td>
<td><p><a href="condition/dx_hypertension_no_pregnancy.csv">dx_hypertension_no_pregnancy</a></p></td>
<td><p>Diagnoses for hypertension, excluding those related to pregnancy</p></td>
<td><p>SNOMED</p></td>
<td><p>NA</p></td>
<td><p>2023-01</p></td>
<td><p>Hanieh Razzaghi</p></td>
<td><p>vocab-based</p></td>
<td></td>
<td><p>This codeset is a subset of <a href="condition/dx_hypertension.csv">dx_hypertension</a></p></td>
</tr>
<tr class="even">
<td><p>dx_cakut</p></td>
<td><p><a href="condition/dx_cakut.csv">dx_cakut</a></p></td>
<td><p>Diagnoses for congenital anomalies of the kidneys and urinary tracts CAKUT</p></td>
<td><p>ICD10, ICD10CM, ICD9CM, SNOMED</p></td>
<td><p><a href="sql_queries/dx_cakut.sql">dx_cakut.sql</a></p></td>
<td><p>2023-07</p></td>
<td><p>Levon Utidjian</p></td>
<td><p>vocab-based</p></td>
<td></td>
<td><p>ICD codes are included with and without decimal points, indicated by <code>cc_decimal_removal</code></p></td>
</tr>
<tr class="odd">
<td><p>dx_cough</p></td>
<td><p><a href="condition/dx_cough.csv">dx_cough</a></p></td>
<td><p>Diagnoses for cough</p></td>
<td><p>ICD10, ICD10CM, ICD9CM, SNOMED</p></td>
<td><p><a href="sql_queries/dx_cough.sql">dx_cough.sql</a></p></td>
<td><p>2023-08</p></td>
<td><p>Levon Utidjian</p></td>
<td><p>vocab-based</p></td>
<td></td>
<td><p>ICD codes are included with and without decimal points, indicated by <code>cc_decimal_removal</code></p></td>
</tr>
<tr class="even">
<td><p>dx_hypotension</p></td>
<td><p><a href="condition/dx_hypotension.csv">dx_hypotension</a></p></td>
<td><p>Diagnoses for hypotension</p></td>
<td><p>ICD10, ICD10CM, ICD9CM, SNOMED</p></td>
<td><p><a href="sql_queries/dx_hypotension.sql">dx_hypotension.sql</a></p></td>
<td><p>2022-04</p></td>
<td><p>Levon Utidjian</p></td>
<td><p>vocab-based</p></td>
<td></td>
<td><p>ICD codes are included with and without decimal points, indicated by <code>cc_decimal_removal</code></p></td>
</tr>
<tr class="odd">
<td><p>dx_pyelonephritis</p></td>
<td><p><a href="condition/dx_pyelonephritis.csv">dx_pyelonephritis</a></p></td>
<td><p>Diagnoses for pyelonephritis</p></td>
<td><p>ICD10, ICD10CM, ICD9CM, SNOMED</p></td>
<td><p><a href="sql_queries/dx_pyelonephritis.sql">dx_pyelonephritis.sql</a></p></td>
<td><p>2022-04</p></td>
<td><p>Levon Utidjian</p></td>
<td><p>vocab-based</p></td>
<td></td>
<td><p>ICD codes are included with and without decimal points, indicated by <code>cc_decimal_removal</code></p></td>
</tr>
<tr class="even">
<td><p>dx_tonsillitis</p></td>
<td><p><a href="condition/dx_tonsillitis.csv">dx_tonsillitis</a></p></td>
<td><p>Diagnoses for tonsillitis</p></td>
<td><p>ICD10, ICD10CM, ICD9CM, SNOMED</p></td>
<td><p><a href="sql_queries/dx_tonsillitis.sql">dx_tonsillitis.sql</a></p></td>
<td><p>2022-04</p></td>
<td><p>Levon Utidjian</p></td>
<td><p>vocab-based</p></td>
<td></td>
<td><p>ICD codes are included with and without decimal points, indicated by <code>cc_decimal_removal</code></p></td>
</tr>
<tr class="odd">
<td><p>dx_uti</p></td>
<td><p><a href="condition/dx_uti.csv">dx_uti</a></p></td>
<td><p>Diagnoses for urinary tract infection uti</p></td>
<td><p>ICD10, ICD10CM, ICD9CM, SNOMED</p></td>
<td><p><a href="sql_queries/dx_uti.sql">dx_uti.sql</a></p></td>
<td><p>2022-04</p></td>
<td><p>Levon Utidjian</p></td>
<td><p>vocab-based</p></td>
<td></td>
<td><p>ICD codes are included with and without decimal points, indicated by <code>cc_decimal_removal</code></p></td>
</tr>
<tr class="even">
<td><p>dx_edema</p></td>
<td><p><a href="condition/dx_edema.csv">dx_edema</a></p></td>
<td><p>Diagnoses for edema</p></td>
<td><p>ICD10, ICD10CM, ICD9CM, SNOMED</p></td>
<td><p><a href="sql_queries/dx_edema.sql">dx_edema.sql</a></p></td>
<td><p>2023-10</p></td>
<td><p>Levon Utidjian</p></td>
<td><p>vocab-based</p></td>
<td></td>
<td><p>ICD codes are included with and without decimal points, indicated by <code>cc_decimal_removal</code></p></td>
</tr>
<tr class="odd">
<td><p>dx_fatigue</p></td>
<td><p><a href="condition/dx_fatigue.csv">dx_fatigue</a></p></td>
<td><p>Diagnoses for fatigue</p></td>
<td><p>ICD10, ICD10CM, ICD9CM, SNOMED</p></td>
<td><p><a href="sql_queries/dx_fatigue.sql">dx_fatigue.sql</a></p></td>
<td><p>2023-10</p></td>
<td><p>Levon Utidjian</p></td>
<td><p>vocab-based</p></td>
<td></td>
<td><p>ICD codes are included with and without decimal points, indicated by <code>cc_decimal_removal</code></p></td>
</tr>
<tr class="even">
<td><p>dx_gi_symptoms</p></td>
<td><p><a href="condition/dx_gi_symptoms.csv">dx_gi_symptoms</a></p></td>
<td><p>Diagnoses for gastrointestinal gi symptoms</p></td>
<td><p>ICD10, ICD10CM, ICD9CM, SNOMED</p></td>
<td><p><a href="sql_queries/dx_gi_symptoms.sql">dx_gi_symptoms.sql</a></p></td>
<td><p>2023-10</p></td>
<td><p>Levon Utidjian</p></td>
<td><p>vocab-based</p></td>
<td></td>
<td><p>ICD codes are included with and without decimal points, indicated by <code>cc_decimal_removal</code></p></td>
</tr>
<tr class="odd">
<td><p>dx_hair_loss</p></td>
<td><p><a href="condition/dx_hair_loss.csv">dx_hair_loss</a></p></td>
<td><p>Diagnoses for hair loss</p></td>
<td><p>ICD10, ICD10CM, ICD9CM, SNOMED</p></td>
<td><p><a href="sql_queries/dx_hair_loss.sql">dx_hair_loss.sql</a></p></td>
<td><p>2023-10</p></td>
<td><p>Levon Utidjian</p></td>
<td><p>vocab-based</p></td>
<td></td>
<td><p>ICD codes are included with and without decimal points, indicated by <code>cc_decimal_removal</code></p></td>
</tr>
<tr class="even">
<td><p>dx_headache</p></td>
<td><p><a href="condition/dx_headache.csv">dx_headache</a></p></td>
<td><p>Diagnoses for headache</p></td>
<td><p>ICD10, ICD10CM, ICD9CM, SNOMED</p></td>
<td><p><a href="sql_queries/dx_headache.sql">dx_headache.sql</a></p></td>
<td><p>2023-10</p></td>
<td><p>Levon Utidjian</p></td>
<td><p>vocab-based</p></td>
<td></td>
<td><p>ICD codes are included with and without decimal points, indicated by <code>cc_decimal_removal</code></p></td>
</tr>
<tr class="odd">
<td><p>dx_respiratory_infections</p></td>
<td><p><a href="condition/dx_respiratory_infections.csv">dx_respiratory_infections</a></p></td>
<td><p>Diagnoses for respiratory_infections</p></td>
<td><p>ICD10, ICD10CM, ICD9CM, SNOMED</p></td>
<td><p><a href="sql_queries/dx_respiratory_infections.sql">dx_respiratory_infections.sql</a></p></td>
<td><p>2023-10</p></td>
<td><p>Levon Utidjian</p></td>
<td><p>vocab-based</p></td>
<td></td>
<td><p>ICD codes are included with and without decimal points, indicated by <code>cc_decimal_removal</code></p></td>
</tr>
<tr class="even">
<td><p>dx_pregnancy</p></td>
<td><p><a href="condition/dx_pregnancy.csv">dx_pregnancy</a></p></td>
<td><p>Diagnoses for pregnancy</p></td>
<td><p>ICD10, ICD10CM, ICD9CM, SNOMED</p></td>
<td><p><a href="sql_queries/dx_pregnancy.sql">dx_pregnancy.sql</a></p></td>
<td><p>2023-10</p></td>
<td><p>Levon Utidjian</p></td>
<td><p>vocab-based</p></td>
<td></td>
<td><p>ICD codes are included with and without decimal points, indicated by <code>cc_decimal_removal</code></p></td>
</tr>
<tr class="odd">
<td><p>dx_pregnancy_icd_w_decimal</p></td>
<td><p><a href="https://atlassian.chop.edu/bitbucket/projects/PR/repos/preserve_codesets/browse/condition/dx_pregnancy_icd_w_decimal.csv">dx_pregnancy_icd_w_decimal</a></p></td>
<td><p>Diagnoses for pregnancy, restricted to ICD9CM/ICD10CM/ICD10 and without decimal removal</p></td>
<td><p>ICD10CM, ICD10, ICD9CM</p></td>
<td><p><a href="https://atlassian.chop.edu/bitbucket/projects/PR/repos/preserve_codesets/browse/r_scripts/dx_pregnancy_icd_w_decimal.R">dx_pregnancy_icd_w_decimal.R</a></p></td>
<td><p>2024-02</p></td>
<td><p>Levon Utidjian / Amy Goodwin Davies</p></td>
<td><p>vocab-based</p></td>
<td></td>
<td></td>
</tr>
<tr class="even">
<td><p>dx_dizziness</p></td>
<td><p><a href="condition/dx_dizziness.csv">dx_dizziness</a></p></td>
<td><p>Diagnoses for dizziness</p></td>
<td><p>ICD10, ICD10CM, ICD9CM</p></td>
<td><p><a href="https://atlassian.chop.edu/bitbucket/projects/PR/repos/preserve_codesets/browse/sql_queries/dx_dizziness.sql">dx_dizziness.sql</a></p></td>
<td><p>2024-04</p></td>
<td><p>Hanieh Razzaghi, Amy Goodwin Davies</p></td>
<td><p>vocab-based</p></td>
<td></td>
<td><p>ICD codes are included with and without decimal points, indicated by <code>cc_decimal_removal</code></p></td>
</tr>
<tr class="odd">
<td><p>dx_glomerular_icd</p></td>
<td><p><a href="condition/dx_glomerular_icd.csv">dx_glomerular_icd</a></p></td>
<td><p>ICD-only diagnoses for glomerular disease, derived from <a href="condition/dx_glomerular_disease.csv">dx_glomerular_disease</a> codeset</p></td>
<td><p>ICD9CM, ICD10, ICD10CM</p></td>
<td></td>
<td><p>2024-01</p></td>
<td><p>Levon Utidjian</p></td>
<td><p>vocab-based</p></td>
<td></td>
<td><p>ICD codes are included with and without decimal points, indicated by <code>cc_decimal_removal</code></p>
<p>Codeset category labels were determined either by mapping to the <a href="condition/dx_glomerular_snomed.csv">dx_glomerular_snomed</a> codeset or by a manual review by Chris and Michelle to recommend an appropriate label.</p></td>
</tr>
<tr class="even">
<td><p>dx_cakut_only</p></td>
<td><p><a href="condition/dx_cakut_only.csv">dx_cakut_only</a></p></td>
<td><p>Diagnoses for CAKUT. Differs from <a href="dx_cakut.csv">dx_cakut</a>, which also includes diagnoses for polycystic kidney disease PKD</p></td>
<td><p>ICD10, ICD10CM, ICD9CM, SNOMED</p></td>
<td><p><a href="sql_queries/dx_cakut_v2.sql">dx_cakut_v2.sql</a></p></td>
<td><p>2024-01</p></td>
<td><p>Levon Utidjian</p></td>
<td><p>vocab-based</p></td>
<td></td>
<td><p>ICD codes are included with and without decimal points, indicated by <code>cc_decimal_removal</code></p></td>
</tr>
<tr class="odd">
<td><p>dx_pkd</p></td>
<td><p><a href="condition/dx_pkd.csv">dx_pkd</a></p></td>
<td><p>Diagnoses for Polycystic Kidney Disease PKD</p></td>
<td><p>ICD10, ICD10CM, ICD9CM, SNOMED</p></td>
<td><p><a href="sql_queries/dx_pkd.sql">dx_pkd.sql</a></p></td>
<td><p>2024-01</p></td>
<td><p>Levon Utidjian</p></td>
<td><p>vocab-based</p></td>
<td></td>
<td><p>ICD codes are included with and without decimal points, indicated by <code>cc_decimal_removal</code></p></td>
</tr>
<tr class="even">
<td><p>dx_pregnancy_forrest</p></td>
<td><p><a href="condition/dx_pregnancy_forrest.csv">dx_pregnancy_forrest</a></p></td>
<td><p>Diagnoses indicating pregnancy, developed within the CER work</p></td>
<td><p>ICD9CM, ICD10, ICD10CM</p></td>
<td></td>
<td><p>2024-03</p></td>
<td><p>Chris Forrest</p></td>
<td><p>clinician-reviewed</p></td>
<td></td>
<td><p>ICD codes are included with and without decimal points, indicated by <code>cc_decimal_removal</code></p></td>
</tr>
<tr class="odd">
<td><p>dx_renal_artery_stenosis</p></td>
<td><p><a href="https://atlassian.chop.edu/bitbucket/projects/PR/repos/preserve_codesets/browse/condition/dx_renal_artery_stenosis.csv">dx_renal_artery_stenosis</a></p></td>
<td><p>Diagnoses indicating renal artery stenosis, developed within the CER work</p></td>
<td><p>ICD9CM, ICD10CM</p></td>
<td><p><a href="https://atlassian.chop.edu/bitbucket/projects/PR/repos/preserve_codesets/browse/sql_queries/dx_renal_artery_stenosis.sql">dx_renal_artery_stenosis.sql</a></p></td>
<td><p>2024-04</p></td>
<td><p>Chris Forrest</p></td>
<td><p>clinician-reviewed</p></td>
<td></td>
<td><p>CD codes are included with and without decimal points, indicated by <code>cc_decimal_removal</code></p></td>
</tr>
<tr class="even">
<td><p>dx_el_bp</p></td>
<td><p><a href="https://atlassian.chop.edu/bitbucket/projects/PR/repos/preserve_codesets/browse/condition/dx_el_bp.csv">dx_el_bp</a></p></td>
<td><p>Diagnoses for elevated blood pressure distinct from hypertension</p></td>
<td><p>ICD9CM, ICD10CM</p></td>
<td><p><a href="https://atlassian.chop.edu/bitbucket/projects/PR/repos/preserve_codesets/browse/sql_queries/dx_el_bp.sql">dx_el_bp.sql</a></p></td>
<td><p>2024-04</p></td>
<td><p>Amy Goodwin Davies</p></td>
<td><p>vocab-based</p></td>
<td></td>
<td><p>ICD codes are included with and without decimal points, indicated by <code>cc_decimal_removal</code></p></td>
</tr>
<tr class="odd">
<td><p>dx_renal_related</p></td>
<td><p><a href="https://atlassian.chop.edu/bitbucket/projects/PR/repos/preserve_codesets/browse/condition/dx_renal_related.csv">dx_renal_related</a></p></td>
<td><p>Renal-related diagnoses</p></td>
<td><p>ICD10CM</p></td>
<td></td>
<td><p>2024</p></td>
<td><p>Pediatric nephrologist team including Zubin Modi &amp; Michelle Denburg collaborating with USRDS/NIH</p></td>
<td><p>clinician-reviewed</p></td>
<td></td>
<td><p>ICD codes are included with and without decimal points, indicated by <code>cc_decimal_removal</code></p>
<p>This codeset was shared with the PRESERVE study team in <a href="condition/dx_renal_related_original.xlsx">xlsx format</a> by Zubin Modi 2024-04-25</p></td>
</tr>
</tbody>
</table>

## Demographic

Notes on usage in PCORnet:

-   Tables: DEMOGRAPHIC

-   Select the FIELD_NAME from the TABLE_NAME specified in the valueset

Codeset structure:

For fields, use the following fields from the PCORNET CDM specifications:

| TABLE_NAME | FIELD_NAME | RDBMS_DATA_TYPE | SAS_DATA_TYPE | DATA_FORMAT | REPLICATED_FIELD | UNIT_OF_MEASURE | VALUESET | FIELD_DEFINITION |
|------------|------------|-----------------|---------------|-------------|------------------|-----------------|----------|-------------------|
|            |            |                 |               |             |                  |                 |          |                  |

Codesets and valuesets:

| Name | Codeset link | Description | Vocabularies | SQL link | Date developed | Developer | Status | Date finalized | Other |
|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|
|      |              |             |              |          |                |           |        |                |       |

## Drug

Notes on usage in PCORnet:

-   **Tables:** MED_ADMIN (administrations), PRESCRIBING

-   Use distinct `concept_code` and `pcornet_vocabulary_id` columns

-   **For administrations:** Join the `concept_code` column and the `pcornet_vocabulary_id` column in the codeset to the `MEDADMIN_CODE` column and `MEDADMIN_TYPE` column in the MED_ADMIN table, respectively

-   **For prescriptions:** Join the `concept_code` column in the codeset to the `RXNORM_CUI` column in the PRESCRIBING table

Notes on usage in PEDSnet:

-   Tables: drug_exposure

-   Use distinct `concept_id` and `vocabulary_id` columns

Codeset structure:

| concept_id | concept_code | concept_name | vocabulary_id | pcornet_vocabulary_id |
|------------|--------------|--------------|---------------|-----------------------|
|            |              |              |               |                       |

where `pcornet_vocabulary_id` is an acceptable value according to the supported values in the `VALUESET_ITEM` column below:


| FIELD_NAME    | VALUESET_ITEM (pcornet_vocabulary_id) | VALUESET_ITEM_DESCRIPTOR |
|---------------|---------------------------------------|--------------------------|
| MEDADMIN_TYPE | ND                                    | ND=NDC                   |
| MEDADMIN_TYPE | RX                                    | RX=RXNORM                |


Codesets and valuesets:

| Name                   | Codeset link                                              | Description                                                                                                                                                                                                                                                | Vocabularies                  | SQL link                                                         | Date developed | Developer           | Status      | Date finalized | Other           |
|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|
| rx_ace_inhibitor       | [rx_ace_inhibitor](drug/rx_ace_inhibitor.csv)             | Medication codeset for the following ingredients: Benazepril, Captopril, Enalapril, Fosinopril, Lisinopril, Moexipril, Periondopril, Quinapril,Ramipril, Trandolapril                                                                                      | NDC, RxNorm, RxNorm Extension | [rx_ace_inhibitor.sql](sql_queries/rx_ace_inhibitor.sql)         | 2021-11        | Levon Utidjian      | vocab-based |                | combos included |
| rx_arb                 | [rx_arb](drug/rx_arb.csv)                                 | Medication codeset for the following ingredients: Azilsartan, Candesartan,Eprosartan,Irbesartan,Losartan,Olmesartan,Telmisartan, Valsartan                                                                                                                 | NDC, RxNorm, RxNorm Extension | [rx_arb.sql](sql_queries/rx_arb.sql)                             | 2021-11        | Levon Utidjian      | vocab-based |                | combos included |
| rx_bb                  | [rx_bb](drug/rx_bb.csv)                                   | Medication codeset for the following ingredients:, Acebutolol, Atenolol, Betaxolol,Bisoprolol, Carteolol, Carvediol, Labetalol, Metoprolol, Nadolol, Nebivolol, Penbutolol, Pindolol, Propanolol, Sotalol, Timolol                                         | NDC, RxNorm, RxNorm Extension | [rx_bb.sql](sql_queries/rx_bb.sql)                               | 2021-11        | Levon Utidjian      | vocab-based |                | combos included |
| rx_ccb                 | [rx_ccb](drug/rx_ccb.csv)                                 | Medication codeset for the following ingredients: Amlodipine, Diltiazem, Felodipine, Isradipine, Nicardipine, Nifedipine, Nisoldipine ,Verapamil                                                                                                           | NDC, RxNorm, RxNorm Extension | [rx_ccb.sql](sql_queries/rx_ccb.sql)                             | 2021-11        | Levon Utidjian      | vocab-based |                | combos included |
| rx_loop_diuretic       | [rx_loop_diuretic](drug/rx_loop_diuretic.csv)             | Medication codeset for the following ingredients: Furosemide, Bumetanide, Ethacrynic acid, Torsemide                                                                                                                                                       | NDC, RxNorm, RxNorm Extension | [rx_loop_diuretic.sql](sql_queries/rx_loop_diuretic.sql)         | 2021-11        | Levon Utidjian      | vocab-based |                | combos included |
| rx_thiazide            | [rx_thiazide](drug/rx_thiazide.csv)                       | Medication codeset for the following ingredients: Chlorothiazide, Chlorthalidone, Hydrochlorothiazide, Indapamide, Metolazone                                                                                                                              | NDC, RxNorm, RxNorm Extension | [rx_thiazide.sql](sql_queries/rx_thiazide.sql)                   | 2021-11        | Levon Utidjian      | vocab-based |                | combos included |
| rx_anesthesia          | [rx_anesthesia](drug/rx_anesthesia.csv)                   | General anesthesia: Propofol (intravenous), Etomidate (intravenous), Ketamine (intravenous), Midazolam (intravenous), Fentanyl (intravenous), Nitrous oxide (inhaled), Sevoflurane (inhaled), Desflurane (inhaled), Isoflurane (inhaled)                   | RxNorm, RxNorm Extension      | [rx_anesthesia.sql](sql_queries/rx_anesthesia.sql)               | 2022-02        | Kimberley Dickinson | vocab-based |                |                 |
| rx_fludrocortisone     | [rx_fludrocortisone](drug/rx_fludrocortisone.csv)         | Oral fludrocortisone                                                                                                                                                                                                                                       | RxNorm, RxNorm Extension      |                                                                  | 2022-02        | Kimberley Dickinson | vocab-based |                |                 |
| rx_deflazacort         | [rx_deflazacort](drug/rx_deflazacort.csv)                 | Oral deflazacort                                                                                                                                                                                                                                           | RxNorm, RxNorm Extension      |                                                                  | 2022-02        | Kimberley Dickinson | vocab-based |                |                 |
| rx_nephrotoxic_chemo   | [rx_nephrotoxic_chemo](drug/rx_nephrotoxic_chemo.csv)     | All RxNorm and NDC descendants of ATC classes for nephrotoxic chemotherapies listed in [Nicolaysen 2020](https://doi.org/10.1053/j.ackd.2019.08.005) and in addition cabroplatin, melphalan, carmustine, lomustine, and azacitidine per Charles Bailey, MD | NDC, RxNorm, RxNorm Extension | [rx_nephrotoxic_chemo.sql](sql_queries/rx_nephrotoxic_chemo.sql) | 2022-11        | Amy Goodwin Davies  | vocab-based |                |                 |
| rx_antineoplastics     | [rx_antineoplastics](drug/rx_antineoplastics.csv)         | All RxNorm and NDC descendants of ATC classes for antineoplastics                                                                                                                                                                                          | NDC, RxNorm, RxNorm Extension | [rx_antineoplastics.sql](sql_queries/rx_antineoplastics.sql)     | 2022-12        | Kaleigh Wieand      | vocab-based |                |                 |
| rx_chemo               | [rx_chemo](drug/rx_chemo.csv)                             | Chemotherapy drugs                                                                                                                                                                                                                                         | NDC, RxNorm, RxNorm Extension | [rx_chemo.sql](sql_queries/rx_chemo.sql)                         | 2023-01        | Levon Utidjian      | vocab-based |                |                 |
| rx_ace_inhibitor_no_iv | [rx_ace_inhibitor_no_iv](drug/rx_ace_inhibitor_no_iv.csv) | A subset of [rx_ace_inhibitor](drug/rx_ace_inhibitor.csv) with all IV and injectable drugs removed                                                                                                                                                         | NDC, RxNorm, RxNorm Extension |                                                                  | 2024-05        | Kaleigh Wieand      | vocab-based |                |                 |
| rx_arb_no_iv           | [rx_arb_no_iv](drug/rx_arb_no_iv.csv)                     | A subset of [rx_arb](drug/rx_arb.csv) with all IV and injectable drugs removed                                                                                                                                                                             | NDC, RxNorm, RxNorm Extension |                                                                  | 2024-05        | Kaleigh Wieand      | vocab-based |                |                 |
| rx_bb_no_iv            | [rx_bb_no_iv](drug/rx_bb_no_iv.csv)                       | A subset of [rx_bb](drug/rx_bb.csv) with all IV and injectable drugs removed                                                                                                                                                                               | NDC, RxNorm, RxNorm Extension |                                                                  | 2024-05        | Kaleigh Wieand      | vocab-based |                |                 |
| rx_ccb_no_iv           | [rx_ccb_no_iv](drug/rx_ccb_no_iv.csv)                     | A subset of [rx_ccb](drug/rx_ccb.csv) with all IV and injectable drugs removed                                                                                                                                                                             | NDC, RxNorm, RxNorm Extension |                                                                  | 2024-05        | Kaleigh Wieand      | vocab-based |                |                 |
| rx_thiazide_no_iv      | [rx_thiazide_no_iv](drug/rx_thiazide_no_iv.csv)           | A subset of [rx_thiazide](drug/rx_thiazide.csv) with all IV and injectable drugs removed                                                                                                                                                                   | NDC, RxNorm, RxNorm Extension |                                                                  | 2024-05        | Kaleigh Wieand      | vocab-based |                |                 |

## Measurement

Notes on usage in PCORnet:

-   **Tables:** LAB_RESULT_CM, OBS_CLIN, VITAL

-   Use distinct `concept_code` and `pcornet_vocabulary_id` columns

-   **For fields (e.g. in VITAL)**: select the FIELD_NAME from the TABLE_NAME specified in the valueset

-   **For lab results:** Join the `concept_code` column in the codeset to the `LAB_LOINC` column in the LAB_RESULT_CDM table

Notes on usage in PEDSnet:

-   Tables: measurement

-   Use distinct `concept_id` and `vocabulary_id` columns

Codeset structure:

| concept_id | concept_code | concept_name | vocabulary_id | pcornet_vocabulary_id |
|------------|--------------|--------------|---------------|-----------------------|
|            |              |              |               |                       |

where `pcornet_vocabulary_id` should always be LC for LOINC

For fields, use the following fields from the PCORNET CDM specifications:


| TABLE_NAME | FIELD_NAME | RDBMS_DATA_TYPE | SAS_DATA_TYPE | DATA_FORMAT | REPLICATED_FIELD | UNIT_OF_MEASURE | VALUESET | FIELD_DEFINITION |
|------------|------------|-----------------|---------------|-------------|------------------|-----------------|----------|-------------------|
|            |            |                 |               |             |                  |                 |          |                  |

Codesets and valuesets:

| Name                             | Codeset link                                                              | Description                                                         | Vocabularies        | SQL link                                                                 | Date developed | Developer          | Status      | Date finalized | Other                                                                                                 |
|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|
| Height (field)                   | [anthro_ht_field](measurement/anthro_ht_field.csv)                        | Field of VITAL table                                                | NA                  | NA                                                                       | NA             | NA                 | vocab-based |                |                                                                                                       |
| Weight (field)                   | [anthro_wt_field](measurement/anthro_wt_field.csv)                        | Field of VITAL table                                                | NA                  | NA                                                                       | NA             | NA                 | vocab-based |                |                                                                                                       |
| Original BMI (field)             | [anthro_original_bmi_field](measurement/%5Banthro_original_bmi_field.csv) | Field of VITAL table                                                | NA                  | NA                                                                       | NA             | NA                 | vocab-based |                |                                                                                                       |
| Systolic Blood Pressure (field)  | [vital_systolic_field](measurement/vital_systolic_field.csv)              | Field of VITAL table                                                | NA                  | NA                                                                       | NA             | NA                 | vocab-based |                |                                                                                                       |
| Diastolic Blood Pressure (field) | [vital_diastolic_field](measurement/vital_diastolic_field.csv)            | Field of VITAL table                                                | NA                  | NA                                                                       | NA             | NA                 | vocab-based |                |                                                                                                       |
| Serum creatinine                 | [lab_serum_creatinine](measurement/lab_serum_creatinine.csv)              | Serum creatinine measurements                                       | LOINC               | [lab_serum_creatinine.sql](sql_queries/lab_serum_creatinine.sql)         | 2021-10        | Levon Utidjian     | vocab-based |                |                                                                                                       |
| Serum cystatin                   | [lab_serum_cystatin](measurement/lab_serum_cystatin.csv)                  | Serum cystatin measurements                                         | LOINC               | [lab_serum_cystatin.sql](sql_queries/lab_serum_cystatin.sql)             | 2021-11        | Levon Utidjian     | vocab-based |                |                                                                                                       |
| Urine creatinine                 | [lab_urine_creatinine](measurement/lab_urine_creatinine.csv)              | Urine creatinine measurements                                       | LOINC               | [lab_urine_creatinine.sql](sql_queries/lab_urine_creatinine.sql)         | 2021-11        | Levon Utidjian     | vocab-based |                |                                                                                                       |
| Urine protein (qualitative)      | [lab_urine_protein_qual](measurement/lab_urine_protein_qual.csv)          | Urine protein qualitative                                           | LOINC               | [lab_urine_protein_qual.sql](sql_queries/lab_urine_protein_qual.sql)     | 2021-11        | Levon Utidjian     | vocab-based |                |                                                                                                       |
| Urine protein (quantitative)     | [lab_urine_protein_quant](measurement/lab_urine_protein_quant.csv)        | Urine protein quantitative                                          | LOINC               | [lab_urine_protein_quant.sql](sql_queries/lab_urine_protein_quant.sql)   | 2021-11        | Levon Utidjian     | vocab-based |                |                                                                                                       |
| lab_serum_hemoglobin             | [lab_serum_hemoglobin](measurement/lab_serum_hemoglobin.csv)              | Serum hemoglobin measurements                                       | LOINC               | [lab_serum_hemoglobin.sql](sql_queries/lab_serum_hemoglobin.sql)         | 2022-03        | Levon Utidjian     | vocab-based |                |                                                                                                       |
| lab_serum_potassium              | [lab_serum_potassium](measurement/lab_serum_potassium.csv)                | Serum potassium measurements                                        | LOINC               | [serum_potassium.sql](sql_queries/serum_potassium.sql)                   | 2022-03        | Levon Utidjian     | vocab-based |                |                                                                                                       |
| lab_serum_wbc                    | [lab_serum_wbc](measurement/lab_serum_wbc.csv)                            | Serum white blood cell count measurments                            | LOINC               | [lab_serum_wbc.sql](sql_queries/lab_serum_wbc.sql)                       | 2022-03        | Levon Utidjian     | vocab-based |                |                                                                                                       |
| lab_alanine_transaminase         | [lab_alanine_transaminase](measurement/lab_alanine_transaminase.csv)      | Alanine transaminase measurments                                    | LOINC               | [lab_alanine_transaminase.sql](sql_queries/lab_alanine_transaminase.sql) | 2022-03        | Levon Utidjian     | vocab-based |                |                                                                                                       |
| lab_serum_bicarbonate            | [lab_serum_bicarbonate](measurement/lab_serum_bicarbonate.csv)            | Serum bicarbonate measurments                                       | LOINC               | [lab_serum_bicarbonate.sql](sql_queries/lab_serum_bicarbonate.sql)       | 2022-04        | Levon Utidjian     | vocab-based |                |                                                                                                       |
| bp_method                        | [bp_method](measurement/bp_method.csv)                                    | Blood pressure methods                                              | LOINC, CPT4, SNOMED | [bp_method.sql](sql_queries/bp_method.sql)                               | 2023-01        | Levon Utidjian     | vocab-based |                | Further exploration is required to determine whether and where in the PCORnet CDM this codes are used |
| meas_birth_weight                | [meas_birth_weight](measurement/meas_birth_weight.csv)                    | Blood pressure methods                                              | LOINC               | [meas_birth_weight.sql](sql_queries/meas_birth_weight.sql)               | 2023-08        | Amy Goodwin Davies | vocab-based |                | Requested LOINC code for ETL for project                                                              |
| meas_gestational_age             | [meas_gestational_age](measurement/meas_gestational_age.csv)              | Blood pressure methods                                              | LOINC               | [meas_gestational_age.sql](sql_queries/meas_gestational_age.sql)         | 2023-08        | Amy Goodwin Davies | vocab-based |                | Requested LOINC code for ETL for project                                                              |
| lab_urine_albumin                | [lab_urine_albumin](measurement/lab_urine_albumin.csv)                    | Urine albumin measurements (preliminary)                            | LOINC               | [lab_urine_albumin.sql](sql_queries/lab_urine_albumin.sql)               | 2024-01        | Amy Goodwin Davies | vocab-based |                | Preliminary urine albumin codeset                                                                     |
| lab_uacr                         | [lab_uacr](measurement/lab_uacr.csv)                                      | Urine-albumin-to-creatinine ratio (UACR) measurements (preliminary) | LOINC               | [lab_urine_albumin.sql](sql_queries/lab_urine_albumin.sql)               | 2024-01        | Amy Goodwin Davies | vocab-based |                | Preliminary Urine-albumin-to-creatinine ratio (UACR) codeset                                          |
|                                  |                                                                           |                                                                     |                     |                                                                          |                |                    |             |                |                                                                                                       |

## Procedure

Notes on usage in PCORnet:

-   **Tables:** PROCEDURES

-   Use distinct `concept_code` and `pcornet_vocabulary_id` columns

-   Join the `concept_code` column and the `pcornet_vocabulary_id` column in the codeset to the `PX` column and `PX_TYPE` column in the PROCEDURES table, respectively

Notes on usage in PEDSnet:

-   Tables: procedure_occurrence

-   Use distinct `concept_id` and `vocabulary_id` columns

Codeset structure:


| concept_id | concept_code | concept_name | vocabulary_id | pcornet_vocabulary_id | cc_decimal_removal|
|------------|--------------|--------------|---------------|-----------------------|-------------------------------------------------------------|
|            |              |              |               |                       |flag for whether decimal has been removed from `concept_code`|


where `pcornet_vocabulary_id` is an acceptable value according to supported vocabularies in the `VALUESET_ITEM` column below (please note leading zero for "09"):


| FIELD_NAME    | VALUESET_ITEM (pcornet_vocabulary_id) | VALUESET_ITEM_DESCRIPTOR |
|---------------|---------------------------------------|--------------------------|
| PX_TYPE       | 09                                    | 09 = ICD-9-CM            |
| PX_TYPE       | 10                                    | 10 = ICD-10-PCS          |
| PX_TYPE       | 11                                    | 11 = ICD-11-PCS          |
| PX_TYPE       | CH                                    | CH = CPT or HCPCS        |
| PX_TYPE       | LC                                    | LC = LOINC               |
| PX_TYPE       | ND                                    | ND = NDC                 |
| PX_TYPE       | RE                                    | RE = Revenue             |

Codesets and valuesets:

| Name                 | Codeset link                                               | Description                                                                                                                                                 | Vocabularies                            | SQL link                                                         | Date developed | Developer                           | Status                     | Date finalized | Other                                                                                                                                                                                                                                                      |
|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|
| px_kidney_transplant | [px_kidney_transplant](procedure/px_kidney_transplant.csv) | Kidney transplant procedure codes                                                                                                                           | CPT4, HCPCS, ICD10PCS, ICD9Proc, SNOMED | [px_kidney_transplant.sql](sql_queries/px_kidney_transplant.sql) | 2021-11        | Levon Utidjian                      | vocab-based                |                | ICD codes are included with and without decimal points, indicated by `cc_decimal_removal`, indicated by `cc_decimal_removal`                                                                                                                               |
| px_kidney_dialysis   | [px_kidney_dialysis](procedure/px_kidney_dialysis.csv)     | Kidney dialysis procedure codes.Broader, more sensitive codeset (compared to px_chronic_dialysis)                                                           | CPT4, HCPCS, ICD10PCS, ICD9Proc, SNOMED | [px_kidney_dialysis.sql](sql_queries/px_kidney_dialysis.sql)     | 2021-11        | Levon Utidjian                      | vocab-based                |                | ICD codes are included with and without decimal points, indicated by `cc_decimal_removal`, indicated by `cc_decimal_removal`                                                                                                                               |
| px_chronic_dialysis  | [px_chronic_dialysis](procedure/px_chronic_dialysis.csv)   | ESRD kidney dialysis CPT procedure codes identified by CRO WG. Narrower, more specific codeset (compared to px_kidney_dialysis)                             | CPT4                                    |                                                                  | 2022-06        | CRO WG                              | clinician-reviewed         |                |                                                                                                                                                                                                                                                            |
| px_abpm              | [px_abpm](procedure/px_abpm.csv)                           | CPT4 Procedures codes for "ambulatory blood pressure monitoring, utilizing report-generating software, automated, worn continuously for 24 hours or longer" | CPT4                                    | [px_abpm.sql](sql_queries/px_abpm.sql)                           | 2022-06        | Amy Goodwin Davies / Levon Utidjian | Provided by ABPM workgroup |                |                                                                                                                                                                                                                                                            |
| px_kidney_biopsy     | [px_kidney_biopsy](procedure/px_kidney_biopsy.csv)         | Kidney biopsy procedure codes                                                                                                                               | CPT4, HCPCS, ICD9Proc, ICD10PCS, SNOMED | [px_kidney_biopsy.sql](sql_queries/px_kidney_biopsy.sql)         | 2023-04        | Levon Utidjian                      | vocab-based                |                | Limited excision/drainage/extraction to 'diagnostic' qualifiers since those are most appropriate for biopsy per CMS guidance. ICD codes are included with and without decimal points, indicated by `cc_decimal_removal`, indicated by `cc_decimal_removal` |

## Visit Related

Notes on usage in PCORnet:

-   Tables: ENCOUNTER

-   Join the `VALUESET_ITEM` in the codeset to the field specified in the `FIELD_NAME` column of the codeset in the ENCOUNTER table

Codeset structure:

For valuesets, use the following fields from the PCORNET CDM

| TABLE_NAME | FIELD_NAME    | VALUESET_ITEM (pcornet_vocabulary_id) | VALUESET_ITEM_DESCRIPTOR |
|------------|---------------|---------------------------------------|--------------------------|
|            |               |                                       |                          |


Codesets and valuesets:

| Name                    | Codeset link                                                       | Description                                      | Vocabularies      | SQL link | Date developed | Developer           | Status      | Date finalized                    | Other |
|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|
| Nephrology provider     | [nephrology_spec_prov](visit/nephrology_spec_prov.csv)             | Nephrology provider                              | PCORNET Value Set |          | 2021-09        | Amy Goodwin Davies  | vocab-based | based on PCORnet CDM v6.0 2021-04 |       |
| Nephrology facility     | [nephrology_spec_fac](visit/nephrology_spec_fac.csv)               | Nephrology facility                              | PCORNET Value Set |          | 2022-11        | Amy Goodwin Davies  | vocab-based | based on PCORnet CDM v6.0 2021-11 |       |
| Cardiology facility     | [cardiology_spec_fac](visit/cardiology_spec_fac.csv)               | Cardiology facility                              | PCORNET Value Set |          | 2021-09        | Amy Goodwin Davies  | vocab-based | based on PCORnet CDM v6.0 2021-04 |       |
| Cardiology provider     | [cardiology_spec_prov](visit/cardiology_spec_prov.csv)             | Cardiology provider                              | PCORNET Value Set |          | 2021-10        | Amy Goodwin Davies  | vocab-based | based on PCORnet CDM v6.0 2021-04 |       |
| Oncology facility       | [oncology_spec_fac](visit/oncology_spec_fac.csv)                   | Oncology facility                                | PCORNET Value Set |          | 2021-10        | Amy Goodwin Davies  | vocab-based | based on PCORnet CDM v6.0 2021-04 |       |
| Oncology provider       | [oncology_spec_prov](visit/oncology_spec_prov.csv)                 | Oncology provider                                | PCORNET Value Set |          | 2021-10        | Amy Goodwin Davies  | vocab-based | based on PCORnet CDM v6.0 2021-04 |       |
| Primary care facility   | [primary_care_spec_fac](visit/primary_care_spec_fac.csv)           | Oncology facility                                | PCORNET Value Set |          | 2021-10        | Amy Goodwin Davies  | vocab-based | based on PCORnet CDM v6.0 2021-04 |       |
| Primary care provider   | [primary_care_spec_prov](visit/primary_care_spec_prov.csv)         | Primary care provider                            | PCORNET Value Set |          | 2021-10        | Amy Goodwin Davies  | vocab-based | based on PCORnet CDM v6.0 2021-04 |       |
| Urology facility        | [urology_spec_fac](visit/urology_spec_fac.csv)                     | Urology facility                                 | PCORNET Value Set |          | 2021-10        | Amy Goodwin Davies  | vocab-based | based on PCORnet CDM v6.0 2021-04 |       |
| Urology provider        | [urology_spec_prov](visit/urology_spec_prov.csv)                   | Urology provider                                 | PCORNET Value Set |          | 2021-09        | Amy Goodwin Davies  | vocab-based | based on PCORnet CDM v6.0 2021-04 |       |
| Emergency Visits        | [emergency_visits](visit/emergency_visits.csv)                     | Emergency and Emergency-\>Inpatient Visits       | PCORnet Value Set |          | 2021-09        | Kimberley Dickinson | vocab-based | based on PCORnet CDM v6.0 2021-04 |       |
| Outpatient Visits       | [outpatient_visits](visit/outpatient_visits.csv)                   | Outpatient Visits                                | PCORnet Value Set |          | 2021-09        | Kimberley Dickinson | vocab-based | based on PCORnet CDM v6.0 2021-04 |       |
| Inpatient Visits        | [inpatient_visits](visit/inpatient_visits.csv)                     | Inpatient and Emergency-\>Inpatient Visits       | PCORnet Value Set |          | 2021-09        | Kimberley Dickinson | vocab-based | based on PCORnet CDM v6.0 2021-04 |       |
| Hematology facility     | [hematology_spec_fac](visit/hematology_spec_fac.csv)               | Hematology facility                              | PCORNET Value Set |          | 2023-08        | Amy Goodwin Davies  | vocab-based | based on PCORnet CDM v6.0 2021-04 |       |
| Hematology provider     | [hematology_spec_prov](visit/hematology_spec_prov.csv)             | Hematology provider                              | PCORNET Value Set |          | 2023-08        | Amy Goodwin Davies  | vocab-based | based on PCORnet CDM v6.0 2021-04 |       |
| Face-to-face encounters | [prs_face_to_face_enc_types](visit/prs_face_to_face_enc_types.csv) | PRESERVE definition of "face to face" encounters | PCORNET Value Set |          | 2023-12        | Amy Goodwin Davies  | vocab-based | based on PCORnet CDM v6.1 2023-04 |       |
