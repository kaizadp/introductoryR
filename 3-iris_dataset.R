# INTRODUCTORY R
# Kaizad F. Patel
# ---------------
# 3. using the bult-in iris dataset
#

# --------------- 

# 1. load the iris dataset ----
data(iris)

# 2. explore the iris dataset ----

str(iris)

# plot(dataset) gives you the entire dataset, all the variables
plot(iris)

# 3. plot with base R ----
# use the structure: y ~ x, data = DATASET
plot(Petal.Length ~ Petal.Width, data=iris)

# 4. plot with ggplot ----
# load the ggplot2 package
library(ggplot2)

# build the plot
## the first line of the ggplot code sets up the graph.
## use this to identify the dataset and the aesthetics such as x and y axes
## then use + to add more layers such as points, lines, bars, etc.

# a. basic scatterplot
ggplot(data = iris, aes(x = Petal.Width, y = Petal.Length))+  
  geom_point()
# leaving the () empty for geom_point will use the defaults 

# b. scatterplot with regression line
ggplot(data = iris, aes(x = Petal.Width, y = Petal.Length))+  
  geom_point()+
  geom_smooth(method = "lm")

# c. grouping
## the Species variable has 3 levels. 
## group by Species, making a separate regression line for each

ggplot(data = iris, aes(x = Petal.Width, y = Petal.Length, group = Species))+  
  geom_point()+
  geom_smooth(method = "lm")

# d. color by group
ggplot(data = iris, aes(x = Petal.Width, y = Petal.Length, color = Species))+  
  geom_point(size = 2)+
  geom_smooth(method = "lm") #lm = linear model

# e. add some pizzazz
## change color, size, shape, etc.
ggplot(data = iris, aes(x = Petal.Width, y = Petal.Length, color = Species, fill = Species))+  
  geom_point(size = 2, shape = 21, color = "black", stroke = 1)+
  # size = size of shape
  # stroke = thickness of border
  # shape = shape, use numbers to assign shape, search online for "ggplot shapes"
  ## shape = 21 is an open circle, 
  ##    so the color command sets the color of the border. 
  ##    this overrides the aes(color=Species) in the main ggplot function
  ##    to set the fill, use fill = "<COLORNAME>"
  ##    currently, fill is governed by the main ggplot function
  geom_smooth(method = "lm") #lm = linear model

# f. bar graphs
## you need to plot bar graphs using the mean and standard error/standard deviation,
## not the raw data as in scatterplots

# first, compute the mean
# use Rmisc package
# you can also use dplyr/tidyverse -- but that's for later
library(Rmisc)

iris_species = summarySE(data = iris, 
                         measurevar = "Petal.Length", # variable you want to plot
                         groupvars = "Species") # grouping variable

# use this summary dataset to make a bar plot
# Petal.Length ~ Species, change bar fill by Species
ggplot(data = iris_species, aes(x = Species, y = Petal.Length, fill = Species))+
  geom_bar(stat = "identity", color = "black")+ # color = border color
  geom_errorbar(aes(x = Species, 
                    ymax = Petal.Length + sd, ymin = Petal.Length - sd),
                width = 0.5, size = 1, # size = line thickness
                color = "black") 

# g. summary points graph -- plotting mean and se
## use the same summary dataset as above

ggplot(data = iris_species, aes(x = Species, y = Petal.Length, color = Species))+
  geom_point(size=3)+ 
  geom_errorbar(aes(x = Species, 
                    ymax = Petal.Length + sd, ymin = Petal.Length - sd),
                width = 0.5, size = 1) 
