# October 2, 2020
# Basic R stuff with the HYSTERESIS - WSOC DATA

################ # 
################ # 

## experiment design

## Samples were (a) wet or (b) dried to various moisture levels (sat_level = 5, 35, 50, 75, 100%)
## Samples were of two textures: (a) SCL = sandy clay loam (soil); (b) SL = sandy loam (soil_sand)
## FM = field moist samples, ~ 53 % saturation

## WSOC data were collected as non-purgeable organic C (NPOC)

## objective of this exercise: (a) plot data, (b) create summary tables, (c) perform statistical analyses

################ # 
################ # 

# step 0. load packages ---------------------------------------------------
library(dplyr)
library(ggplot2)
# or load the tidyverse

# step 1. load files --------------------------------------------------
corekey = read.csv("data/hysteresis_demo/corekey.csv")
wsoc_data = read.csv("data/hysteresis_demo/wsoc_results.csv")
wsoc_weights = read.csv("data/hysteresis_demo/wsoc_weights.csv")

# step 2. clean and process the data --------------------------------------

## 2a. clean the corekey
names(corekey)
corekey_clean = 
  corekey %>% #ctrl-shift-m gives you the pipes
  # select only the columns you need
  select(Core, treatment, texture, sat_level, DryWt_g, Carbon_g) %>% 
  # change the `Core` column to character format for easy joining later
  mutate(Core = as.character(Core))
  
str(corekey_clean)  
str(wsoc_data)

## 2b. process and calculate WSOC normalized to soil weight
# first, convert WSOC from mg/L to mg/g. do this using data in `wsoc_weights`.
      ## NPOC mg/L ----> NPOC mg/g
      ## 
      ## NPOC mg   *   water mL    *  1L
      ##     L        WSOC_drywt_g    1000 mL

          ## water includes the water used in extraction (40 mL) as well as the water present in the soil (WSOC_water_g)

# second, join the `corekey` to assign treatments to each core.

wsoc_data2 = 
  wsoc_data %>% 
  mutate(Core = as.character(Core)) %>%   
  left_join(wsoc_weights, by = "Core") %>% 
  ## create a new column called wsoc_mg_g
  mutate(wsoc_mg_g = npoc_mg_l * (40+WSOC_water_g)/(WSOC_drywt_g*1000)) %>% 
  left_join(corekey_clean, by = "Core") %>% 
  # select only necessary columns
  select(Core, treatment, texture, sat_level, wsoc_mg_g) %>% 
  # set FM = 53% sat_level
  mutate(sat_level = if_else(treatment=="FM", as.integer(53), sat_level))

# step 3. visualization ---------------------------------------------------
theme_set(theme_bw())

gg_wsoc = 
  wsoc_data2 %>% 
  ggplot(aes(x = sat_level, y = wsoc_mg_g, color = treatment))+
  geom_point()+
  facet_grid(texture ~.)

# step 4. tables ---------------------------------------------------

wsoc_summarytable = 
  wsoc_data2 %>% 
  group_by(texture, sat_level, treatment) %>% 
  dplyr::summarise(mean_wsoc_mg_g = mean(wsoc_mg_g),
                   sd_wsoc = sd(wsoc_mg_g),
                   se_wsoc = sd_wsoc/sqrt(n())) %>% 
  mutate(mean_wsoc_mg_g = round(mean_wsoc_mg_g,3),
         se_wsoc = round(se_wsoc,4)) %>% 
  mutate(wsoc_mg_g = paste(mean_wsoc_mg_g, "\u00b1", se_wsoc)) %>%
#  mutate(core_assignment = paste0(texture, "-" ,sat_level, "-", treatment))
  dplyr::select(texture, sat_level, treatment, wsoc_mg_g) %>% 
  filter(treatment != "FM") %>% 
  tidyr::spread(treatment, wsoc_mg_g) 

# step 5. statistics ------------------------------------------------------
## 5a. overall ANOVA
l = lm(wsoc_mg_g ~ sat_level*treatment, data = wsoc_data2 %>%  filter(treatment != "FM"))
car::Anova(l, type = "III")

## 5b. (ANOVA) effect of treatment for individual moisture levels
## include stats in the wsoc summary table
fit_anova = function(dat){
  l = lm(wsoc_mg_g ~ treatment, dat)
  a = car::Anova(l, type = "III") 
  broom::tidy(a) %>% 
    filter(term == "treatment") %>% 
    dplyr::select(`p.value`) %>% 
    rename(pvalue = `p.value`)
}

wsoc_pvalues = 
  wsoc_data2 %>%  filter(treatment != "FM") %>% 
  group_by(texture, sat_level) %>% 
  do(fit_anova(.)) %>% 
  mutate(asterisk = case_when(pvalue <= 0.05 ~ "*"))
  


wsoc_summarytable %>% 
  left_join(wsoc_pvalues, by = c("texture", "sat_level")) %>% 
  mutate(Wetting2 = paste(Wetting, asterisk),
         Wetting2 = stringr::str_replace_all(Wetting2, "NA", "")) %>% 
  dplyr::select(-Wetting, -pvalue, -asterisk) %>% 
  rename(Wetting = Wetting2)

## asterisks denote a significant treatment effect


# return to ggplot --------------------------------------------------------
## now, we add asterisks to the plot we created earlier
## two ways to do it

##  way  1,  more labor-intensive: use individual annotations for each asterisk

gg_wsoc+
  annotate("text", label = "*", x = 5, y = 0.45, size  = 7)+
  annotate("text", label = "*", x = 50, y = 0.25, size  = 7)
## and so on
## but this does not work when you have multiple panels, as the annotations will be applied to both the panels

## way 2: use geom_text
## create a file that contains all the information to create a "text" layer superimposed on the original ggplot
## we need an x-value (sat_level)
## we need a y-value, which will be a little greater than the maximum y-value 
## we need a label (asterisk)

gg_label = 
  wsoc_data2 %>% 
  group_by(texture, sat_level) %>% 
  dplyr::summarise(y = max(wsoc_mg_g) + 0.05) %>% 
  left_join(wsoc_pvalues, by = c("texture", "sat_level")) %>% 
  mutate(treatment ="Wetting")
  
gg_wsoc+
  geom_text(data = gg_label, aes(y = y, label = asterisk), color= "black", size = 7)+
  labs(title = "Water extractable organic carbon",
       subtitle = "asterisks denote significant treatment differences")
