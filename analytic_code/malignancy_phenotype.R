
#' Get records associated with malignant diagnoses & drug exposures
#'
#' @param cohort Cohort of patients for which malignancy cohort should be define
#' @param dx_cancer concept set with cancer diagnosese
#' @param rx_cancer_therapy concept set with cancer therapy drugs
#' @param min_date the minimum date after which records should be identified
#' @param max_date the maximum date before which records should be identified
#' @param endpoint_tbl table with patient-specific endpoints (i.e. USRDS kidney transplant)
#'
#' @returns a table with patients who have evidence of either a cancer diagnosis or a cancer
#' therapy drug, with the IDs and dates associated with these events
#' 
get_cancer_records <- function(cohort,
                               dx_cancer,
                               rx_cancer_therapy,
                               min_date = '2009-01-01',
                               max_date = '2020-12-31',
                               endpoint_tbl) {
  
  cohort_w_endpoints <- cohort %>%
    left_join(select(endpoint_tbl, patid, endpoint_date), by = "patid")
  
  rx_cancer <- get_drug_exposures(cohort = cohort,
                                  drug_codeset = rx_cancer_therapy) %>%
    select(patid, encounterid, record_id = drug_record_id, date = drug_date, table) %>%
    filter(date >= min_date & date <= max_date) %>%
    compute_new()
  
  dx_cond_cancer <- get_dx_conds(cohort = cohort,
                                 dx_codeset = dx_cancer) %>%
    select(patid, encounterid, record_id, date = dx_cond_date, table) %>%
    filter(date >= min_date & date <= max_date) %>%
    compute_new()
  
  rx_cancer %>% dplyr::union(dx_cond_cancer) %>%
    inner_join(select(cohort_w_endpoints, patid, endpoint_date), by = "patid") %>%
    mutate(date_after_endpoint = if_else(!is.na(endpoint_date) &
                                         date > endpoint_date,
                                       TRUE, FALSE)) %>%
    filter(date_after_endpoint == FALSE) %>% 
    return()
  
}

# Malignancy cohort definition (revised)
# Patients can enter the cohort via 3 pathways:
# (A) >=2 cancer diagnoses separated by >=90 days, OR
# (B) (>=2 chemotherapy exposures separated by >=90 days AND
#      >=1 cancer diagnosis associated with a chemotherapy exposure), OR
# (C) (>=1 diagnoses and >=1 chemotherapy exposure separated by >=90 days AND
#      >=1 cancer diagnosis associated with a chemotherapy exposure)
# In the function, pathways are applied hierarchically
# If meets criteria for (A) --> classified as (A)
# If does not meet criteria for (A) and meets criteria for (B) --> classified as (B)
# If does not meet criteria for (A) and (B) and meets criteria for (C) --> classified as (C)
#'
#' @param cohort Cohort of patients for which malignancy cohort should be defined
#' @param cancer_records Precomputed records for cancer diagnoses or chemotherapy exposures
#'
#' @return Cohort of patients meeting criteria, with some metadata about number of qualifying records
#' and pathway into cohort
#' 
apply_cancer_phenotype <- function(cohort,
                                   cancer_records){
  
  # Diagnosis records
  cancer_records_dx <- cancer_records %>%
    inner_join(select(cohort, patid), by = "patid") %>% 
    filter(table %in% c("diagnosis", "condition")) %>% 
    compute_new()
  
  # Chemotherapy records
  cancer_records_rx <- cancer_records %>%
    inner_join(select(cohort, patid), by = "patid") %>% 
    filter(table %in% c("med_admin", "prescribing", "dispensing"))  %>% 
    compute_new()
  
  # (A) >=2 cancer diagnoses separated by >=90 days
  dx2 <- cancer_records_dx %>% 
    group_by(patid) %>% 
    summarize(min_date = min(date, na.rm = TRUE),
              max_date = max(date, na.rm = TRUE),
              days_sep = max(date, na.rm = TRUE) - min(date, na.rm = TRUE),
              n_dates = n_distinct(date)) %>% 
    ungroup() %>% 
    filter(days_sep >= 90) %>% 
    mutate(pathway = "2dx") %>% 
    compute_new()
  
  # Identify diagnoses associated with a chemotherapy exposure (using either same date or encounterid)
  dx_rx_encounterid <- cancer_records_dx %>%
    inner_join(
      cancer_records_rx,
      by = c("patid", "encounterid"), # join on encounterid
      suffix = c("_dx", "_rx")
    ) %>%
    filter(!is.na(encounterid)) %>% # remove missing encounterids (spurious)
    mutate(encounterid_dx = encounterid,
           encounterid_rx = encounterid)
  dx_rx_date <- cancer_records_dx %>%
    inner_join(cancer_records_rx,
               by = c("patid", "date"), # join on date
               suffix = c("_dx", "_rx")) %>%
    filter(!is.na(date)) %>% # remove missing dates (spurious)
    mutate(date_dx = date,
           date_rx = date)
  dx_rx_associated <- dx_rx_encounterid %>% 
    union(dx_rx_date) %>% 
    compute_new()
  
  # (B) (>=2 chemotherapy exposures separated by >=90 days AND
  #      >=1 cancer diagnosis associated with a chemotherapy exposure)
  rx2 <- cancer_records_rx %>%
    anti_join(dx2, by = "patid") %>% # remove patients meeting criteria for (A)
    group_by(patid) %>%
    summarize(min_date = min(date, na.rm = TRUE),
              max_date = max(date, na.rm = TRUE),
              days_sep = max(date, na.rm = TRUE) - min(date, na.rm = TRUE),
              n_dates = n_distinct(date)) %>%
    ungroup() %>%
    filter(days_sep >= 90) %>%
    # require >=1 cancer diagnosis associated with a chemotherapy exposure
    inner_join(select(dx_rx_associated, patid), by = "patid") %>%
    mutate(pathway = "2rx") %>%
    compute_new()
  
  # (C) (>=1 diagnoses and >=1 chemotherapy exposure separated by >=90 days AND
  #      >=1 cancer diagnosis associated with a chemotherapy exposure)
  rxdx <- cancer_records_rx %>%
    union(cancer_records_dx) %>%
    anti_join(dx2, by = "patid") %>% # remove patients meeting criteria for (A)
    anti_join(rx2, by = "patid") %>% # remove patients meeting criteria for (B)
    group_by(patid) %>% 
    summarize(
      min_date = min(date, na.rm = TRUE),
      max_date = max(date, na.rm = TRUE),
      days_sep = max(date, na.rm = TRUE) - min(date, na.rm = TRUE),
      n_dates = n_distinct(date)
    ) %>%
    ungroup() %>%
    filter(days_sep >= 90) %>%
    # require >=1 cancer diagnosis associated with a chemotherapy exposure
    inner_join(select(dx_rx_associated, patid), by = "patid") %>%
    mutate(pathway = "1dx1rx") %>%
    compute_new()
  
  # Combine pathways
  cancer_phenotype <- dx2 %>%
    union(rx2) %>%
    union(rxdx) %>%
    compute_new()
  
  return(cancer_phenotype)
  
}


#' Get diagnoses from diagnosis and condition tables in PCORnet CDM 
#'
#' @param cohort the cohort of patients form whom the diagnosis should be identified
#' @param dx_codeset the diagnosis concept set of interest
#' @param dx_tbl the CDM diagnosis table
#' @param cond_tbl the CDM condition table
#'
#' @returns a table with all occurrences of the diagnosis concepts in both the diagnosis
#' and condition tables for the cohort of interest
#' 
get_dx_conds <- function(cohort,
                         dx_codeset,
                         dx_tbl = cdm_tbl("diagnosis"),
                         cond_tbl = cdm_tbl("condition")) {
  dx <- dx_tbl %>%
    inner_join(cohort, by = "patid") %>%
    inner_join(dx_codeset,
               by = c("dx" = "concept_code",
                      "dx_type" = "pcornet_vocabulary_id")) %>%
    mutate(
      dx_cond = dx,
      dx_cond_type = dx_type,
      dx_cond_date = coalesce(admit_date, dx_date),
      record_id = diagnosisid,
      table = "diagnosis",
      problem_list = FALSE
    ) %>%
    select(patid,
           encounterid,
           record_id,
           dx_cond,
           dx_cond_type,
           dx_cond_date,
           table,
           problem_list) %>%
    compute_new()
  
  cond <- cond_tbl %>%
    inner_join(cohort, by = "patid") %>%
    inner_join(
      dx_codeset,
      by = c("condition" = "concept_code",
             "condition_type" = "pcornet_vocabulary_id")
    ) %>%
    mutate(
      dx_cond = condition,
      dx_cond_type = condition_type,
      dx_cond_date = onset_date, # check
      record_id = conditionid,
      table = "condition",
      problem_list = TRUE
    ) %>%
    select(patid,
           encounterid,
           record_id,
           dx_cond,
           dx_cond_type,
           dx_cond_date,
           table,
           problem_list) %>%
    compute_new()

  dx %>% dplyr::union(cond) %>% return()
  
}


#' Get drug exposures within PCORnet CDM using drug codeset
#'
#' This function uses a drug codeset and looks within each drug CDM table for 
#' occurrences of that code for a given cohort. The following logic was used for
#' each drug CDM table in order to determine the field used for `drug_date` in 
#' the returned table.
#' 
#' • Prescribing: RX_ORDER_DATE > RX_START_DATE 
#' • Med_admin: MEDADMIN_START_DATE > MEDADMIN_STOP_DATE  
#' • Dispensing: DISPENSE_DATE 
#' 
#'
#' @param cohort cohort table with `patid`
#' @param drug_codeset drug codeset of interest
#' @param prescribing_tbl PCORnet prescribing CDM table
#' @param med_admin_tbl PCORnet med_admin CDM table
#' @param dispensing_tbl PCORnet dispensing CDM table
#'
#' @return table with all occurrences of drug codes of interest found within 
#'         each drug table for cohort

get_drug_exposures <- function(cohort,
                               drug_codeset,
                               prescribing_tbl = cdm_tbl("prescribing"),
                               med_admin_tbl = cdm_tbl("med_admin"),
                               dispensing_tbl = cdm_tbl("dispensing")) {
  
  # Look within the prescribing table
  prescribing_records <- prescribing_tbl %>%
    inner_join(drug_codeset, by = c("rxnorm_cui" = "concept_code")) %>%
    inner_join(cohort, by = "patid") %>%
    mutate(drug_record_id = prescribingid,
           drug_date = coalesce(rx_order_date, rx_start_date),
           table = "prescribing") %>%
    select(patid, encounterid, drug_record_id, drug_date, starts_with("category"), starts_with("table")) %>%
    compute_new(indexes = list('patid'))
  
  # Look within the med_admin table
  med_admin_records <- med_admin_tbl %>%
    inner_join(drug_codeset, by = c("medadmin_code" = "concept_code",
                                    "medadmin_type" = "pcornet_vocabulary_id")) %>%
    inner_join(cohort, by = "patid")  %>%
    mutate(drug_record_id = medadminid,
           drug_date = coalesce(medadmin_start_date, medadmin_stop_date),
           table = "med_admin") %>%
    select(patid, encounterid, drug_record_id, drug_date, starts_with("category"), starts_with("table")) %>%
    compute_new(indexes = list('patid'))
  
  # Look within the dispensing table
  dispensing_records <- dispensing_tbl %>%
    inner_join(drug_codeset, by = c("ndc" = "concept_code")) %>%
    inner_join(cohort, by = "patid") %>%
    mutate(drug_record_id = dispensingid,
           drug_date = dispense_date,
           table = "dispensing",
           encounterid = NA) %>%
    select(patid, encounterid, drug_record_id, drug_date, starts_with("category"), starts_with("table")) %>%
    compute_new(indexes = list('patid'))
  
  # Combine all occurrences found in each table into one master table
  drug_records <- prescribing_records %>% 
    dplyr::union(med_admin_records) %>% 
    dplyr::union(dispensing_records) %>% 
    distinct() %>% 
    compute_new(indexes = list('patid'))
  
  return(drug_records)
}