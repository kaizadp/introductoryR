# October 2, 2020
# Basic R stuff with the HYSTERESIS - WSOC DATA


# step 0. load packages ---------------------------------------------------
library(dplyr)
library(ggplot2)
# or load the tidyverse

# step 1. load files --------------------------------------------------
corekey = read.csv("data/hysteresis_demo/corekey.csv")
wsoc_data = read.csv("data/hysteresis_demo/wsoc.csv")

# SCL = sandy clay loam (soil)
# SL = sandy loam (soil_sand)

# clean the corekey
names(corekey)
corekey_clean = 
  corekey %>% #ctrl-shift-m gives you the pipes
  # select only the columns you need
  select(Core, treatment, texture, sat_level, DryWt_g, Carbon_g) 

str(corekey_clean)  
str(wsoc_data)

# join corekey to wsoc_data
wsoc_data2 = 
  wsoc_data %>% 
  left_join(corekey_clean, by = "Core") %>% 
  ## npoc is in mg/L, but we need to convert to mg/g soil
  ## create a new column called npoc_mg_g
  mutate(npoc_mg_g = npoc_mg_l * 40/(DryWt_g*1000))
  
            ## NPOC mg/L ----> NPOC mg/g
            ## 
            ## NPOC mg   *   40 mL    *  1L
            ##     L          DryWt_g    1000 mL






