# pull ingredients from htn meds in format for chart review REDCap format
library(tidyverse)
process_ingredient <- function(ingredient_df) {
  ingredient_df %>%
    distinct(ingredient) %>%
    mutate(ingredient = tolower(ingredient)) %>%
    mutate(row_num = row_number())
}
# 1	htnmeds1___1	ACE inhibitor
# 2	htnmeds1___2	Angiotensin receptor blocker
# 3	htnmeds1___3	Calcium channel blocker
# 4	htnmeds1___4	Thiazide diuretic
# 5	htnmeds1___5	Beta blocker
# 6	htnmeds1___6	Alpha blocker

# alpha blocker not included in previous materials. From wikipedia: Non-selective α-adrenergic receptor antagonists include:
# 1. Phenoxybenzamine
# 2. Phentolamine
# 3. Tolazoline
# 4. Trazodone
# Selective α1-adrenergic receptor antagonists include:
# 5. Alfuzosin[4]
# 6. Doxazosin[5]
# 7. Prazosin (inverse agonist)[6]
# 8. Tamsulosin[7]
# 9. Terazosin[8]
# 10. Silodosin[9]
# Selective α2-adrenergic receptor antagonists include:
# 11. Atipamezole
# 12. Idazoxan
# 13. Mirtazapine
# 14. Yohimbine
# Finally, the agents
# 15. carvedilol
# 16. labetalol are both α and β-blockers.
wiki_vct <-
  c(
    'Phenoxybenzamine',
    'Phentolamine',
    'Tolazoline',
    'Trazodone',
    'Alfuzosin',
    'Doxazosin',
    'Prazosin',
    'Tamsulosin',
    'Terazosin',
    'Silodosin',
    'Atipamezole',
    'Idazoxan',
    'Mirtazapine',
    'Yohimbine',
    'carvedilol',
    'labetalol'
  ) %>% 
  tolower()

# 7	htnmeds1___7	Clonidine
# 8	htnmeds1___8	Other
ace <- read_csv("drug/rx_ace_inhibitor.csv") %>% 
  process_ingredient() %>% 
  rename(ace = ingredient)
arb <- read_csv("drug/rx_arb.csv")  %>% 
  process_ingredient() %>% 
  rename(arb = ingredient)
ccb <- read_csv("drug/rx_ccb.csv")  %>% 
  process_ingredient() %>% 
  rename(ccb = ingredient)
thiazide <- read_csv("drug/rx_thiazide.csv")  %>% 
  process_ingredient() %>% 
  rename(thiazide = ingredient)
bb <- read_csv("drug/rx_bb.csv")  %>% 
  process_ingredient() %>% 
  rename(bb = ingredient)
# I think clonidine is an ingredient - this should be checked
clonidine <- as_tibble(c("clonidine")) %>% 
  rename(clonidine = value)  %>% 
  mutate(row_num = row_number())
# Created alpha blocker ingredient codeset - requires review
alpha_blocker <- read_csv("drug/rx_alpha_blocker_ingred.csv")  %>% 
  distinct(concept_name) %>% 
  rename(alpha_blocker = concept_name)  %>% 
  mutate(row_num = row_number())
# setdiff(alpha_blocker %>% distinct(alpha_blocker) %>% pull,
#         wiki_vct)
# setdiff(wiki_vct,
#         alpha_blocker %>% distinct(alpha_blocker) %>% pull)
other <- read_csv("drug/rx_loop_diuretic.csv")  %>% 
  process_ingredient() %>% 
  rename(other = ingredient)

antihtn_table <- ace %>% 
  full_join(arb, by = "row_num") %>% 
  full_join(ccb, by = "row_num") %>% 
  full_join(thiazide, by = "row_num") %>% 
  full_join(bb, by = "row_num") %>% 
  full_join(clonidine, by = "row_num") %>%
  full_join(alpha_blocker, by = "row_num") %>% 
  full_join(other, by = "row_num") %>% 
  select(-row_num)

antihtn_table %>% write_csv("r_scripts/antihtn_ingred_cr.csv")