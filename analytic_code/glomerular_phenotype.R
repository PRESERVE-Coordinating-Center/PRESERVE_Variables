
#' Identify glomerular disease cohort
#' 
#' Identify glomerular disease cohort
#' 2 broad pathways into the cohort:
#' -- 2 or more glomerular inclusion diagnoses on different dates
#' -- 1 or more glomerular inclusion diagnosis AND 1 or more kidney biopsy which is not post-transplant
#' 2 glomerular inclusion diagnosis groups had special requirements:
#' -- "other_code_req" inclusion diagnoses alone are not sufficient for a patient to meet the computational phenotype:
#' these codes are only included if they have 1 or more other glomerular inclusion diagnoses
#' (i.e. NOT from "other_code_req" list) on a different date or if they have 1 or more kidney biopsy which is not post-transplant
#' -- "neph_req" diagnoses are only included for the algorithm if associated with a nephrology visit
#'
#' @param demographic_tbl Demographic table
#' @param diagnosis_tbl Diagnosis table
#' @param condition_tbl Condition table
#' @param procedure_tbl Procedures table
#' @param provider_tbl Provider table
#' @param encounter_tbl Encounter table
#' @param neph_enc_table Nephrology encounter table
#' @param age_ub_years Age upper bound
#' @param min_date_cutoff Date before which visits are excluded
#' @param max_date_cutoff Date after which visits are excluded
#' @param kidney_transplant_proc_codeset Kidney transplant procedure codeset
#' @param kidney_biopsy_proc_codeset Kidney biopsy procedure codeset
#' @param glomerular_disease_codeset Glomerular disease codeset
#' @param other_code_req_codeset List of codes for which another more specific 
#' code is required
#' @param neph_req_codeset List of codes for which the diagnosis must be associated
#' with a nephrology specialty visit
#' 
get_glean_cohort <- function(cohort = cdm_tbl("demographic"), 
                             demographic_tbl = cdm_tbl("demographic"), 
                             diagnosis_tbl = cdm_tbl("diagnosis"),
                             condition_tbl = cdm_tbl("condition"),
                             procedure_tbl = cdm_tbl("procedures"),
                             provider_tbl = cdm_tbl("provider"),
                             encounter_tbl = cdm_tbl("encounter"),
                             neph_enc_table,
                             age_ub_years = 30L,
                             min_date_cutoff = as.Date("2009-01-01"),
                             max_date_cutoff = as.Date("2022-12-31"),
                             endpoint_tbl,
                             kidney_transplant_proc_codeset,
                             kidney_biopsy_proc_codeset,
                             glomerular_disease_codeset,
                             other_code_req_codeset,
                             neph_req_codeset) {

  cohort_w_endpoints <- cohort %>%
    left_join(select(endpoint_tbl, patid, endpoint_date), by = "patid")
  
  # get all glomerular disease conditions prior to age 30 using diagnosis tbl
  glomerular_disease_conds_raw_1 <- diagnosis_tbl %>%
    inner_join(select(cohort_w_endpoints, patid, endpoint_date), by = "patid") %>%
    mutate(dx_after_endpoint = if_else(!is.na(endpoint_date) &
                                         coalesce(admit_date, dx_date) > endpoint_date,
                                         TRUE, FALSE)) %>%
    filter(dx_after_endpoint == FALSE) %>% 
    inner_join(distinct(cohort, patid), by = "patid") %>% 
    inner_join(glomerular_disease_codeset, by=c('dx'='concept_code', 'dx_type'='pcornet_vocabulary_id')) %>%
    inner_join(select(demographic_tbl, patid, site, birth_date), by=c('patid', 'site')) %>% 
    mutate(dx_cond = dx,
           dx_cond_type = dx_type,
           dx_cond_date = coalesce(admit_date, dx_date),
           table_source = 'diagnosis',
           problem_list = FALSE) %>% 
    mutate(dx_date_age_in_days= as.numeric(dx_cond_date-birth_date)) %>%
    filter(
      dx_date_age_in_days < age_ub_years * 365.25,
      dx_cond_date >= min_date_cutoff,
      dx_cond_date <= max_date_cutoff
    ) %>%
    compute_new(name = "glomerular_disease_conds_1",
                indexes = list('patid', 'encounterid'))
  
  glomerular_disease_conds_raw_2 <- condition_tbl %>%
    inner_join(select(cohort_w_endpoints, patid, endpoint_date), by = "patid") %>%
    mutate(onset_date_after_endpoint = if_else(!is.na(endpoint_date) &
                                         onset_date > endpoint_date,
                                       TRUE, FALSE)) %>%
    filter(onset_date_after_endpoint == FALSE) %>% 
    inner_join(glomerular_disease_codeset, by=c('condition'='concept_code', 'condition_type'='pcornet_vocabulary_id')) %>% 
    inner_join(select(demographic_tbl, patid, site, birth_date), by=c('patid', 'site')) %>% 
    mutate(dx_cond = condition,
           dx_cond_type = condition_type,
           dx_cond_date = onset_date,
           table_source = 'condition',
           problem_list = TRUE) %>% 
    mutate(dx_date_age_in_days= as.numeric(dx_cond_date-birth_date)) %>%
    filter(
      dx_date_age_in_days < age_ub_years * 365.25,
      dx_cond_date >= min_date_cutoff,
      dx_cond_date <= max_date_cutoff
    ) %>%
    compute_new(name = "glomerular_disease_conds_2",
                indexes = list('patid', 'encounterid'))
  
  # combine all glomerular disease conditions prior to 30 from diagnosis tbl and condition tbl in one tbl
  glomerular_disease_conds_raw <- glomerular_disease_conds_raw_1 %>% 
    dplyr::union(glomerular_disease_conds_raw_2) %>% 
    mutate(dsct_dx_cond_code = paste(dx_cond_type, dx_cond, sep = '_')) %>%
    compute_new(name = "glomerular_disease_conds",
                indexes = list('patid', 'encounterid')) 
  
  # get all glomerular disease conditions, with exception of codes which require a nephrology visit
  non_neph_req_glomerular_disease_conds <- glomerular_disease_conds_raw %>%
    anti_join(neph_req_codeset, by=c('dx_cond'='concept_code', 'dx_cond_type'='pcornet_vocabulary_id')) %>%
    compute_new(name = "non_neph_req_glomerular_disease_conds",
                indexes = list('patid', 'encounterid'))
  
  # get conditions with nephrology care_site or provider for associated visit_occurrence_id 
  nephrology_visits <- neph_enc_table %>%
    inner_join(distinct(cohort, patid), by = "patid") %>% 
    distinct(encounterid) %>%
    compute_new(name = "nephrology_visits",
                indexes = list('encounterid'))

  # get table of conditions with nephrology specialty for codes which require a nephrology visit
  neph_req_conds <- glomerular_disease_conds_raw %>%
    inner_join(neph_req_codeset, by=c('dx_cond'='concept_code', 'dx_cond_type'='pcornet_vocabulary_id')) %>% 
    inner_join(nephrology_visits, by = "encounterid") %>%
    compute_new(name = "neph_req_conds",
                indexes = list('patid'))
  
  # combine all glomerular disease conditions for codes which don't require nephrology specialty
  # and those with nephrology specialty, for those that do require nephrology specialty
  glomerular_disease_conds <- non_neph_req_glomerular_disease_conds %>%
    dplyr::union(neph_req_conds) %>%
    compute_new(name = "glomerular_disease_conds",
                indexes = list('patid'))
  
  # restrict to patients who have 2 or more glomerular disease codes on different days of service
  glean_two_codes <- glomerular_disease_conds %>%
    group_by(patid, site) %>%
    summarize(n_glomerular_dx_dates = n_distinct(dx_cond_date),
              n_glomerular_dx = n_distinct(encounterid), 
              n_distinct_glomerular_dx = n_distinct(dsct_dx_cond_code)) %>% 
    ungroup() %>%
    filter(n_glomerular_dx_dates >= 2) %>%
    mutate(entry = "two_codes") %>%
    distinct(patid, site, entry, n_glomerular_dx,
             n_distinct_glomerular_dx, n_glomerular_dx_dates) %>%
    compute_new(name = "glean_two_codes",
                indexes = list('patid'))
 
  # get patients 1 or more glomerular inclusion diagnosis
  glean_one_code <- glomerular_disease_conds %>%
    group_by(patid, site) %>%
    summarize(n_glomerular_dx_dates = n_distinct(dx_cond_date),  
              n_glomerular_dx = n_distinct(encounterid),
              n_distinct_glomerular_dx = n_distinct(dsct_dx_cond_code),
              ) %>% 
    ungroup() %>%
    filter(n_glomerular_dx_dates >= 1) %>%
    distinct(patid, site, n_glomerular_dx,
             n_distinct_glomerular_dx, n_glomerular_dx_dates) %>%
    compute_new(name = "glean_one_code",
                indexes = list('patid'))
  
  # get patients 1 or more glomerular inclusion diagnosis and kidney
  # biopsy which is not post-transplant
  glean_one_code_w_biopsy <-
    get_kidney_biopsy_not_pt(
      cohort = glean_one_code,
      procedure_tbl = procedure_tbl,
      kidney_transplant_proc_codeset = kidney_transplant_proc_codeset,
      kidney_biopsy_proc_codeset = kidney_biopsy_proc_codeset,
      age_ub_years = age_ub_years 
    ) %>% 
    inner_join(select(cohort_w_endpoints, patid, endpoint_date), by = "patid") %>%
    mutate(px_date_after_endpoint = if_else(!is.na(endpoint_date) &
                                                 min_biopsy_date > endpoint_date,
                                               TRUE, FALSE)) %>%
    filter(px_date_after_endpoint == FALSE,
           min_biopsy_date >= min_date_cutoff,
           min_biopsy_date <= max_date_cutoff) %>%
    mutate(entry = "one_code_w_biopsy") %>%
    distinct(patid, site, entry, n_glomerular_dx_dates) %>%
    compute_new(name = "glean_one_code_w_biopsy",
                indexes = list('patid'))
  
  # get patients who only have codes which require the presence of another more specific code
  other_code_req_two_codes <- glomerular_disease_conds %>%
    inner_join(other_code_req_codeset, by=c('dx_cond'='concept_code', 'dx_cond_type'='pcornet_vocabulary_id')) %>% 
    group_by(patid, site) %>%
    summarize(n_other_code_req_dx_dates = n_distinct(dx_cond_date),
              n_other_code_req_dx = n_distinct(encounterid),
              n_distinct_other_code_req_dx = n_distinct(dsct_dx_cond_code)) %>%
    ungroup() %>%
    inner_join(glean_two_codes, by = "patid") %>%
    filter(n_distinct_other_code_req_dx == n_distinct_glomerular_dx) %>%
    compute_new(name = "other_code_req_two_codes",
                indexes = list('patid'))
  
  # get patients who meet criteria via two codes
  glean_patients_two_codes <- glean_two_codes %>%
    anti_join(other_code_req_two_codes, by = "patid") %>%
    compute_new(name = "glean_patients_two_codes",
                indexes = list('patid'))
  
  # get patients who meet criteria via biopsy
  glean_patients_one_code_w_biopsy <- glean_one_code_w_biopsy %>% 
    anti_join(glean_patients_two_codes, by = "patid")  %>%
    compute_new(name = "glean_patients_biopsy",
                indexes = list('patid')) 
  
  # get final glomerular disease cohort
  glean_patients <- glean_patients_two_codes %>%
    dplyr::union(glean_patients_one_code_w_biopsy) %>%
    compute_new(name = "glean_patients",
                indexes = list('patid'))
  
}

#' Get table of procedures in codeset, restricted to cohort if provided,
#' from CDM procedure table
#'
#' @param cohort Cohort
#' @param procedure_codeset procedure codeset
#'
#' @return Table of procedures in codeset, restricted to
#' cohort if provided
#'
get_procedures <- function(cohort,
                           procedure_codeset,
                           procedure_tbl = cdm_tbl('procedures'),
                           demographic_tbl = cdm_tbl('demographic')
                           ) {

  if (missing(cohort)) {
    cohort_birth_dates <- demographic_tbl %>% 
      select(patid, birth_date)
  } else {
    cohort_birth_dates <- demographic_tbl %>% 
      inner_join(select(cohort, patid), by = "patid") %>%
      select(patid, birth_date)
  }
  
  procedures <- procedure_tbl %>%
    inner_join(select(cohort_birth_dates, patid, birth_date), by = "patid") %>% 
    inner_join(procedure_codeset, by=c('px'='concept_code', 'px_type'='pcornet_vocabulary_id')) %>% 
    mutate(procedure_age_days = px_date - birth_date) 

  return(procedures)
}


#' Get kidney transplants which are not post-transplant
#'
#' @param cohort Cohort
#' @param procedure_tbl PCORnet Procedures CDM table
#' @param kidney_transplant_proc_codeset Kidney transplant procedure codeset
#' @param kidney_biopsy_proc_codeset Kidney biopsy procedure codeset
#' @param biopsy_proc_codeset Biopsy procedure codeset
#' @param age_ub_years Age upper bound
#'
#'
get_kidney_biopsy_not_pt <-
  function(cohort,
           procedure_tbl = cdm_tbl("procedures"),
           kidney_transplant_proc_codeset, 
           kidney_biopsy_proc_codeset,
           age_ub_years) {
    
    # get earliest kidney transplant before age 30
    glean_transplant <- get_procedures(
        cohort = cohort,
        procedure_codeset = kidney_transplant_proc_codeset,
        procedure_tbl = procedure_tbl) %>%  
        filter(procedure_age_days < 365.25 * age_ub_years) %>%
             group_by(patid) %>%
            summarize(min_transplant_date = min(px_date, na.rm = TRUE)) %>%
             ungroup() %>%
      compute_new(name = "glean_transplant",
                  indexes = list('patid'))
    
    # get earliest kidney biopsy before age 30
    glean_biopsy <- get_procedures(
      cohort = cohort,
      procedure_codeset = kidney_biopsy_proc_codeset,
      procedure_tbl = procedure_tbl
    ) %>%
      filter(procedure_age_days < 365.25 * age_ub_years) %>%
      group_by(patid) %>%
      summarize(min_biopsy_date = min(px_date, na.rm = TRUE)) %>%
      ungroup() %>%
      compute_new(name = "glean_biopsy",
                  indexes = list('patid'))
    
    # patients with one glomerular disease code and a kidney biopsy which is not
    # post-transplant
    glean_one_code_w_biopsy <- cohort %>%
      inner_join(glean_biopsy, by = "patid") %>%
      left_join(glean_transplant, by = "patid") %>%
      filter(is.na(min_transplant_date) |
               min_biopsy_date < min_transplant_date) 
  }


#' Get encounters associated with specialties
#'
#' @param cohort the patients for whom specialty encounters should be identified
#' @param faci_type_vs concept set with facility specialties
#' @param prov_spec_primary_vs concept set with provider specialties
#' @param encounter_table CDM encounter table
#' @param provider_table CDM provider table
#' @param min_date the minimum date cutoff for encounters
#' @param max_date the maximum date cutoff for encounters
#'
#' @returns a dataframe with encounters associated with the specialty of interest
#' 
get_spec_encounters <- function(cohort = cdm_tbl("demographic"),
                                faci_type_vs,
                                prov_spec_primary_vs,
                                encounter_table = cdm_tbl("encounter"),
                                provider_table = cdm_tbl("provider"),
                                min_date,
                                max_date) {
  
  # distinct providerids with provider_specialty_primary of interest
  providerids <- provider_table %>%
    filter(toupper(provider_specialty_primary) %in% prov_spec_primary_vs) %>%
    distinct(providerid) %>%
    compute_new()
  
  # subset encounters to cohort and date range
  subset_encounters <- encounter_table %>%
    inner_join(select(cohort, patid), by = "patid") %>%
    filter(admit_date >= min_date,
           admit_date <= max_date)
  
  # encounters with providerids with provider_specialty_primary of interest
  prov_spec_encounters <- subset_encounters %>%
    inner_join(providerids, by = "providerid") %>%
    compute_new()
  
  # encounters where facility_type is specialty of interest
  fac_spec_encounters <- subset_encounters %>%
    filter(facility_type %in% faci_type_vs) %>%
    compute_new()
  
  # combine provider- and facility- based approach to identification
  spec_encounters <- prov_spec_encounters %>%
    dplyr::union(fac_spec_encounters) %>%
    distinct() %>%
    compute_new()
}
