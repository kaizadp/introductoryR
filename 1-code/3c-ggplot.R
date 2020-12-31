# INTRODUCTORY R
# Kaizad F. Patel
# 06-April-2020
# ---------------
# 3. ggplot: the Grammar of Graphics

## ggplot is a popular package for graphs
library(ggplot2)


processed = read.csv("processed/wsoc_processed.csv")
cpcrw = processed[processed$Site=="CPCRW",]

# 1. basic scatterplot with categorical variables ----
ggplot(cpcrw, # the data file goes here
       aes(x = Treatment, y = wsoc_mg_L))+
# aes = aesthetic, for x and y variables
# aes also includes grouping variables (next example)  
# now you specify the type of plot you want to make
  geom_point() # scatter plot

# but this includes grouping of Suction
# assign separate colors to the Suctions
# add `color = Suction` inside the aes ()
ggplot(cpcrw, aes(x = Treatment, y = wsoc_mg_L, color = Suction))+
  geom_point()

# play around with shapes and sizes
ggplot(cpcrw, 
       aes(x = Treatment, y = wsoc_mg_L, 
           color = Suction,
           shape = Suction,
           size = Suction))+
  geom_point()

# customizing your ggplot
ggplot(cpcrw, aes(x = Treatment, y = wsoc_mg_L, color = Suction, shape = Suction))+
  geom_point(
    size = 4, # size of points
    stroke = 1 # thickness of outline
    )+
  scale_color_manual(values = c("red", "blue"))+
  scale_shape_manual(values = c(1,4))

# making panels
ggplot(cpcrw, aes(x = Treatment, y = wsoc_mg_L, color = Suction))+
  geom_point()+
# use facet_wrap or facet_grid
# nomenclature is VERTICAL ~ HORIZONTAL
  facet_grid(~Suction)

ggplot(cpcrw, aes(x = Treatment, y = wsoc_mg_L, color = Suction))+
  geom_point()+
  # use facet_wrap or facet_grid
  # nomenclature is VERTICAL ~ HORIZONTAL
  facet_grid(Suction~.)

#

# 2. scatter plot with mean and standard error ----
# you cannot plot the mean/se directly
# you have to first calculate these summary statistics, and then plot those

library(Rmisc)
cpcrw_summary = summarySE(cpcrw, # source data
                          measurevar = "wsoc_mg_L", # dependent variable
                          groupvars = c("Treatment", "Suction"), # grouping variables
                          na.rm = TRUE) # remove NA, so you can use the remaing data for the summary

View(cpcrw_summary)

ggplot(cpcrw_summary,
       aes(x = Treatment, y = wsoc_mg_L, color = Suction))+
  geom_point(size=5)+
  geom_errorbar(aes(ymin = wsoc_mg_L - se, ymax = wsoc_mg_L + se), # make a new aesthetic for error bars
    width = 0.5, # width of error bars
    size = 1) # thickness
#





# 3. bar plot ----

ggplot(cpcrw_summary, aes(x = Treatment, y = wsoc_mg_L, 
                          color = Suction, # outline color
                          fill = Suction) # fill
       )+
  geom_bar(stat = "identity", 
           position = position_dodge()) # puts the bars side-by-side

# if you want a black border around the bars,
# don't include `color` in the aes()

ggplot(cpcrw_summary, aes(x = Treatment, y = wsoc_mg_L,
                          fill = Suction))+
  geom_bar(stat = "identity", color = "black", position = position_dodge())+
# now add error bars like above
  geom_errorbar(aes(ymin = wsoc_mg_L - se, ymax = wsoc_mg_L + se), # make a new aesthetic for error bars
                width = 0.2,
                size = 0.5,
                position = position_dodge(0.9)) # adjust position of error bars


ggplot(cpcrw_summary, aes(x = Treatment, y = wsoc_mg_L,
                          fill = Suction))+
  geom_bar(stat = "identity", color = "black", 
           position = position_dodge(0.8), # adjust spacing among groups (Suction)
           width = 0.7)+ # adjust spacing between treatments
  # now add error bars like above
  geom_errorbar(aes(ymin = wsoc_mg_L - se, ymax = wsoc_mg_L + se), # make a new aesthetic for error bars
                width = 0.2,
                size = 0.5,
                position = position_dodge(0.8)) # adjust position of error bars
#

## SIDEBAR: ----
# the treatment levels are being a PIA
# so we should rename the levels
# do this in the main "processed" file

# first, find the existing levels
levels(processed$Treatment)
levels(processed$Treatment) = c("Drought", "FM", "Saturation", "TZero")

# now, redo cpcrw and cpcrw_summary
cpcrw = processed[processed$Site=="CPCRW",]
cpcrw_summary = summarySE(cpcrw, measurevar = "wsoc_mg_L", groupvars = c("Treatment", "Suction"), na.rm = TRUE) 

# try the plots above again
#

# 4. additional customizations ----

ggplot(cpcrw_summary, aes(x = Treatment, y = wsoc_mg_L, fill = Suction))+
  geom_bar(stat = "identity", color = "black", 
           position = position_dodge(0.8), 
           width = 0.7)+ 
  geom_errorbar(aes(ymin = wsoc_mg_L - se, ymax = wsoc_mg_L + se), 
                width = 0.2, size = 0.5, position = position_dodge(0.8))+

# adding text
  annotate("text", label = "here is some text", x = 2, y = 200)+
# this is useful when adding asterisks or letters to show significant differences
annotate("text", label = "*", x = 2, y = 50, size = 10)+
annotate("text", label = "A", x = 3.2, y = 100, size = 5)+
annotate("text", label = "A", x = 2.8, y = 100, size = 5)+

# using custom color scales
  scale_fill_brewer(palette = "Dark2")
