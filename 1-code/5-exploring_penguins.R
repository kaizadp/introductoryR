


# load packages -----------------------------------------------------------
library(palmerpenguins)
library(tidyverse)
library(skimr)

# explore data ------------------------------------------------------------

skim(penguins)


# bill length vs. depth ---------------------------------------------------

penguins %>% 
  ggplot(aes(x = bill_length_mm, y = bill_depth_mm, 
             color = species))+
  geom_point()+
  geom_smooth(method = "lm")
  

# bill depth vs. species --------------------------------------------------

penguins %>% 
  ggplot(aes(x = species, y = bill_depth_mm))+
  geom_point(aes(color = sex))

penguins %>% 
  ggplot(aes(x = species, y = bill_depth_mm))+
  geom_jitter(aes(color = sex))

penguins %>% 
  ggplot(aes(x = species, y = bill_depth_mm))+
  geom_point(aes(color = sex),
             position = position_dodge(width = 0.5))



# run anova ---------------------------------------------------------------

a = aov(bill_depth_mm ~ species, data = penguins)
summary(a)

library(agricolae)
h = HSD.test(a, "species")
print(h)

car::Anova()

anova()