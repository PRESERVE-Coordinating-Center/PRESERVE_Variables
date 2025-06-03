
require(tidyr)
require(dbplyr)
require(dplyr)


#' Identify cohort with chronic dialysis 
#' The computable phenotype was developed to query patients who had undergone kidney chronic dialysis and was validated against USRDS dataset and 
#' a subset of chart review patients. 
#' The most optimial computable phenotype for identifying chronic dialysis required one code from Group A (more specific) 
#' or two distinct codes from Group B (more sensitive) and at least five eGFR measurements  ≤15 mL/min/1.73m² on different days with no time restrictions. 
#' This algorithm achieved an F1 score of 0.85 (95% CI 0.77-0.91), sensitivity of 82.5% (95% CI 72.2%-91.5%), and PPV of 86.7% (95% CI 77.1%-94.1%).
#' @param cohort_tbl Cohort table of patients meeting all PRESERVE inclusiona and exclusion criteria 
#' @param egfr_tbl pre-computed eGFR table with at least the following columns: person_id, egfr_measurement_date, egfr_value, 
#' @param min_date_cutoff Date before which visits are excluded
#' @param max_date_cutoff Date after which visits are excluded
#' @param chronic_dialysis_codeset Validated chronic dialysis codeset 
#' @param max_egfr_val Maximum eGFR value for cohort inclusion
#' @param num_egfr Minimum number of eGFR measurements for cohort inclusion
#' @param min_age Minimum age for cohort inclusion
#' @param max_age Maximum age for cohort inclusion
#' @param procedure_tbl Procedures table
#' @param demographic_tbl Demographic table
#' @param encounter_tbl Encounter table



get_chronic_dialysis_cohort <- function(cohort_tbl, 
                                        procedure_tbl = cdm_tbl("procedures"),
                                        demographic_tbl = cdm_tbl("demographic"), 
                                        encounter_tbl = cdm_tbl("encounter"),
                                        min_date_cutoff,
                                        max_date_cutoff, 
                                        min_age,
                                        max_age,
                                        chronic_dialysis_codeset = load_codeset("chronic_dialysis_cp_USRDS"),
                                        num_egfr = 5,
                                        max_egfr_val = 15){

     # patients with any chronic dialysis code within the desired time
     cohort_tbl <- cohort_tbl %>%
                        get_px(cohort = .,
                               procedure_table = procedure_tbl,
                               px_codeset = chronic_dialysis_codeset) %>%
                        filter(px_date >= min_date_cutoff,
                            px_date <= max_date_cutoff) %>%
                        compute_new()

     # filter for age at first visit
     cohort_first <- cohort_tbl %>%
        group_by(patid) %>%
        slice_min(px_date, n = 1, with_ties = FALSE) %>%
        ungroup() %>%
        inner_join(demographic_tbl %>%
                   select(patid, birth_date), by = "patid") %>%
        mutate(age_at_ced = as.numeric(difftime(px_date, birth_date, units = "days")) / 365.25) %>%
        filter(age_at_ced >= min_age,
               age_at_ced <= max_age) %>%
        compute_new()

    cohort_tbl <- cohort_tbl %>%
         inner_join(select(cohort_first, patid), by = "patid") %>%
         compute_new()

    # get first and last visit dates
    first_last_visits <- encounter_tbl %>%
                        inner_join(select(cohort_tbl, patid), by = "patid") %>%
                        group_by(patid) %>%
                        summarise(first_visit_date = min(admit_date, na.rm = TRUE),
                                last_visit_date = max(admit_date, na.rm = TRUE)) %>% ungroup() %>%
                        compute_new()

    # exclude patients with last vist date before the minimum date cutoff
    # and patients with first visit date after the maximum date cutoff
    first_last_visits <- first_last_visits %>%
       filter(last_visit_date >= min_date_cutoff, 
              first_visit_date >= max_date_cutoff) %>%
       compute_new()

    cohort_tbl <- cohort_tbl %>% 
                inner_join(first_last_visits, by = "patid") %>%
                compute_new()

    # patients with at least 1 code in group A
    group_A <- cohort_tbl %>%
         filter(group == "A") %>%    
         distinct(patid)

    # patients with at least 2 codes in group B on 2 separate visits
    # AND at least five eGFR measurements  ≤15 mL/min/1.73m² on different days with no time restrictions
    group_B <- cohort_tbl %>%
               filter(group == "B") %>%
               group_by(patid) %>%
               summarise(n_px = n_distinct(px_date)) %>% ungroup() %>%
               filter(n_px >= 2) %>%
               inner_join(egfr_tbl, by = "patid") %>%
               compute_new()
    
    if (!is.na(max_egfr_val)) {
       group_B <- group_B %>%
              filter(egfr_value <= max_egfr_val) %>%
              group_by(patid) %>%
              summarise(n_egfr = n_distinct(egfr_measurement_date)) %>% ungroup() %>%
              filter(n_egfr >= num_egfr) %>% 
              distinct(patid) %>%
              compute_new()}

    group_A %>%
       dplyr::union(group_B) %>%  
       distinct(patid) %>%
       compute_new() %>%
       return()                              
}

#' Get procedures in codeset
#'
#' @param cohort Cohort of interest: preserve cohort
#' @param procedure_table PCORnet procedures table
#' @param px_codeset Procedure codeset - must contain fields concept_code and pcornet_vocabulary_id
#'
#' @return Procedures in codeset
#'
get_px <- function(cohort = cdm_tbl("demographic"),
                   procedure_table = cdm_tbl("procedures"),
                   px_codeset) {
  tbl <- procedure_table %>%
    inner_join(select(cohort, patid), by = "patid") 
  if("type" %in% colnames(px_codeset)){
    tbl <- tbl %>% inner_join(select(px_codeset, concept_code, pcornet_vocabulary_id, type),
               by = c("px" = "concept_code",
                      "px_type" = "pcornet_vocabulary_id"))
  } else {
    tbl <- tbl %>% inner_join(select(px_codeset, concept_code, pcornet_vocabulary_id),
               by = c("px" = "concept_code",
                      "px_type" = "pcornet_vocabulary_id"))
  }
}