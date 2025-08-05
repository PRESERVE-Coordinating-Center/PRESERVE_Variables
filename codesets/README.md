# PRESERVE Codesets

This directory contains codesets for the PRESERVE project. Codesets have been constructed with both the PEDSnet and PCORnet common data models as targets. Please read "notes on usage" for each target CDM. We also include what PCORnet terms valuesets in this codeset repo.

Navigate to a domain:
- [Conditions](https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets#condition)
- [Demographics](https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets#demographic)
- [Drugs](https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets#drug)
- [Measurements](https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets#measurement)
- [Procedures](https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets#procedure)
- [Visit & Specialty](https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets#visit-related)

## Condition

---
### Notes on usage

<ins>PCORnet:</ins>

-   Tables: DIAGNOSIS, CONDITION

-   Use distinct `concept_code` and `pcornet_vocabulary_id` columns

-   Where `concept_code` is included with and without decimal point removal, adjust for potential double counting in analyses

-   Join the `concept_code` column and the `pcornet_vocabulary_id` column in the codeset to the `DX` column and `DX_TYPE` column in the DIAGNOSIS table, respectively

<ins>PEDSnet</ins>:

-   Tables: condition_occurrence

-   Use distinct `concept_id` and `vocabulary_id` columns
---

Codeset structure:

| concept_id | concept_code | concept_name | vocabulary_id | pcornet_vocabulary_id | cc_decimal_removal                                            |
|------------|--------------|--------------|---------------|-----------------------|---------------------------------------------------------------|
|            |              |              |               |                       | flag for whether decimal has been removed from `concept_code` |

where `pcornet_vocabulary_id` is an acceptable value according to the supported values in the `VALUESET_ITEM` column below (please note leading zero for "09"):

| FIELD_NAME    | VALUESET_ITEM (pcornet_vocabulary_id) | VALUESET_ITEM_DESCRIPTOR |
|---------------|---------------------------------------|--------------------------|
| DX_TYPE       | 09                                    | 09-ICD-9-CM              |
| DX_TYPE       | 10                                    | 10-ICD-10-CM             |
| DX_TYPE       | 11                                    | 11-ICD-11-CM             |
| DX_TYPE       | SM                                    | SM-SNOMED CT             |

Codesets and valuesets:

<table>
<thead>
<tr class-"header">
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
<td><p><a href="https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/condition/dx_ckd_stage23.csv">dx_ckd_stage23</a></p></td>
<td><p>Diagnoses for chronic kidney disease stages 2 and 3</p></td>
<td><p>ICD10, ICD10CM, ICD9CM, SNOMED</p></td>
<td><p><a href="https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/sql_queries/dx_ckd_stage23.sql">dx_ckd_stage23.sql</a></p></td>
<td><p>2021-11</p></td>
<td><p>Levon Utidjian</p></td>
<td><p>vocab-based</p></td>
<td></td>
<td><p>ICD codes are included with and without decimal points, indicated by <code>cc_decimal_removal</code></p></td>
</tr>
<tr class-"even">
<td><p>dx_kidney_transplant</p></td>
<td><p><a href="https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/condition/dx_kidney_transplant.csv">dx_kidney_transplant</a></p></td>
<td><p>Kidney transplant diagnosis codes</p></td>
<td><p>ICD10, ICD10CM, ICD9CM, SNOMED</p></td>
<td><p><a href="https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/sql_queries/dx_kidney_transplant.sql">dx_kidney_transplant.sql</a></p></td>
<td><p>2021-11</p></td>
<td><p>Levon Utidjian</p></td>
<td><p>vocab-based</p></td>
<td></td>
<td><p>ICD codes are included with and without decimal points, indicated by <code>cc_decimal_removal</code></p></td>
</tr>
<tr class="odd">
<td><p>dx_kidney_dialysis</p></td>
<td><p><a href="https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/condition/dx_kidney_dialysis.csv">dx_kidney_dialysis</a></p></td>
<td><p>Kidney dialysis diagnosis codes</p></td>
<td><p>ICD10, ICD10CM, ICD9CM, SNOMED</p></td>
<td><p><a href="https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/sql_queries/dx_kidney_dialysis.sql">dx_kidney_dialysis.sql</a></p></td>
<td><p>2021-11</p></td>
<td><p>Levon Utidjian</p></td>
<td><p>vocab-based</p></td>
<td></td>
<td><p>ICD codes are included with and without decimal points, indicated by <code>cc_decimal_removal</code></p></td>
</tr>
<tr class-"even">
<td><p>dx_hypertension</p></td>
<td><p><a href="https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/condition/dx_hypertension.csv">dx_hypertension</a></p></td>
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
<td><p><a href="https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/condition/dx_asthma.csv">dx_asthma</a></p></td>
<td><p>Asthma diagnosis codes</p></td>
<td><p>ICD10, ICD10CM, ICD9CM, SNOMED</p></td>
<td><p><a href="https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/sql_queries/dx_asthma.sql">dx_asthma.sql</a></p></td>
<td><p>2022-03</p></td>
<td><p>Levon Utidjian</p></td>
<td><p>vocab-based</p></td>
<td></td>
<td><p>ICD codes are included with and without decimal points, indicated by <code>cc_decimal_removal</code></p></td>
</tr>
<tr class-"even">
<td><p>dx_pericarditis</p></td>
<td><p><a href="https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/condition/dx_pericarditis.csv">dx_pericarditis</a></p></td>
<td><p>Pericarditis diagnosis codes</p></td>
<td><p>ICD10, ICD10CM, ICD9CM, SNOMED</p></td>
<td><p><a href="https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/sql_queries/dx_pericarditis.sql">dx_pericarditis.sql</a></p></td>
<td><p>2022-03</p></td>
<td><p>Levon Utidjian</p></td>
<td><p>vocab-based</p></td>
<td></td>
<td><p>ICD codes are included with and without decimal points, indicated by <code>cc_decimal_removal</code></p></td>
</tr>
<tr class="odd">
<td><p>dx_ckd_allstages</p></td>
<td><p><a href="https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/condition/dx_ckd_allstages.csv">dx_ckd_allstages</a></p></td>
<td><p>Diagnoses for all chronic kidney disease stages</p></td>
<td><p>ICD10, ICD10CM, ICD9CM, SNOMED</p></td>
<td><p><a href="https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/sql_queries/dx_ckd_allstages.sql">dx_ckd_allstages.sql</a></p></td>
<td><p>2022-03</p></td>
<td><p>Levon Utidjian</p></td>
<td><p>vocab-based</p></td>
<td></td>
<td><p>ICD codes are included with and without decimal points, indicated by <code>cc_decimal_removal</code></p></td>
</tr>
<tr class-"even">
<td><p>dx_nocturnal_enuresis</p></td>
<td><p><a href="https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/condition/dx_nocturnal_enuresis.csv">dx_nocturnal_enuresis</a></p></td>
<td><p>Diagnoses for nocturnal enuresis</p></td>
<td><p>ICD10, ICD10CM, ICD9CM, SNOMED</p></td>
<td><p><a href="https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/sql_queries/dx_nocturnal_enuresis.sql">dx_nocturnal_enuresis.sql</a></p></td>
<td><p>2022-03</p></td>
<td><p>Levon Utidjian</p></td>
<td><p>vocab-based</p></td>
<td></td>
<td><p>ICD codes are included with and without decimal points, indicated by <code>cc_decimal_removal</code></p></td>
</tr>
<tr class="odd">
<td><p>dx_stomatitis</p></td>
<td><p><a href="https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/condition/dx_stomatitis.csv">dx_stomatitis</a></p></td>
<td><p>Diagnoses for stomatitis</p></td>
<td><p>ICD10, ICD10CM, ICD9CM, SNOMED</p></td>
<td><p><a href="https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/sql_queries/dx_stomatitis.sql">dx_stomatitis.sql</a></p></td>
<td><p>2022-03</p></td>
<td><p>Levon Utidjian</p></td>
<td><p>vocab-based</p></td>
<td></td>
<td><p>ICD codes are included with and without decimal points, indicated by <code>cc_decimal_removal</code></p></td>
</tr>
<tr class-"even">
<td><p>dx_glomerular_disease</p></td>
<td><p><a href="https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/condition/dx_glomerular_disease.csv">dx_glomerular_disease</a></p></td>
<td><p>Diagnoses for glomerular disease</p></td>
<td><p>ICD10, ICD10CM, ICD9CM, SNOMED</p></td>
<td><p><a href="https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/sql_queries/dx_glomerular_disease.sql">dx_glomerular_disease.sql</a></p></td>
<td><p>2022-06</p></td>
<td><p>Levon Utidjian</p></td>
<td><p>vocab-based</p></td>
<td></td>
<td><p>ICD codes are included with and without decimal points, indicated by <code>cc_decimal_removal</code>. This codeset requires further review.</p></td>
</tr>
<tr class="odd">
<td><p>dx_glomerular_snomed</p></td>
<td><p><a href="https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/condition/dx_glomerular_snomed.csv">dx_glomerular_snomed</a></p></td>
<td><p>SNOMED-only diagnoses for glomerular disease, developed for the FSGS project</p></td>
<td><p>SNOMED</p></td>
<td><p>NA</p></td>
<td><p>2021-03</p></td>
<td><p>Amy Goodwin Davies and Michelle Denburg</p></td>
<td><p>clinician-review</p></td>
<td></td>
<td><p>This codeset is provided as a reference for developing an updated PCORnet codeset</p></td>
</tr>
<tr class-"even">
<td><p>dx_cancer</p></td>
<td><p><a href="https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/condition/dx_cancer.csv">dx_cancer</a></p></td>
<td><p>Diagnoses for cancer malignancy</p></td>
<td><p>ICD10, ICD10CM, ICD9CM, SNOMED</p></td>
<td><p><a href="https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/sql_queries/dx_cancer.sql">dx_cancer.sql</a></p></td>
<td><p>2022-12</p></td>
<td><p>Amy Goodwin Davies</p></td>
<td><p>vocab-based</p></td>
<td></td>
<td><p>ICD codes are included with and without decimal points, indicated by <code>cc_decimal_removal</code></p></td>
</tr>
<tr class="odd">
<td><p>dx_hypertension_no_pregnancy</p></td>
<td><p><a href="https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/condition/dx_hypertension_no_pregnancy.csv">dx_hypertension_no_pregnancy</a></p></td>
<td><p>Diagnoses for hypertension, excluding those related to pregnancy</p></td>
<td><p>SNOMED</p></td>
<td><p>NA</p></td>
<td><p>2023-01</p></td>
<td><p>Hanieh Razzaghi</p></td>
<td><p>vocab-based</p></td>
<td></td>
<td><p>This codeset is a subset of <a href="https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/condition/dx_hypertension.csv">dx_hypertension</a></p></td>
</tr>
<tr class-"even">
<td><p>dx_cakut</p></td>
<td><p><a href="https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/condition/dx_cakut.csv">dx_cakut</a></p></td>
<td><p>Diagnoses for congenital anomalies of the kidneys and urinary tracts CAKUT</p></td>
<td><p>ICD10, ICD10CM, ICD9CM, SNOMED</p></td>
<td><p><a href="https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/sql_queries/dx_cakut.sql">dx_cakut.sql</a></p></td>
<td><p>2023-07</p></td>
<td><p>Levon Utidjian</p></td>
<td><p>vocab-based</p></td>
<td></td>
<td><p>ICD codes are included with and without decimal points, indicated by <code>cc_decimal_removal</code></p></td>
</tr>
<tr class="odd">
<td><p>dx_cough</p></td>
<td><p><a href="https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/condition/dx_cough.csv">dx_cough</a></p></td>
<td><p>Diagnoses for cough</p></td>
<td><p>ICD10, ICD10CM, ICD9CM, SNOMED</p></td>
<td><p><a href="https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/sql_queries/dx_cough.sql">dx_cough.sql</a></p></td>
<td><p>2023-08</p></td>
<td><p>Levon Utidjian</p></td>
<td><p>vocab-based</p></td>
<td></td>
<td><p>ICD codes are included with and without decimal points, indicated by <code>cc_decimal_removal</code></p></td>
</tr>
<tr class-"even">
<td><p>dx_diabetes</p></td>
<td><p><a href="https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/condition/dx_diabetes.csv">dx_diabetes</a></p></td>
<td><p>Diagnoses for chronic diabetes</p></td>
<td><p>ICD10CM, ICD9CM, SNOMED</p></td>
<td><p>NA</p></td>
<td><p>2022-11</p></td>
<td><p>Levon Utidjian</p></td>
<td><p>vocab-based</p></td>
<td></td>
<td><p>ICD codes are included with and without decimal points, indicated by <code>cc_decimal_removal</code></p></td>
</tr>
<tr class-"even"> 
<td><p>dx_hypotension</p></td>
<td><p><a href="https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/condition/dx_hypotension.csv">dx_hypotension</a></p></td>
<td><p>Diagnoses for hypotension</p></td>
<td><p>ICD10, ICD10CM, ICD9CM, SNOMED</p></td>
<td><p><a href="https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/sql_queries/dx_hypotension.sql">dx_hypotension.sql</a></p></td>
<td><p>2022-04</p></td>
<td><p>Levon Utidjian</p></td>
<td><p>vocab-based</p></td>
<td></td>
<td><p>ICD codes are included with and without decimal points, indicated by <code>cc_decimal_removal</code></p></td>
</tr>
<tr class="odd">
<td><p>dx_pyelonephritis</p></td>
<td><p><a href="https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/condition/dx_pyelonephritis.csv">dx_pyelonephritis</a></p></td>
<td><p>Diagnoses for pyelonephritis</p></td>
<td><p>ICD10, ICD10CM, ICD9CM, SNOMED</p></td>
<td><p><a href="https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/sql_queries/dx_pyelonephritis.sql">dx_pyelonephritis.sql</a></p></td>
<td><p>2022-04</p></td>
<td><p>Levon Utidjian</p></td>
<td><p>vocab-based</p></td>
<td></td>
<td><p>ICD codes are included with and without decimal points, indicated by <code>cc_decimal_removal</code></p></td>
</tr>
<tr class-"even">
<td><p>dx_tonsillitis</p></td>
<td><p><a href="https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/condition/dx_tonsillitis.csv">dx_tonsillitis</a></p></td>
<td><p>Diagnoses for tonsillitis</p></td>
<td><p>ICD10, ICD10CM, ICD9CM, SNOMED</p></td>
<td><p><a href="https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/sql_queries/dx_tonsillitis.sql">dx_tonsillitis.sql</a></p></td>
<td><p>2022-04</p></td>
<td><p>Levon Utidjian</p></td>
<td><p>vocab-based</p></td>
<td></td>
<td><p>ICD codes are included with and without decimal points, indicated by <code>cc_decimal_removal</code></p></td>
</tr>
<tr class="odd">
<td><p>dx_uti</p></td>
<td><p><a href="https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/condition/dx_uti.csv">dx_uti</a></p></td>
<td><p>Diagnoses for urinary tract infection uti</p></td>
<td><p>ICD10, ICD10CM, ICD9CM, SNOMED</p></td>
<td><p><a href="https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/sql_queries/dx_uti.sql">dx_uti.sql</a></p></td>
<td><p>2022-04</p></td>
<td><p>Levon Utidjian</p></td>
<td><p>vocab-based</p></td>
<td></td>
<td><p>ICD codes are included with and without decimal points, indicated by <code>cc_decimal_removal</code></p></td>
</tr>
<tr class-"even">
<td><p>dx_edema</p></td>
<td><p><a href="https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/condition/dx_edema.csv">dx_edema</a></p></td>
<td><p>Diagnoses for edema</p></td>
<td><p>ICD10, ICD10CM, ICD9CM, SNOMED</p></td>
<td><p><a href="https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/sql_queries/dx_edema.sql">dx_edema.sql</a></p></td>
<td><p>2023-10</p></td>
<td><p>Levon Utidjian</p></td>
<td><p>vocab-based</p></td>
<td></td>
<td><p>ICD codes are included with and without decimal points, indicated by <code>cc_decimal_removal</code></p></td>
</tr>
<tr class="odd">
<td><p>dx_fatigue</p></td>
<td><p><a href="https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/condition/dx_fatigue.csv">dx_fatigue</a></p></td>
<td><p>Diagnoses for fatigue</p></td>
<td><p>ICD10, ICD10CM, ICD9CM, SNOMED</p></td>
<td><p><a href="https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/sql_queries/dx_fatigue.sql">dx_fatigue.sql</a></p></td>
<td><p>2023-10</p></td>
<td><p>Levon Utidjian</p></td>
<td><p>vocab-based</p></td>
<td></td>
<td><p>ICD codes are included with and without decimal points, indicated by <code>cc_decimal_removal</code></p></td>
</tr>
<tr class-"even">
<td><p>dx_gi_symptoms</p></td>
<td><p><a href="https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/condition/dx_gi_symptoms.csv">dx_gi_symptoms</a></p></td>
<td><p>Diagnoses for gastrointestinal gi symptoms</p></td>
<td><p>ICD10, ICD10CM, ICD9CM, SNOMED</p></td>
<td><p><a href="https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/sql_queries/dx_gi_symptoms.sql">dx_gi_symptoms.sql</a></p></td>
<td><p>2023-10</p></td>
<td><p>Levon Utidjian</p></td>
<td><p>vocab-based</p></td>
<td></td>
<td><p>ICD codes are included with and without decimal points, indicated by <code>cc_decimal_removal</code></p></td>
</tr>
<tr class="odd">
<td><p>dx_hair_loss</p></td>
<td><p><a href="https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/condition/dx_hair_loss.csv">dx_hair_loss</a></p></td>
<td><p>Diagnoses for hair loss</p></td>
<td><p>ICD10, ICD10CM, ICD9CM, SNOMED</p></td>
<td><p><a href="https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/sql_queries/dx_hair_loss.sql">dx_hair_loss.sql</a></p></td>
<td><p>2023-10</p></td>
<td><p>Levon Utidjian</p></td>
<td><p>vocab-based</p></td>
<td></td>
<td><p>ICD codes are included with and without decimal points, indicated by <code>cc_decimal_removal</code></p></td>
</tr>
<tr class-"even">
<td><p>dx_headache</p></td>
<td><p><a href="https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/condition/dx_headache.csv">dx_headache</a></p></td>
<td><p>Diagnoses for headache</p></td>
<td><p>ICD10, ICD10CM, ICD9CM, SNOMED</p></td>
<td><p><a href="https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/sql_queries/dx_headache.sql">dx_headache.sql</a></p></td>
<td><p>2023-10</p></td>
<td><p>Levon Utidjian</p></td>
<td><p>vocab-based</p></td>
<td></td>
<td><p>ICD codes are included with and without decimal points, indicated by <code>cc_decimal_removal</code></p></td>
</tr>
<tr class="odd">
<td><p>dx_respiratory_infections</p></td>
<td><p><a href="https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/condition/dx_respiratory_infections.csv">dx_respiratory_infections</a></p></td>
<td><p>Diagnoses for respiratory_infections</p></td>
<td><p>ICD10, ICD10CM, ICD9CM, SNOMED</p></td>
<td><p><a href="https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/sql_queries/dx_respiratory_infections.sql">dx_respiratory_infections.sql</a></p></td>
<td><p>2023-10</p></td>
<td><p>Levon Utidjian</p></td>
<td><p>vocab-based</p></td>
<td></td>
<td><p>ICD codes are included with and without decimal points, indicated by <code>cc_decimal_removal</code></p></td>
</tr>
<tr class-"even">
<td><p>dx_dizziness</p></td>
<td><p><a href="condition/dx_dizziness.csv">dx_dizziness</a></p></td>
<td><p>Diagnoses for dizziness</p></td>
<td><p>ICD10, ICD10CM, ICD9CM</p></td>
<td><p><a href="https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/sql_queries/dx_dizziness.sql">dx_dizziness.sql</a></p></td>
<td><p>2024-04</p></td>
<td><p>Hanieh Razzaghi, Amy Goodwin Davies</p></td>
<td><p>vocab-based</p></td>
<td></td>
<td><p>ICD codes are included with and without decimal points, indicated by <code>cc_decimal_removal</code></p></td>
</tr>
<tr class="odd">
<td><p>dx_glomerular_icd</p></td>
<td><p><a href="https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/condition/dx_glomerular_icd.csv">dx_glomerular_icd</a></p></td>
<td><p>ICD-only diagnoses for glomerular disease, derived from <a href="https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/condition/dx_glomerular_disease.csv">dx_glomerular_disease</a> codeset</p></td>
<td><p>ICD9CM, ICD10, ICD10CM</p></td>
<td></td>
<td><p>2024-01</p></td>
<td><p>Levon Utidjian</p></td>
<td><p>vocab-based</p></td>
<td></td>
<td><p>ICD codes are included with and without decimal points, indicated by <code>cc_decimal_removal</code></p>
<p>Codeset category labels were determined either by mapping to the <a href="https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/condition/dx_glomerular_snomed.csv">dx_glomerular_snomed</a> codeset or by a manual review by Chris and Michelle to recommend an appropriate label.</p></td>
</tr>
<tr class-"even">
<td><p>dx_cakut_only</p></td>
<td><p><a href="https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/condition/dx_cakut_only.csv">dx_cakut_only</a></p></td>
<td><p>Diagnoses for CAKUT. Differs from <a href="dx_cakut.csv">dx_cakut</a>, which also includes diagnoses for polycystic kidney disease PKD</p></td>
<td><p>ICD10, ICD10CM, ICD9CM, SNOMED</p></td>
<td><p><a href="https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/sql_queries/dx_cakut_v2.sql">dx_cakut_v2.sql</a></p></td>
<td><p>2024-01</p></td>
<td><p>Levon Utidjian</p></td>
<td><p>vocab-based</p></td>
<td></td>
<td><p>ICD codes are included with and without decimal points, indicated by <code>cc_decimal_removal</code></p></td>
</tr>
<tr class="odd">
<td><p>dx_pkd</p></td>
<td><p><a href="https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/condition/dx_pkd.csv">dx_pkd</a></p></td>
<td><p>Diagnoses for Polycystic Kidney Disease PKD</p></td>
<td><p>ICD10, ICD10CM, ICD9CM, SNOMED</p></td>
<td><p><a href="https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/sql_queries/dx_pkd.sql">dx_pkd.sql</a></p></td>
<td><p>2024-01</p></td>
<td><p>Levon Utidjian</p></td>
<td><p>vocab-based</p></td>
<td></td>
<td><p>ICD codes are included with and without decimal points, indicated by <code>cc_decimal_removal</code></p></td>
</tr>
<tr class-"even">
<td><p>dx_pregnancy</p></td>
<td><p><a href="https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/condition/dx_pregnancy.csv">dx_pregnancy</a></p></td>
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
<td><p><a href="https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/condition/dx_renal_artery_stenosis.csv">dx_renal_artery_stenosis</a></p></td>
<td><p>Diagnoses indicating renal artery stenosis, developed within the CER work</p></td>
<td><p>ICD9CM, ICD10CM</p></td>
<td><p><a href="https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/sql_queries/dx_renal_artery_stenosis.sql">dx_renal_artery_stenosis.sql</a></p></td>
<td><p>2024-04</p></td>
<td><p>Chris Forrest</p></td>
<td><p>clinician-reviewed</p></td>
<td></td>
<td><p>CD codes are included with and without decimal points, indicated by <code>cc_decimal_removal</code></p></td>
</tr>
<tr class-"even">
<td><p>dx_el_bp</p></td>
<td><p><a href="https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/condition/dx_el_bp.csv">dx_el_bp</a></p></td>
<td><p>Diagnoses for elevated blood pressure distinct from hypertension</p></td>
<td><p>ICD9CM, ICD10CM</p></td>
<td><p><a href="https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/sql_queries/dx_el_bp.sql">dx_el_bp.sql</a></p></td>
<td><p>2024-04</p></td>
<td><p>Amy Goodwin Davies</p></td>
<td><p>vocab-based</p></td>
<td></td>
<td><p>ICD codes are included with and without decimal points, indicated by <code>cc_decimal_removal</code></p></td>
</tr>
<tr class-"even">
<td><p>ckd_dx_usrds</p></td>
<td><p><a href="https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/condition/ckd_dx_usrds.csv">ckd_dx_usrds</a></p></td>
<td><p>CKD condition codes published by USRDS</p></td>
<td><p>ICD10CM</p></td>
<td></td>
<td><p>2024</p></td>
<td><p>Computable phenotype WG led by Zubin Modi &amp; Michelle Denburg</p></td>
<td><p>clinician-reviewed</p></td>
<td></td>
<td><p>Urologic and other conditions that were not accompanied or likely to be accompanied by kidney disease or dysfunction were removed from this list of CKD codes. Additionally, codes for cystic diseases, which have traditionally been part of CAKUT congenital anomalies of the kidney and urologic tract, were grouped into a dedicated disease category, thereby allowing us to show five, rather than four, causes of kidney disease in children. More information could be found <a href="https://usrds-adr.niddk.nih.gov/2024/chronic-kidney-disease/5-kidney-disease-among-children-and-adolescents">here</a></p></td>
</tr>
</tbody>
</table>

## Demographic

---
### Notes on usage

<ins>PCORnet:</ins>
-   Tables: DEMOGRAPHIC

-   Select the FIELD_NAME from the TABLE_NAME specified in the valueset
---

Codeset structure:

For fields, use the following fields from the PCORNET CDM specifications:

| TABLE_NAME | FIELD_NAME | RDBMS_DATA_TYPE | SAS_DATA_TYPE | DATA_FORMAT | REPLICATED_FIELD | UNIT_OF_MEASURE | VALUESET | FIELD_DEFINITION |
|------------|------------|-----------------|---------------|-------------|------------------|-----------------|----------|------------------|
|            |            |                 |               |             |                  |                 |          |                  |

Codesets and valuesets:

| Name | Codeset link | Description | Vocabularies | SQL link | Date developed | Developer | Status | Date finalized | Other |
|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|
|  |  |  |  |  |  |  |  |  |  |

## Drug

---
### Notes on usage

<ins>PCORnet</ins>:

-   **Tables:** MED_ADMIN (administrations), PRESCRIBING

-   Use distinct `concept_code` and `pcornet_vocabulary_id` columns

-   **For administrations:** Join the `concept_code` column and the `pcornet_vocabulary_id` column in the codeset to the `MEDADMIN_CODE` column and `MEDADMIN_TYPE` column in the MED_ADMIN table, respectively

-   **For prescriptions:** Join the `concept_code` column in the codeset to the `RXNORM_CUI` column in the PRESCRIBING table

<ins>PEDSnet</ins>:

-   Tables: drug_exposure

-   Use distinct `concept_id` and `vocabulary_id` columns
---

Codeset structure:

| concept_id | concept_code | concept_name | vocabulary_id | pcornet_vocabulary_id |
|------------|--------------|--------------|---------------|-----------------------|
|            |              |              |               |                       |

where `pcornet_vocabulary_id` is an acceptable value according to the supported values in the `VALUESET_ITEM` column below:

| FIELD_NAME    | VALUESET_ITEM (pcornet_vocabulary_id) | VALUESET_ITEM_DESCRIPTOR |
|---------------|---------------------------------------|--------------------------|
| MEDADMIN_TYPE | ND                                    | ND-NDC                   |
| MEDADMIN_TYPE | RX                                    | RX-RXNORM                |

Codesets and valuesets:

| Name | Codeset link | Description | Vocabularies | SQL link | Date developed | Developer | Status | Date finalized | Other |
|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|
| rx_ace_inhibitor | [rx_ace_inhibitor](https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/drug/rx_ace_inhibitor.csv) | Medication codeset for the following ingredients: Benazepril, Captopril, Enalapril, Fosinopril, Lisinopril, Moexipril, Periondopril, Quinapril,Ramipril, Trandolapril | NDC, RxNorm, RxNorm Extension | [rx_ace_inhibitor.sql](https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/sql_queries/rx_ace_inhibitor.sql) | 2021-11 | Levon Utidjian | vocab-based |  | combos included |
| rx_arb | [rx_arb](https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/drug/rx_arb.csv) | Medication codeset for the following ingredients: Azilsartan, Candesartan,Eprosartan,Irbesartan,Losartan,Olmesartan,Telmisartan, Valsartan | NDC, RxNorm, RxNorm Extension | [rx_arb.sql](https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/sql_queries/rx_arb.sql) | 2021-11 | Levon Utidjian | vocab-based |  | combos included |
| rx_bb | [rx_bb](drug/https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/rx_bb.csv) | Medication codeset for the following ingredients:, Acebutolol, Atenolol, Betaxolol,Bisoprolol, Carteolol, Carvediol, Labetalol, Metoprolol, Nadolol, Nebivolol, Penbutolol, Pindolol, Propanolol, Sotalol, Timolol | NDC, RxNorm, RxNorm Extension | [rx_bb.sql](https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/sql_queries/rx_bb.sql) | 2021-11 | Levon Utidjian | vocab-based |  | combos included |
| rx_ccb | [rx_ccb](https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/drug/rx_ccb.csv) | Medication codeset for the following ingredients: Amlodipine, Diltiazem, Felodipine, Isradipine, Nicardipine, Nifedipine, Nisoldipine ,Verapamil | NDC, RxNorm, RxNorm Extension | [rx_ccb.sql](https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/sql_queries/rx_ccb.sql) | 2021-11 | Levon Utidjian | vocab-based |  | combos included |
| rx_loop_diuretic | [rx_loop_diuretic](https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/drug/rx_loop_diuretic.csv) | Medication codeset for the following ingredients: Furosemide, Bumetanide, Ethacrynic acid, Torsemide | NDC, RxNorm, RxNorm Extension | [rx_loop_diuretic.sql](https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/sql_queries/rx_loop_diuretic.sql) | 2021-11 | Levon Utidjian | vocab-based |  | combos included |
| rx_thiazide | [rx_thiazide](https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/drug/rx_thiazide.csv) | Medication codeset for the following ingredients: Chlorothiazide, Chlorthalidone, Hydrochlorothiazide, Indapamide, Metolazone | NDC, RxNorm, RxNorm Extension | [rx_thiazide.sql](https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/sql_queries/rx_thiazide.sql) | 2021-11 | Levon Utidjian | vocab-based |  | combos included |
| rx_anesthesia | [rx_anesthesia](https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/drug/rx_anesthesia.csv) | General anesthesia: Propofol (intravenous), Etomidate (intravenous), Ketamine (intravenous), Midazolam (intravenous), Fentanyl (intravenous), Nitrous oxide (inhaled), Sevoflurane (inhaled), Desflurane (inhaled), Isoflurane (inhaled) | RxNorm, RxNorm Extension | [rx_anesthesia.sql](https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/sql_queries/rx_anesthesia.sql) | 2022-02 | Kimberley Dickinson | vocab-based |  |  |
| rx_fludrocortisone | [rx_fludrocortisone](https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/drug/rx_fludrocortisone.csv) | Oral fludrocortisone | RxNorm, RxNorm Extension |  | 2022-02 | Kimberley Dickinson | vocab-based |  |  |
| rx_deflazacort | [rx_deflazacort](https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/drug/rx_deflazacort.csv) | Oral deflazacort | RxNorm, RxNorm Extension |  | 2022-02 | Kimberley Dickinson | vocab-based |  |  |
| rx_nephrotoxic_chemo | [rx_nephrotoxic_chemo](https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/drug/rx_nephrotoxic_chemo.csv) | All RxNorm and NDC descendants of ATC classes for nephrotoxic chemotherapies listed in [Nicolaysen 2020](https://doi.org/10.1053/j.ackd.2019.08.005) and in addition cabroplatin, melphalan, carmustine, lomustine, and azacitidine per Charles Bailey, MD | NDC, RxNorm, RxNorm Extension | [rx_nephrotoxic_chemo.sql](https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/sql_queries/rx_nephrotoxic_chemo.sql) | 2022-11 | Amy Goodwin Davies | vocab-based |  |  |
| rx_antineoplastics | [rx_antineoplastics](https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/drug/rx_antineoplastics.csv) | All RxNorm and NDC descendants of ATC classes for antineoplastics | NDC, RxNorm, RxNorm Extension | [rx_antineoplastics.sql](https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/sql_queries/rx_antineoplastics.sql) | 2022-12 | Kaleigh Wieand | vocab-based |  |  |
| rx_chemo | [rx_chemo](https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/drug/rx_chemo.csv) | Chemotherapy drugs | NDC, RxNorm, RxNorm Extension | [rx_chemo.sql](https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/sql_queries/rx_chemo.sql) | 2023-01 | Levon Utidjian | vocab-based |  |  |
| rx_ace_inhibitor_no_iv | [rx_ace_inhibitor_no_iv](https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/drug/rx_ace_inhibitor_no_iv.csv) | A subset of [rx_ace_inhibitor](https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/drug/rx_ace_inhibitor.csv) with all IV and injectable drugs removed | NDC, RxNorm, RxNorm Extension |  | 2024-05 | Kaleigh Wieand | vocab-based |  |  |
| rx_arb_no_iv | [rx_arb_no_iv](https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/drug/rx_arb_no_iv.csv) | A subset of [rx_arb](https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/drug/rx_arb.csv) with all IV and injectable drugs removed | NDC, RxNorm, RxNorm Extension |  | 2024-05 | Kaleigh Wieand | vocab-based |  |  |
| rx_bb_no_iv | [rx_bb_no_iv](https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/drug/rx_bb_no_iv.csv) | A subset of [rx_bb](https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/drug/rx_bb.csv) with all IV and injectable drugs removed | NDC, RxNorm, RxNorm Extension |  | 2024-05 | Kaleigh Wieand | vocab-based |  |  |
| rx_ccb_no_iv | [rx_ccb_no_iv](https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/drug/rx_ccb_no_iv.csv) | A subset of [rx_ccb](https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/drug/rx_ccb.csv) with all IV and injectable drugs removed | NDC, RxNorm, RxNorm Extension |  | 2024-05 | Kaleigh Wieand | vocab-based |  |  |
| rx_thiazide_no_iv | [rx_thiazide_no_iv](https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/drug/rx_thiazide_no_iv.csv) | A subset of [rx_thiazide](https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/drug/rx_thiazide.csv) with all IV and injectable drugs removed | NDC, RxNorm, RxNorm Extension |  | 2024-05 | Kaleigh Wieand | vocab-based |  |  |

## Measurement

---
### Notes on usage

<ins>PCORnet:</ins>

-   **Tables:** LAB_RESULT_CM, OBS_CLIN, VITAL

-   Use distinct `concept_code` and `pcornet_vocabulary_id` columns

-   **For fields (e.g. in VITAL)**: select the FIELD_NAME from the TABLE_NAME specified in the valueset

-   **For lab results:** Join the `concept_code` column in the codeset to the `LAB_LOINC` column in the LAB_RESULT_CDM table

<ins>PEDSnet:</ins>

-   Tables: measurement

-   Use distinct `concept_id` and `vocabulary_id` columns
---

Codeset structure:

| concept_id | concept_code | concept_name | vocabulary_id | pcornet_vocabulary_id |
|------------|--------------|--------------|---------------|-----------------------|
|            |              |              |               |                       |

where `pcornet_vocabulary_id` should always be LC for LOINC

For fields, use the following fields from the PCORNET CDM specifications:

| TABLE_NAME | FIELD_NAME | RDBMS_DATA_TYPE | SAS_DATA_TYPE | DATA_FORMAT | REPLICATED_FIELD | UNIT_OF_MEASURE | VALUESET | FIELD_DEFINITION |
|------------|------------|-----------------|---------------|-------------|------------------|-----------------|----------|------------------|
|            |            |                 |               |             |                  |                 |          |                  |

Codesets and valuesets:

| Name | Codeset link | Description | Vocabularies | SQL link | Date developed | Developer | Status | Date finalized | Other |
|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|
| Height (field) | [anthro_ht_field](https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/measurement/anthro_ht_field.csv) | Field of VITAL table | NA | NA | NA | NA | vocab-based |  |  |
| Weight (field) | [anthro_wt_field](https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/measurement/anthro_wt_field.csv) | Field of VITAL table | NA | NA | NA | NA | vocab-based |  |  |
| Original BMI (field) | [anthro_original_bmi_field](https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/measurement/anthro_original_bmi_field.csv) | Field of VITAL table | NA | NA | NA | NA | vocab-based |  |  |
| Systolic Blood Pressure (field) | [vital_systolic_field](https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/measurement/vital_systolic_field.csv) | Field of VITAL table | NA | NA | NA | NA | vocab-based |  |  |
| Diastolic Blood Pressure (field) | [vital_diastolic_field](https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/measurement/vital_diastolic_field.csv) | Field of VITAL table | NA | NA | NA | NA | vocab-based |  |  |
| Serum creatinine | [lab_serum_creatinine](https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/measurement/lab_serum_creatinine.csv) | Serum creatinine measurements | LOINC | [lab_serum_creatinine.sql](https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/sql_queries/lab_serum_creatinine.sql) | 2021-10 | Levon Utidjian | vocab-based |  |  |
| Serum cystatin | [lab_serum_cystatin](https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/measurement/lab_serum_cystatin.csv) | Serum cystatin measurements | LOINC | [lab_serum_cystatin.sql](https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/sql_queries/lab_serum_cystatin.sql) | 2021-11 | Levon Utidjian | vocab-based |  |  |
| Urine creatinine | [lab_urine_creatinine](https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/measurement/lab_urine_creatinine.csv) | Urine creatinine measurements | LOINC | [lab_urine_creatinine.sql](https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/sql_queries/lab_urine_creatinine.sql) | 2021-11 | Levon Utidjian | vocab-based |  |  |
| Urine protein (qualitative) | [lab_urine_protein_qual](https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/measurement/lab_urine_protein_qual.csv) | Urine protein qualitative | LOINC | [lab_urine_protein_qual.sql](https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/sql_queries/lab_urine_protein_qual.sql) | 2021-11 | Levon Utidjian | vocab-based |  |  |
| Urine protein (quantitative) | [lab_urine_protein_quant](https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/measurement/lab_urine_protein_quant.csv) | Urine protein quantitative | LOINC | [lab_urine_protein_quant.sql](https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/sql_queries/lab_urine_protein_quant.sql) | 2021-11 | Levon Utidjian | vocab-based |  |  |
| lab_serum_hemoglobin | [lab_serum_hemoglobin](https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/measurement/lab_serum_hemoglobin.csv) | Serum hemoglobin measurements | LOINC | [lab_serum_hemoglobin.sql](https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/sql_queries/lab_serum_hemoglobin.sql) | 2022-03 | Levon Utidjian | vocab-based |  |  |
| lab_serum_potassium | [lab_serum_potassium](https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/measurement/lab_serum_potassium.csv) | Serum potassium measurements | LOINC | [serum_potassium.sql](https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/sql_queries/serum_potassium.sql) | 2022-03 | Levon Utidjian | vocab-based |  |  |
| lab_serum_wbc | [lab_serum_wbc](https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/measurement/lab_serum_wbc.csv) | Serum white blood cell count measurments | LOINC | [lab_serum_wbc.sql](https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/sql_queries/lab_serum_wbc.sql) | 2022-03 | Levon Utidjian | vocab-based |  |  |
| lab_alanine_transaminase | [lab_alanine_transaminase](https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/measurement/lab_alanine_transaminase.csv) | Alanine transaminase measurments | LOINC | [lab_alanine_transaminase.sql](https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/sql_queries/lab_alanine_transaminase.sql) | 2022-03 | Levon Utidjian | vocab-based |  |  |
| lab_serum_bicarbonate | [lab_serum_bicarbonate](https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/measurement/lab_serum_bicarbonate.csv) | Serum bicarbonate measurments | LOINC | [lab_serum_bicarbonate.sql](https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/sql_queries/lab_serum_bicarbonate.sql) | 2022-04 | Levon Utidjian | vocab-based |  |  |
| bp_method | [bp_method](https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/measurement/bp_method.csv) | Blood pressure methods | LOINC, CPT4, SNOMED | [bp_method.sql](https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/sql_queries/bp_method.sql) | 2023-01 | Levon Utidjian | vocab-based |  | Further exploration is required to determine whether and where in the PCORnet CDM this codes are used |
| meas_birth_weight | [meas_birth_weight](https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/measurement/meas_birth_weight.csv) | Blood pressure methods | LOINC | [meas_birth_weight.sql](https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/sql_queries/meas_birth_weight.sql) | 2023-08 | Amy Goodwin Davies | vocab-based |  | Requested LOINC code for ETL for project |
| meas_gestational_age | [meas_gestational_age](https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/measurement/meas_gestational_age.csv) | Blood pressure methods | LOINC | [meas_gestational_age.sql](https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/sql_queries/meas_gestational_age.sql) | 2023-08 | Amy Goodwin Davies | vocab-based |  | Requested LOINC code for ETL for project |
| bp_diastolic_pedsnet | [bp_diastolic_pedsnet](https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/measurement/bp_diastolic_pedsnet.csv) | Diastolic blood pressure concepts from PEDSnet CDM | LOINC |  | 2024-10 | Amy Goodwin Davies | vocab-based |  |  |
| bp_systolic_pedsnet | [bp_systolic_pedsnet](https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/measurement/bp_systolic_pedsnet.csv) | Systolic blood pressure concepts from PEDSnet CDM | LOINC |  | 2024-10 | Amy Goodwin Davies | vocab-based |  |  |
| height_pedsnet | [height_pedsnet](https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/measurement/height_pedsnet.csv) | Height concepts from PEDSnet CDM | LOINC |  | 2024-10 | Amy Goodwin Davies | vocab-based |  |  |
| weight_pedsnet | [weight_pedsnet](https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/measurement/weight_pedsnet.csv) | Weight concepts from PEDSnet CDM | LOINC |  | 2024-10 | Amy Goodwin Davies | vocab-based |  |  |
| original_bmi_pedsnet | [original_bmi_pedsnet](https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/measurement/original_bmi_pedsnet.csv) | BMI concepts from PEDSnet CDM | LOINC |  | 2024-10 | Amy Goodwin Davies | vocab-based |  |  |

## Procedure

---
### Notes on usage

<ins>PCORnet:</ins>

-   **Tables:** PROCEDURES

-   Use distinct `concept_code` and `pcornet_vocabulary_id` columns

-   Join the `concept_code` column and the `pcornet_vocabulary_id` column in the codeset to the `PX` column and `PX_TYPE` column in the PROCEDURES table, respectively

<ins>PEDSnet:</ins>

-   Tables: procedure_occurrence

-   Use distinct `concept_id` and `vocabulary_id` columns
---

Codeset structure:

| concept_id | concept_code | concept_name | vocabulary_id | pcornet_vocabulary_id | cc_decimal_removal                                            |
|------------|--------------|--------------|---------------|-----------------------|---------------------------------------------------------------|
|            |              |              |               |                       | flag for whether decimal has been removed from `concept_code` |

where `pcornet_vocabulary_id` is an acceptable value according to supported vocabularies in the `VALUESET_ITEM` column below (please note leading zero for "09"):

| FIELD_NAME    | VALUESET_ITEM (pcornet_vocabulary_id) | VALUESET_ITEM_DESCRIPTOR |
|---------------|---------------------------------------|--------------------------|
| PX_TYPE       | 09                                    | 09 - ICD-9-CM            |
| PX_TYPE       | 10                                    | 10 - ICD-10-PCS          |
| PX_TYPE       | 11                                    | 11 - ICD-11-PCS          |
| PX_TYPE       | CH                                    | CH - CPT or HCPCS        |
| PX_TYPE       | LC                                    | LC - LOINC               |
| PX_TYPE       | ND                                    | ND - NDC                 |
| PX_TYPE       | RE                                    | RE - Revenue             |

Codesets and valuesets:

| Name | Codeset link | Description | Vocabularies | SQL link | Date developed | Developer | Status | Date finalized | Other |
|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|
| px_kidney_transplant | [px_kidney_transplant](https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/procedure/px_kidney_transplant.csv) | Kidney transplant procedure codes | CPT4, HCPCS, ICD10PCS, ICD9Proc, SNOMED | [px_kidney_transplant.sql](https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/sql_queries/px_kidney_transplant.sql) | 2021-11 | Levon Utidjian | vocab-based |  | ICD codes are included with and without decimal points, indicated by `cc_decimal_removal`, indicated by `cc_decimal_removal` |
| px_kidney_dialysis | [px_kidney_dialysis](https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/procedure/px_kidney_dialysis.csv) | Kidney dialysis procedure codes.Broader, more sensitive codeset (compared to px_chronic_dialysis) | CPT4, HCPCS, ICD10PCS, ICD9Proc, SNOMED | [px_kidney_dialysis.sql](https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/sql_queries/px_kidney_dialysis.sql) | 2021-11 | Levon Utidjian | vocab-based |  | ICD codes are included with and without decimal points, indicated by `cc_decimal_removal`, indicated by `cc_decimal_removal` |
| px_chronic_dialysis | [px_chronic_dialysis](https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/procedure/px_chronic_dialysis.csv) | ESRD kidney dialysis CPT procedure codes identified by CRO WG. Narrower, more specific codeset (compared to px_kidney_dialysis) | CPT4 |  | 2022-06 | CRO WG | clinician-reviewed |  |  |
| px_abpm | [px_abpm](https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/procedure/px_abpm.csv) | CPT4 Procedures codes for "ambulatory blood pressure monitoring, utilizing report-generating software, automated, worn continuously for 24 hours or longer" | CPT4 | [px_abpm.sql](https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/sql_queries/px_abpm.sql) | 2022-06 | Amy Goodwin Davies / Levon Utidjian | Provided by ABPM workgroup |  |  |
| px_kidney_biopsy | [px_kidney_biopsy](https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/procedure/px_kidney_biopsy.csv) | Kidney biopsy procedure codes | CPT4, HCPCS, ICD9Proc, ICD10PCS, SNOMED | [px_kidney_biopsy.sql](https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/sql_queries/px_kidney_biopsy.sql) | 2023-04 | Levon Utidjian | vocab-based |  | Limited excision/drainage/extraction to 'diagnostic' qualifiers since those are most appropriate for biopsy per CMS guidance. ICD codes are included with and without decimal points, indicated by `cc_decimal_removal`, indicated by `cc_decimal_removal` |
| px_broad_chronic_dialysis_USRDS | [px_broad_chronic_dialysis_USRDS](https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/procedure/px_broad_chronic_dialysis_USRDS.csv) | Optimized codeset for chronic &broad dialysis procedures used to validate USRDS data | CPT4, HCPCS, ICD9Proc, ICD10PCS, SNOMED |  | 2024 | Computable phenotype WG led by Zubin Modi & Michelle Denburg | clinician-reviewed |  | This codeset is neither more specific nor more sensitive in picking up chronic dialysis patients compared to px_kidney_dialysis codeset. However it has the most optimal performance in term of overall accuracy. Some codes might seem reduntdant with the same concept_id; however, they have different pcornet_vocabulary_id which is required to query all relevant data |
| px_kidney_transplant_USRDS | [px_kidney_transplant_USRDS](https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/procedure/px_kidney_transplant_USRDS.csv) | Optimized codeset for kidney transplant procedures used to validate USRDS data | CPT4, HCPCS, ICD9Proc, ICD9ProcCN, ICD10PCS, SNOMED |  | 2024 | Computable phenotype WG led by Zubin Modi & Michelle Denburg | clinician-reviewed |  | This codeset is neither more specific nor more sensitive in picking up kidney transplant patients compared to the px_kidney_transplant codeset. However it has the most optimal performance in term of overall accuracy. Some codes might seem reduntdant with the same concept_id; however, they have different pcornet_vocabulary_id which is required to query all relevant data. |
| px_chronic_broad_dialysis | [px_chronic_broad_dialysis](https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/procedure/px_chronic_broad_dialysis.csv) |  |  |  |  |  |  |  |  |

## Visit Related

---
### Notes on usage

<ins>PCORnet:</ins>

-   Tables: ENCOUNTER

-   Join the `VALUESET_ITEM` in the codeset to the field specified in the `FIELD_NAME` column of the codeset in the ENCOUNTER table
---

Codeset structure:

For valuesets, use the following fields from the PCORNET CDM

| TABLE_NAME  | FIELD_NAME  | VALUESET_ITEM (pcornet_vocabulary_id) | VALUESET_ITEM_DESCRIPTOR |
|-------------|-------------|---------------------------------------|--------------------------|
|             |             |                                       |                          |

Codesets and valuesets:

| Name | Codeset link | Description | Vocabularies | SQL link | Date developed | Developer | Status | Date finalized | Other |
|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|
| Nephrology provider | [nephrology_spec_prov](https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/visit/nephrology_spec_prov.csv) | Nephrology provider | PCORNET Value Set |  | 2021-09 | Amy Goodwin Davies | vocab-based | based on PCORnet CDM v6.0 2021-04 |  |
| Nephrology facility | [nephrology_spec_fac](https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/visit/nephrology_spec_fac.csv) | Nephrology facility | PCORNET Value Set |  | 2022-11 | Amy Goodwin Davies | vocab-based | based on PCORnet CDM v6.0 2021-11 |  |
| Cardiology facility | [cardiology_spec_fac](https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/visit/cardiology_spec_fac.csv) | Cardiology facility | PCORNET Value Set |  | 2021-09 | Amy Goodwin Davies | vocab-based | based on PCORnet CDM v6.0 2021-04 |  |
| Cardiology provider | [cardiology_spec_prov](https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/visit/cardiology_spec_prov.csv) | Cardiology provider | PCORNET Value Set |  | 2021-10 | Amy Goodwin Davies | vocab-based | based on PCORnet CDM v6.0 2021-04 |  |
| Oncology facility | [oncology_spec_fac](https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/visit/oncology_spec_fac.csv) | Oncology facility | PCORNET Value Set |  | 2021-10 | Amy Goodwin Davies | vocab-based | based on PCORnet CDM v6.0 2021-04 |  |
| Oncology provider | [oncology_spec_prov](https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/visit/oncology_spec_prov.csv) | Oncology provider | PCORNET Value Set |  | 2021-10 | Amy Goodwin Davies | vocab-based | based on PCORnet CDM v6.0 2021-04 |  |
| Primary care facility | [primary_care_spec_fac](https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/visit/primary_care_spec_fac.csv) | Oncology facility | PCORNET Value Set |  | 2021-10 | Amy Goodwin Davies | vocab-based | based on PCORnet CDM v6.0 2021-04 |  |
| Primary care provider | [primary_care_spec_prov](https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/visit/primary_care_spec_prov.csv) | Primary care provider | PCORNET Value Set |  | 2021-10 | Amy Goodwin Davies | vocab-based | based on PCORnet CDM v6.0 2021-04 |  |
| Urology facility | [urology_spec_fac](https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/visit/urology_spec_fac.csv) | Urology facility | PCORNET Value Set |  | 2021-10 | Amy Goodwin Davies | vocab-based | based on PCORnet CDM v6.0 2021-04 |  |
| Urology provider | [urology_spec_prov](https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/visit/urology_spec_prov.csv) | Urology provider | PCORNET Value Set |  | 2021-09 | Amy Goodwin Davies | vocab-based | based on PCORnet CDM v6.0 2021-04 |  |
| Emergency Visits | [emergency_visits](https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/visit/emergency_visits.csv) | Emergency and Emergency-\>Inpatient Visits | PCORnet Value Set |  | 2021-09 | Kimberley Dickinson | vocab-based | based on PCORnet CDM v6.0 2021-04 |  |
| Outpatient Visits | [outpatient_visits](https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/visit/outpatient_visits.csv) | Outpatient Visits | PCORnet Value Set |  | 2021-09 | Kimberley Dickinson | vocab-based | based on PCORnet CDM v6.0 2021-04 |  |
| Inpatient Visits | [inpatient_visits](https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/visit/inpatient_visits.csv) | Inpatient and Emergency-\>Inpatient Visits | PCORnet Value Set |  | 2021-09 | Kimberley Dickinson | vocab-based | based on PCORnet CDM v6.0 2021-04 |  |
| Hematology facility | [hematology_spec_fac](visit/hematology_spec_fac.csv) | Hematology facility | PCORNET Value Set |  | 2023-08 | Amy Goodwin Davies | vocab-based | based on PCORnet CDM v6.0 2021-04 |  |
| Hematology provider | [hematology_spec_prov](https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/visit/hematology_spec_prov.csv) | Hematology provider | PCORNET Value Set |  | 2023-08 | Amy Goodwin Davies | vocab-based | based on PCORnet CDM v6.0 2021-04 |  |
| Face-to-face encounters | [prs_face_to_face_enc_types](https://github.com/PRESERVE-Coordinating-Center/PRESERVE_Variables/tree/main/codesets/visit/prs_face_to_face_enc_types.csv) | PRESERVE definition of "face to face" encounters | PCORNET Value Set |  | 2023-12 | Amy Goodwin Davies | vocab-based | based on PCORnet CDM v6.1 2023-04 |  |
