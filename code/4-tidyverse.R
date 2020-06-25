# TIDYVERSE
# 25-June-2020
# KFP

## R works best with TIDY data. 
##    i.e. each variable in a separate, unique column, 
##    and each sample in a row

library(tidyverse)
# this loads the following packages:
#   ggplot2
#   tibble
#   tidyr
#   readr
#   dplyr
#   purr
#   stringr
#   forcats

# TIDYing the porewater DOC data ------------------------------------------
data = read.csv("data/3soils_wsoc_pore.csv")

# use skimr to explore the dataset
skimr::skim(data)

names(data)

# 1. rename columns
# NEWFILE = rename(SOURCEFILE, "NEWCOLUMNNAME" = "OLDCOLUMNNAME")
data2 = rename(data, "pore_size" = "Pore.Size.Domain")
data2 = rename(data2, "wsoc_mg_L" = "Water.Soluble.Organic.Carbon..mg.L.")

## you can also combine multiple renames
data2b = rename(data, "pore_size" = "Pore.Size.Domain", 
                "wsoc_mg_L" = "Water.Soluble.Organic.Carbon..mg.L.")

# 2. subset: select columns
data3 = dplyr::select(data2, Site, CoreNo, CoreID, Treatment, Suction, pore_size, wsoc_mg_L)

  # or you can deselect columns
data3b = dplyr::select(data2, -FTICR_ID, -`FT.ICRvol_ml`, -SampleID)

# 3. subset: filter rows
## for categorical variables, use == and ""
data4 = filter(data3, Site=="CPCRW")

## for numeric variables, use == and no ""
# which samples had wsoc 27 mg/L exact?
data4b_27only = filter(data3, wsoc_mg_L == 27)
# which samples had wsoc > 27 mg/L?
data4b_greater27 = filter(data3, wsoc_mg_L > 27)


# 4. recode levels
data5 = data4
data5$Treatment = recode(data5$Treatment, 
                         `Drought Incubation` = "drought",
                         `Field Moisture Incubation` = "fm",
                         `Time Zero Saturation` = "tzero",
                         `Saturation Incubation` = "saturation")

## or use mutate
data5b = mutate(data4, Treatment = recode(Treatment, 
                                          `Drought Incubation` = "drought",
                                          `Field Moisture Incubation` = "fm",
                                          `Time Zero Saturation` = "tzero",
                                          `Saturation Incubation` = "saturation"))

### stopped here 25-Jun-2020

ggplot(data5, aes(x = Treatment, y = wsoc_mg_L, color = Suction, shape=Site))+ geom_point()

# use the %>% (pipe) to stack multiple functions
# shortcut: cmd+shift+m or ctrl+shift+m
# CECI N'EST PAS UN PIPE!

data_clean = 
  data %>% 
  rename("pore_size" = "Pore.Size.Domain",
         "wsoc_mg_L" = "Water.Soluble.Organic.Carbon..mg.L.") %>% 
  dplyr::select(Site, CoreNo, CoreID, Treatment, Suction, pore_size, wsoc_mg_L) %>% 
  filter(Site=="CPCRW") %>% 
  mutate(Treatment = recode(Treatment, `Drought Incubation` = "drought",
                                   `Field Moisture Incubation` = "fm",
                                   `Time Zero Saturation` = "tzero",
                                   `Saturation Incubation` = "saturation"))
