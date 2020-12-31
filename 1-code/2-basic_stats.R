# INTRODUCTORY R
# Kaizad F. Patel
# ---------------
# 2. basic statistics
#

# we will import the processed file from script #1
# and run basic ANOVA, LME, etc.

# first, import the file
processed = read.csv("processed/wsoc_processed.csv")

# this file has too many variables/treatments, so we will create a subset
# subset of only the time zero data

tzero = processed[processed$Treatment=="Time Zero Saturation",]

# 1. ANOVA: use function `aov`
## 1a. one variable
# how does site influence WSOC?
tzero_aov1 = aov(data = tzero, wsoc_mg_L ~ Site)
# anova summary table, with F and P values
summary(tzero_aov1)
print(tzero_aov1)

## 1b. two variables
# how do site and suction alter wsoc?
tzero_aov2 = aov(data = tzero, wsoc_mg_L ~ Site + Suction)
summary(tzero_aov2)

## 1c. two variables with interaction
# the `:` symbol is for interaction 
tzero_aov3 = aov(data = tzero, wsoc_mg_L ~ Site + Suction + Site:Suction)
summary(tzero_aov3)

# or -- you can use `*`, which will analyze individual factors as well as their interaction
tzero_aov4 = aov(data = tzero, wsoc_mg_L ~ Site*Suction)
summary(tzero_aov4)

# _aov3 and _aov4 give the same results

# using data = processed
# test the effect of site and treatment and suction on wsoc

tzero_aov5 = aov(data = processed, wsoc_mg_L ~ Site*Suction*Treatment)
summary(tzero_aov5)

plot(tzero_aov5)

# 2. post-hoc TUKEY HSD test
# you do this after running ANOVA
# you use this for pairwise comparisons for multiple levels of a single variable
library(agricolae)
tzero_hsd = HSD.test(tzero_aov1,"Site")
print(tzero_hsd)
print(tzero_hsd$groups)

