#' Modify a codeset which includes ICD-9-CM or ICD-10-CM codes WITH decimal
#' points to add duplicate rows WITHOUT decimal points
#' 
#' This function reads an initial codeset which includes ICD codes WITH decimal
#' points and generates a new codeset for which duplicate rows are added with
#' decimal points REMOVED. For example, for 35210684, "P96.0", "Congenital renal
#' failure" an additional row would be added for the same concept_id (35210684)
#' with the ICD codes as "P960".
#'
#' @param init_codeset_filepath 
#' @param edit_codeset_filepath 
#' 
#' Example function call:
#' library(tidyverse)
#' source("r_scripts/icd_rows_no_decimal.R")
#' icd_rows_no_decimal(init_codeset_filepath = "condition/dx_cakut_init.csv",
#'                     edit_codeset_filepath = "condition/dx_cakut.csv")
#' dx_cakut <- read_csv("condition/dx_cakut.csv")
#' dx_cakut %>% View()
#'
#' @examples
icd_rows_no_decimal <- function(init_codeset_filepath,
                                edit_codeset_filepath) {
  # read in codesets and remove those with missing concept_ids
  # as this indicates manual removal of decimal points
  codeset_init <- read_csv(init_codeset_filepath,
                           col_types = "icccc") %>%
    filter(!is.na(concept_id))
  
  message(
    paste(
      "Initial codeset:",
      codeset_init %>% distinct(concept_id, concept_code) %>% tally() %>% pull(),
      "distinct concept_ids/concept_code combinations"
    )
  )
  
  # select icd9/icd10 vocabularies for which there's a decimal point
  # in the concept_code
  # remove these decimal points and create flag "cc_decimal_removal" as TRUE
  icd_rows_no_decimal <- codeset_init %>%
    filter(pcornet_vocabulary_id %in% c("9", "09", "10"),
           str_detect(concept_code, "[.]")) %>%
    mutate(concept_code = str_remove_all(concept_code, "[.]"),
           cc_decimal_removal = TRUE)
  
  message(
    paste(
      "Decimals removed from",
      icd_rows_no_decimal %>% distinct(concept_id, concept_code) %>% tally() %>% pull(),
      "distinct concept_ids/concept_code combinations"
    )
  )
  
  # take initial codeset, add flag "cc_decimal_removal" as FALSE and
  # combine with the rows for which decimal point was removed
  codeset <- codeset_init %>%
    mutate(cc_decimal_removal = NA) %>%
    select(-cc_decimal_removal) %>%
    dplyr::union(select(icd_rows_no_decimal, -cc_decimal_removal)) %>%
    mutate(
      pcornet_vocabulary_id = if_else(pcornet_vocabulary_id == "9", "09", pcornet_vocabulary_id)
    ) %>%
    distinct() %>%
    left_join(
      select(
        icd_rows_no_decimal,
        concept_id,
        concept_code,
        cc_decimal_removal
      ),
      by = c("concept_id", "concept_code")
    ) %>%
    mutate(cc_decimal_removal = if_else(is.na(cc_decimal_removal), FALSE, cc_decimal_removal)) %>%
    arrange(concept_id)
  
  message(
    paste(
      "Updated codeset:",
      codeset %>% distinct(concept_id, concept_code) %>% tally() %>% pull(),
      "distinct concept_ids/concept_code combinations."
    )
  )
  
  # checks
  message(
    paste(
      "Total row counts as expected in output:",
      codeset %>% tally() %>% pull() ==
        select(codeset_init, concept_id, concept_code) %>%
        union(select(
          icd_rows_no_decimal, concept_id, concept_code
        ))
      %>% distinct(concept_id, concept_code) %>% tally() %>% pull()
    )
  )
  message(
    paste(
      "No missing concept_ids from initial codeset in output:",
      codeset_init %>% anti_join(codeset, by = "concept_id") %>%  tally() == 0
    )
  )
  message(
    paste(
      "No missing concept_codes from initial codeset  in output:",
      codeset_init %>% anti_join(codeset, by = "concept_code") %>%  tally() == 0
    )
  )
  
  codeset %>% write_csv(edit_codeset_filepath)
}
