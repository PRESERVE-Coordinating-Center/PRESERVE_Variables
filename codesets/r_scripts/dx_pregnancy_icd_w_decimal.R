read_csv("condition/dx_pregnancy.csv") %>% 
  filter(vocabulary_id %in% c("ICD9CM", "ICD10CM", "ICD10"),
         cc_decimal_removal == FALSE) %>% 
  write_csv("condition/dx_pregnancy_icd_w_decimal.csv")
