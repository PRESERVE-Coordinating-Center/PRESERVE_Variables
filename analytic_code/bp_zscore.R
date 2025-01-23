
#' Compute Blood Pressure Z-Score -- Mitsnefes/Maltenfort Method
#'
#' https://pubmed.ncbi.nlm.nih.gov/37988770/
#'
#' @param bp_tbl a table with at least the following columns:
#'               - `patid`: the person identifier for the cohort member
#'               - `sex`: either *M* or *F*
#'               - `bp_type`: string identifying the type of blood pressure measurement
#'                          either *systolic* or *diastolic* CASE SENSITIVE
#'               - `bp`: the numeric blood pressure value
#'               - `measure_date`: the date on which the blood pressure measurement was taken
#'               - `birth_date`: the birth date of the patient
#'               - `height_z`: the height z-score associated with the blood pressure measurement
#'                             can be computed and matched to a BP value with *compute_height_z* + 
#'                             *reformat_BP_htz*
#'
#' @returns a table with the computed BP Z-Score value and some of the associated metadata
#' 
compute_bpz_mm <- function(bp_tbl) {
  params <- tribble(
    ~sex, ~bp_type, ~Intercept, ~`I(age10)`, ~`I(age10^2)`, ~`I(age10^3)`, ~`I(age10^4)`, ~`I(height_z)`, ~`I(height_z^2)`, ~`I(height_z^3)`, ~`I(height_z^4)`, ~sd__Observation, ~sd__Intercept, ~sd__age10, ~sd__height_z, ~cor__Intercept.age10, ~cor__Intercept.height_z, ~cor__age10.height_z,
    "F", "systolic", 103.970610975827, 1.64755776974921, 0, -0.00672854936027804, -0.000304445721417763, 0.982775921614132, 0.0700148212162216, 0, 0, 7.65618196100167, 5.02626404695056, 0.495786808711336, 1.00907755650047, 0.347301151089185, -0.0438939634213447, -0.00831989703701446,
    "M", "systolic", 103.813165414558, 1.73361093417982, 0.122865372703926, -0.000680228403270637, -0.00149262751588901, 1.24648445144301, 0, -0.02798685938599, 0.0145394234636759, 7.7668492380853, 5.03382723203088, 0.533416731134191, 1.21332496513462, 0.348769779023855, -0.000699532919060102, 0.125593847935152,
    "F", "diastolic", 62.4175056948638, 0.72470805379935, -0.00411259130419403, -0.00125858316711285, 0.00010093708937658, 0.370921898995395, 0, 0, 0.00410451358945263, 6.04074129850983, 3.34872609310043, 0.452819518316222, 0.800219885567322, 0.227962461614995, -0.0796808572848491, 0.097529826610063,
    "M", "diastolic", 62.2250773400853, 0.679848858931832, -0.0132139847486287, -0.000331687777961079, 0.00038557852325833, 0.360497215264303, 0, 0, 0.0071988459815278, 6.1237444560795, 3.28489191426022, 0.468796616085828, 0.773108791464125, 0.209282231809696, -0.0569401952308633, 0.0834302520876097
  )
  
  rslt <-
    bp_tbl %>%
    inner_join(params) %>%
    mutate(age_yrs = (as.numeric(measure_date - birth_date)) / 365.25) %>%
    mutate(age10 = age_yrs - 10.0) %>%
    mutate(
      pred_bp =
        Intercept +
        `I(age10)` * age10 + `I(age10^2)` * age10^2 + `I(age10^3)` * age10^3 + `I(age10^4)` * age10^4 +
        `I(height_z)` * height_z + `I(height_z^2)` * height_z^2 + `I(height_z^3)` * height_z^3 + `I(height_z^4)` * height_z^4
    ) %>%
    mutate(
      random_var =
        sd__Intercept^2 +
        (age10 * sd__age10)^2 +
        (height_z * sd__height_z)^2 +
        2 * cor__Intercept.age10 * sd__Intercept * sd__age10 * age10 +
        2 * cor__Intercept.height_z * sd__Intercept * sd__height_z * height_z +
        2 * cor__age10.height_z * sd__height_z * sd__age10 * height_z * age10
    ) %>%
    mutate(total_sd = sqrt(random_var + sd__Observation^2)) %>%
    mutate(z_score_mm = (bp - pred_bp) / total_sd) %>%
    mutate(fixed_sd = sd__Observation, random_sd = sqrt(random_var))
  
  rslt %>%
    dplyr::select(patid, sex, #ce_date, 
                  birth_date, age_yrs, age10, 
                  measure_date, bp_type, bp, pred_bp_mm, height_z, 
                  total_sd, z_score_mm)
}


#' Compute Blood Pressure Z-Score -- 4th Report Method
#' 
#' https://publications.aap.org/pediatrics/article/114/Supplement_2/555/28840/The-Fourth-Report-on-the-Diagnosis-Evaluation-and?autologincheck=redirected
#'
#' @param bp_tbl a table with at least the following columns:
#'               - `patid`: the person identifier for the cohort member
#'               - `sex`: either *M* or *F*
#'               - `bp_type`: string identifying the type of blood pressure measurement
#'                            either *systolic* or *diastolic* CASE SENSITIVE
#'               - `bp`: the numeric blood pressure value
#'               - `measure_date`: the date on which the blood pressure measurement was taken
#'               - `birth_date`: the birth date of the patient
#'               - `height_z`: the height z-score associated with the blood pressure measurement
#'                             can be computed and matched to a BP value with *compute_height_z* + 
#'                             *reformat_BP_htz*
#'                             
#' @returns a table with the computed BP Z-Score value and some of the associated metadata
#' 
compute_bpz_fourth_report <- function(bp_tbl){
  
  params <-
    tribble(
      ~sex, ~SAexp, ~SB1, ~SB2, ~SB3, ~SB4, ~SG1, ~SG2, ~SG3, ~SG4, ~SSIG, ~DAexp, ~DB1, ~DB2, ~DB3, ~DB4, ~DG1, ~DG2, ~DG3, ~DG4, ~DSIG,
      "M", 102.19768, 1.82416, 0.12776, 0.00249, -0.00135, 2.73157, -0.19618, -0.04659, 0.00947, 10.7128, 61.01217, 0.68314, -0.09835, 0.01711, 0.00045, 1.46993, -0.07849, -0.03144, 0.00967, 11.6032,
      "F", 102.01027, 1.94397, 0.00598, -0.00789, -0.00059, 2.03526, 0.02534, -0.01884, 0.00121, 10.4855, 60.50510, 1.01301, 0.01157, 0.00424, -0.00137, 1.16641, 0.12795, -0.03869, -0.00079, 10.9573
    ) %>%
    pivot_longer(cols = -sex) %>%
    mutate(bp_type = case_when(grepl("^S", name) ~ "systolic", TRUE ~ "diastolic")) %>%
    mutate(name = substr(name, 2, 20)) %>%
    pivot_wider(id_cols = c(sex, bp_type))
  
  rslt <-
    bp_tbl %>%
    inner_join(params) %>%
    mutate(age_yrs = (as.numeric(measure_date - birth_date)) / 365.25) %>%
    mutate(age_yrs = case_when(age_yrs > 18.0~18.0, TRUE~age_yrs)) %>%
    mutate(age10 = age_yrs - 10.0) %>%
    mutate(pred_bp = Aexp + B1 * age10 + B2 * age10**2 + B3 * age10**3 + B4 * age10**4 +
             G1 *height_z + G2 *height_z**2 + G3 *height_z**3 + G4 *height_z**4) %>%
    mutate(z_score_4th = (bp - pred_bp) / SIG) 
  
  rslt %>%
    dplyr::select(patid, sex, #ce_date, 
                  birth_date, age_yrs, age10, 
                  measure_date, bp_type, bp, pred_bp_4th, height_z, 
                  total_sd, z_score_4th)
}

#' Compute the height z-scores for all patients in the cohort
#' 
#' This function requires the `childsds` package to access CDC reference materials
#' https://cran.r-project.org/web/packages/childsds/childsds.pdf
#'
#' @param height_tbl table with all collected heights of cohort members extracted from the vitals table
#' @param person_tbl table with patid, birth_date, and sex of all cohort members
#'
#' @return table with the height z-scores for each collected height measurement of each patient in the cohort, 
#'         with columns: patid, ht, age, height_date, sex, sex2, and height_z 
#' 
compute_height_z <- function(height_tbl, person_tbl){
  
  ht_person <-
    height_tbl %>%
    inner_join(person_tbl) %>%
    mutate(age= (measure_date-birth_date)/365.25) %>%
    mutate(age=case_when(age > 20~20, TRUE~age)) %>%## STU-737
    distinct(patid, ht, age, measure_date, sex, .keep_all = TRUE) %>%
    collect_new()
  
  ht_person$sex2 <- with(ht_person, ifelse(sex=="F", "female", "male"))
  
  ht_person$height_z <- with(ht_person,ifelse(age >=2, sds(ht*2.54, age,sex2, 
                                                           ref=cdc.ref, item="height2_20",type="SDS"), NA))
  
  #BIV from https://www.cdc.gov/nccdphp/dnpao/growthcharts/resources/sas.htm
  ht_person$height_z <- with(ht_person, ifelse(height_z >= -5 & height_z <= 5, height_z, NA ))  
  
  ht_person_final <- ht_person %>%
    filter(!is.na(height_z))
  
  return(ht_person_final)
  
}

#' Identify closest height z-score value within X days of BP values
#'
#' @param BP_tbl table with BP measurements and their associated measure_dates
#' @param htz_tbl table with height z-score measurements output by `compute_height_z`
#' @param days_sep maximum number of days that can separate a BP measurement and a height measurement.
#'                 currently defaults to `60`
#'
#' @return table that includes BP and height z-score measurements, with BP values
#'         matched to the closes height z-score based on days_sep
#' 
reformat_BP_htz <- function(BP_tbl, 
                            htz_tbl,
                            days_sep = 60) {
  
  BP_w_ht_z <-
    BP_tbl %>%
    distinct(patid, measure_date) %>%
    inner_join(htz_tbl, by = 'patid') %>%
    filter(!is.na(height_z)) %>%
    mutate(diff=measure_date - height_date) %>%
    mutate(abs_diff=abs(diff)) %>%
    filter(abs_diff <= days_sep) %>%
    group_by(patid, measure_date) %>%
    arrange(abs_diff, diff) %>%
    filter(row_number()==1) %>%
    ungroup() %>%
    inner_join(BP_tbl) %>%
    distinct()
  
}