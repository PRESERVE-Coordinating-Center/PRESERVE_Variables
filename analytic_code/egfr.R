#' eGFR Computation  
#' 
#' Makes a table of egfr values for the cohort of interest; 
#' written to be functional within the pcornet data model
#' 
#' @param cohort A table consisting of at least patid
#' @param heights_cleaned A table with height values cleaned using the Daymont algorithm 
#'                        (output of `daymont_algorithm_data_cleaning()`)
#' @param lab_tbl [default=cdm_tbl('lab_result_cm')] A table of lab_results, defaults to pcornet lab_result_cm table
#' @param min_date [default=01/01/2009] The earliest date to pull in height or serum creatinine values
#' @param max_date [default=12/31/2022] The latest date to pull in height or serum creatinine values
#' @param serum_creatinine_codeset A serum creatinine codeset
#' @param max_serum_creatinine [default=50] The maximum value of a serum creatinine measurement that will be fed forward to egfr derivations
#' @param demo_tbl [default=cdm_tbl('demographics')] The pcornet demographics table
#' @param min_age [default=1] The minimum age at which a serum creatinine measure can be used in an egfr derivation
#' @param max_age [default=18] The maximum age at which a serum creatinine measure can be used in an egfr derivation
#' @param bounds [default=TRUE] a boolean indicator of whether bounding limits should be imposed on egfr derivations
#' @param bounds_tbl A table that contains, at minimum, columns for age and k coefficient.
#'                   If bounds = TRUE, also requires columns bounding serum creatinine and height values by age
#' @param height_conversion_factor [default=0.0254] constant to convert unit of measurement for height from the 
#'                                                  existing unit (default = inches) to meters
#' @param max_days_sep [default=180] The maximum days of separation between a height measurement and a serum creatinine measurement
#' 
#' 
make_egfr_cohort <- function(cohort,
                             heights_cleaned,
                             lab_tbl=cdm_tbl('lab_result_cm'),
                             min_date=as.Date("2009-01-01"), 
                             max_date=as.Date("2022-12-31"),
                             serum_creatinine_codeset,
                             max_serum_creatinine=50,
                             demo_tbl=cdm_tbl("demographic"),
                             min_age=1, 
                             max_age=18,
                             bounds=TRUE,
                             bounds_tbl,
                             height_conversion_factor=0.0254,
                             max_days_sep=180) 
{
  
  serum_creatinine_raw <- cohort %>%
    distinct(patid) %>% 
    inner_join(lab_tbl,by='patid') %>%
    select(
      patid, specimen_date, result_date, lab_order_date,
      lab_loinc, result_num, result_unit, norm_range_high,
      norm_modifier_high, raw_lab_code,
      raw_result, specimen_source, norm_modifier_low,
      norm_range_low, result_modifier, result_qual,
      result_snomed, lab_result_cm_id
    ) %>%
    mutate(comb_lab_date = coalesce(
      specimen_date, result_date,
      lab_order_date
    )) %>%
    filter(between(
      comb_lab_date,
      min_date,
      max_date
    )) %>%
    inner_join(serum_creatinine_codeset,
               by = c("lab_loinc" = "concept_code")
    ) %>%
    compute_new()
  
  if (bounds) {
    serum_creatinine_raw <- serum_creatinine_raw %>%
      filter(result_num <= max_serum_creatinine) %>%
      compute_new()
  }
  
  serum_creatinine <- demo_tbl %>%
    inner_join(select(cohort, patid), by = "patid") %>% 
    select(patid, birth_date, sex) %>%
    inner_join(serum_creatinine_raw,
               by = "patid"
    ) %>%
    mutate(age_at_measurement = round((comb_lab_date - birth_date) / 365.25,2),
           age_floor=floor(age_at_measurement)) %>%
    filter(((comb_lab_date - birth_date) / 365.25)>=min_age & 
             ((comb_lab_date - birth_date) / 365.25) < max_age) %>% # >=1 <18
    compute_new()
  
  heights_combined <- heights_cleaned %>%
    inner_join(distinct(cohort, patid), by = "patid") %>% 
    inner_join(serum_creatinine, by = "patid") %>% 
    mutate(days_sep = abs(height_date - comb_lab_date)) %>%
    filter(days_sep<=max_days_sep) %>%
    compute_new()
  
  heights <- heights_combined %>%
    select(
      lab_result_cm_id,
      ht,
      result_num,
      age_at_measurement,
      age_floor,
      sex,
      patid,
      site,
      comb_lab_date,
      height_date,
      days_sep
    ) %>%
    group_by(patid, lab_result_cm_id) %>%
    window_order(days_sep, height_date) %>%
    filter(row_number() == 1) %>%
    ungroup() %>%
    compute_new()
  
  if (bounds) {
    heights <- heights %>%
      inner_join(distinct(cohort, patid), by = c("patid")) %>% 
      inner_join(bounds_tbl,
                 by = c("sex" = "sex", "age_floor" = "age")
      ) %>%
      filter(
        between(ht * height_conversion_factor, height_meters_lower, height_meters_upper),
        result_num <= serum_creatinine_upper
      ) %>%
      select(-c(
        "k_coeff", "serum_creatinine_upper", "serum_creatinine_lower",
        "height_meters_upper", "height_meters_lower"
      )) %>%
      compute_new()
  }
  
  egfr_tbl <- derive_egfr(heights, bounds_tbl,
                          height_col = "ht", ser_creat_col = "result_num",
                          join_keys=c('sex'='sex','age_floor'='age'), 
                          height_conversion_factor = height_conversion_factor
  ) %>% rename(egfr_date=comb_lab_date)
  bounds_str <- ''
  if (bounds) {
    bounds_str <- '_bounded'
  }
  rv <- egfr_tbl
  return(rv)
}

#' Derive eGFR from age, height, sex, and serum creatinine values
#' 
#' @param full_tbl
#' @param bounds_tbl A table that contains, at minimum, columns for age and k coefficient.
#' @param join_keys A vector indicating the columns by which full_tbl and bounds_tbl should be joined
#' @param age_cont A string indicating the name of the column containing age as an integer
#' @param height_col A string indicating the name of the column containing numeric height values
#'                   
#'                   NOTE: height values should all be the same unit, and should be able to be converted to
#'                   a new unit using height_conversion_factor (if necessary)
#' @param ser_creat_col A string indicating the name of the column containing numeric serum 
#'                      creatinine values -- all values are assumed to be in mg/dl
#' @param height_conversion_factor constant to convert unit of measurement for height from the 
#'                                 existing unit (default = inches) to meters
#'                                 
#'                                 defaults to 1 for no conversion
#' 
#' 
derive_egfr <- function(full_tbl,
                        bounds_tbl,
                        join_keys = c('sex' = 'sex', 'age_floor' =
                                        'age'),
                        age_cont = 'age_at_measurement',
                        height_col = 'ht',
                        ser_creat_col = 'serum_creatinine_num',
                        height_conversion_factor = 1) {
  full_tbl %>%
    filter(!!sym(height_col) > 0 & !!sym(ser_creat_col) > 0) %>%
    left_join(bounds_tbl, by = join_keys) %>%
    mutate(
      k_coeff_exact = case_when(
        sex == "M" &
          !!sym(age_cont) >= 1 &
          !!sym(age_cont) < 12 ~ 39.0 * (1.008 ^ (!!sym(age_cont) - 12)),
        sex == "M" &
          !!sym(age_cont) >= 12 &
          !!sym(age_cont) < 18 ~ 39.0 * (1.045 ^ (!!sym(age_cont) - 12)),
        sex == "M" &
          !!sym(age_cont) >= 18 ~ 50.8,
        sex == "F" &
          !!sym(age_cont) >= 1 &
          !!sym(age_cont) < 12 ~ 36.1 * (1.008 ^ (!!sym(age_cont) - 12)),
        sex == "F" &
          !!sym(age_cont) >= 12 &
          !!sym(age_cont) < 18 ~ 36.1 * (1.023 ^ (!!sym(age_cont) - 12)),
        sex == "F" &
          !!sym(age_cont) >= 18 ~ 41.4
      ),
      height_meters = !!sym(height_col) * height_conversion_factor,
      egfr = k_coeff_exact * (height_meters / !!sym(ser_creat_col)),
    )
}




#' Clean height and weight data with Daymont algorithm
#' 
#' This function requires the growthcleanr package
#' https://carriedaymont.github.io/growthcleanr/index.html
#'
#' @param cohort A table with at least a patid column identifying cohort members
#' @param demo_tbl table with demographic information, at minumum sex and birth_date
#'                 defaults to the PCORnet CDM demographics table
#' @param vitals_tbl table with height & weight values, including the date of measurement
#'                   defaults to the PCORnet CDM vitals table
#' @param ht_lag an integer value identifying the lag cutoff for height values
#'               defaults to 90
#' @param wt_lag an integer value identifying the lag cutoff for weight values
#'               defaults to 30
#'
#' @returns table with cleaned height and weight values output by
#'          `growthcleanr::cleangrowth`
#'          
#'          should be used as the `heights_cleaned` input for
#'          `make_egfr_cohort()`
#' 
daymont_algorithm_data_cleaning <- function(cohort,
                                            demo_tbl = cdm_tbl('demographics'),
                                            vitals_tbl = cdm_tbl('vital'),
                                            ht_lag = 90,
                                            wt_lag = 30){
  
  cohort_w_demo <- demo_tbl %>%
    inner_join(cohort %>% select(patid)) %>%
    select(patid, birth_date_sex) %>%
    compute_new()
  
  pull_data <-
    vitals_tbl %>%
    dplyr::select(patid, measure_date,ht,wt) %>%
    inner_join(cohort_w_demo, copy=TRUE) %>%
    mutate(agedays=measure_date-birth_date) %>%
    pivot_longer(c(ht,wt)) %>%
    filter(!is.na(value)) %>%
    collect_new()
  
  pull_data<- pull_data %>%
    mutate(param=case_when(name=="ht"~"HEIGHTIN",TRUE~"WEIGHTLBS")) %>%
    group_by(patid) %>%
    arrange(patid, param,agedays)
  
  clean_data <-
    cleangrowth(subjid=pull_data$patid,
                param=pull_data$param,
                agedays=pull_data$agedays,
                sex=pull_data$sex,
                measurement=pull_data$value,
                parallel=TRUE,
                num.batches=4)
  
  pull_data$cleaning <- clean_data
  
  include_data <-
    pull_data %>%
    filter(cleaning == "Include") %>%
    dplyr::select(patid, agedays, value, name) %>%
    compute_new() 
  
  carry_data <-
    pull_data %>%
    filter(cleaning == "Exclude-Carried-Forward") %>%
    dplyr::select(patid, day2 = agedays, value, name)  %>%
    compute_new() 
  
  window_carry <-
    inner_join(include_data, carry_data) %>%
    filter(day2 >= agedays) %>%
    mutate(lag = day2 - agedays) %>%
    mutate(keep_carry_forward = case_when (name=="ht" & lag <= ht_lag ~1,
                                           name=="wt" & lag <= wt_lag ~1,
                                           TRUE~0)) %>%
    group_by(patid, day2, value, name) %>%
    summarise(keep_carry_forward=max(keep_carry_forward)) %>% 
    #using max  means if kept for one included measure but dropped for another, measure kept period
    ungroup() %>%
    rename(agedays=day2) %>%
    compute_new() 
  
  final_cleaned_data <- pull_data %>%
    left_join(window_carry) %>%
    mutate(preserve_include=case_when(cleaning=="Include"~TRUE,
                                      keep_carry_forward==1~TRUE, 
                                      TRUE~FALSE ))
  
  return(final_cleaned_data)
  
}
