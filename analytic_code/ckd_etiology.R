
#' Identify CKD Etiology Categories for Target Trial Emulation Analysis
#' 
#' @param base_cohort - full cohort of patients with at least site & patid columns
#' @param cancer_cohort - cohort of patients meeting the requirements for the cancer phenotype
#'                        [link to cancer phenotype]
#' @param glom_cohort - cohort of patients meeting the requirements for the glomerular disease phenotype
#'                      [link to glomarular phenotype]
#' @param renal_related_dx - concept set containing renal related diagnoses
#' @param min_date - string identifying the column in base_cohort with the minimum date cutoff
#' @param max_date - string identifying column in base_cohort with the maximum date cutoff
#' @param category_levels - an integer defining the number of levels that should be output in the final
#'                          etiology categorization. accepted values are 2, 3, or 4
#'                          
#'                          *2*
#'                          1. Glomerular Disease
#'                          2. Non-Glomerular
#'                          
#'                          *3*
#'                          1. Malignancy
#'                          2. Glomerular Disease
#'                          3. Other
#'                          
#'                          *4*
#'                          1. Malignancy
#'                          2. Glomerular Disease
#'                          3. Other kidney disease
#'                          4. Other & Non-Specific
#'
#' @return table summarizing which patients meet criteria each hierarchy level, based
#' on the requested summarization level specified by category_levels
#' 
find_ckd_etiology_tte <- function(base_cohort,
                                  cancer_cohort,
                                  glom_cohort,
                                  renal_related_dx = load_codeset('dx_renal_related'),
                                  min_date = 'tte_baseline_date',
                                  max_date = 'fu_minus_one',
                                  category_levels = 2){
  
  # Glomerular disease
  glom <- glom_cohort %>%
    inner_join(base_cohort) %>%
    distinct(patid) %>%
    mutate(glomerular_disease = TRUE)
  
  # Cancer
  cancer <- cancer_cohort %>%
    inner_join(base_cohort) %>%
    distinct(patid) %>%
    mutate(cancer = TRUE)
  
  # Other renal
  dx <- get_dx_conds(cohort = base_cohort,
                     dx_codeset = renal_related_dx) %>%
    left_join(base_cohort) %>%
    filter(dx_cond_date >= !!sym(min_date) & dx_cond_date <= !!sym(max_date))
  
  # Only 1 dx required
  dx_renal <- dx %>%
    distinct(patid) %>%
    mutate(dx_renal_related = TRUE) %>%
    compute_new()
  
  # Combined
  semifinal <- base_cohort %>%
    left_join(glom) %>%
    left_join(dx_renal) %>%
    left_join(cancer) %>%
    collect_new() %>%
    mutate(across(where(is.logical), ~replace(., is.na(.), FALSE))) %>%
    mutate(other = case_when(glomerular_disease == FALSE &
                               cancer == FALSE &
                               dx_renal_related == FALSE ~ TRUE,
                             TRUE ~ FALSE))
  
  if(category_levels == 2){
    
    final <- semifinal %>%
      mutate(final_etiology = case_when(glomerular_disease == TRUE ~ 'Glomerular Disease',
                                        TRUE ~ 'Non-Glomerular'))
  }else if(category_levels == 3){
    
    final <- semifinal %>% 
      mutate(int_etiology = case_when(cancer == TRUE ~ 'Malignancy',
                                    glomerular_disease == TRUE ~ 'Glomerular Disease',
                                    dx_renal_related == TRUE ~ 'Other kidney disease',
                                   other == TRUE ~ 'Other & Non-Specific'),
             final_etiology = case_when(grepl('Other', int_etiology) ~ 'Other',
                                         TRUE ~ int_etiology))
  }else if(category_levels == 4){
    
    final <- semifinal %>% 
      mutate(final_etiology = case_when(cancer == TRUE ~ 'Malignancy',
                                        glomerular_disease == TRUE ~ 'Glomerular Disease',
                                        dx_renal_related == TRUE ~ 'Other kidney disease',
                                        other == TRUE ~ 'Other & Non-Specific'))
    
  }

  return(final)
  
}