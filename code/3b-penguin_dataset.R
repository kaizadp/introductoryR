# INTRODUCTORY R
# Kaizad F. Patel
# ---------------
# 3b. using the PALMERPENGUINS dataset
# https://github.com/allisonhorst/palmerpenguins/

# load and explore --------------- 
# install and then load the palmerpenguins package from GitHub 
install.packages("remotes")
remotes::install_github("allisonhorst/palmerpenguins")
library(palmerpenguins)

# explore the data with the skimr package
library(skimr)
skim(data)

# make plots --------------- 
library(ggplot2)

# 1. plot culmen length vs depth
# and add customizations: group color and annotations

ggplot(data,
       aes(x = culmen_length_mm, y = culmen_depth_mm,
           color = species))+
  geom_point()+
  # set x and y axis limits  
  xlim(25,60)+
  ylim(10,25)+
  # set colors for groups
  scale_color_manual(values = c("black", "yellow", "orange"))+
  # add text annotations
  # by default, the annotations are center-aligned
  annotate("text", label = "this is some text", x = 40, y = 25)+
  # change size and color for text annotations
  annotate("text", label = "this is some larger text", x = 40, y = 23, size=5)+
  annotate("text", label = "this is some red text", x = 50, y = 20, color="red")



