# INTRODUCTORY R
# Kaizad F. Patel
# ---------------
# 3b. EXPLORE GGPLOT2 using the PALMERPENGUINS dataset
# https://github.com/allisonhorst/palmerpenguins/

# load and explore --------------- 
# install and then load the palmerpenguins package from GitHub 
# remotes::install_github("allisonhorst/palmerpenguins")
library(palmerpenguins)

# explore the data with the skimr package
library(skimr)
skim(penguins)

# MAKING GGPLOTS WITH CUSTOMIZATIONS --------------- 
library(ggplot2)

# make a basic scatterplot of bill depth vs. bill length
# save this as an object, `p`, so we don't repeat the same lines of code each time
# the parentheses around the entire code indicate "print".
# i.e. we will create an object `p`, and then print/plot it. 

(plot = 
  ggplot(penguins, aes(x = bill_length_mm, y = bill_depth_mm, color = species))+
    geom_point()
)
  

# ADDING CUSTOMIZATIONS
## use the scale_ function to assign colors, shapes, etc.
## scale_color_ for color
## scale_fill_ for fill color
## scale_shape_ for point shape
## etc.

## 1. color ----
## 1a.CATEGORICAL: `scale_color_manual` to specify individual values:

plot+
  scale_color_manual(values = c("black", "yellow", "orange"))

## you can assign values based on color names (search "ggplot colors"  for full list of colors/names)
## you can also use RGB or HEX color notations to assign colors

plot+
  scale_color_manual(values = c("#000000", "#ffff00", "#ff9900"))


## 1b. CATEGORICAL: to use pre-generated color palette:

## Brewer color palette (https://ggplot2.tidyverse.org/reference/scale_brewer.html)
plot+
  scale_color_brewer(palette = "Set1")

## some other palettes:
## soilpalettes (https://github.com/kaizadp/soilpalettes)
library(soilpalettes)
plot+
  scale_color_manual(values = soil_palette("rendoll",3))

## PNWColors (https://github.com/jakelawlor/PNWColors)
library(PNWColors)
plot+
  scale_color_manual(values = pnw_palette("Bay"))
plot+
  scale_color_manual(values = pnw_palette("Bay",3))

## wesanderson (https://github.com/karthik/wesanderson)

## 1c. CONTINUOUS variables
ggplot(penguins, aes(x = bill_length_mm, y = bill_depth_mm, color = bill_length_mm))+
  geom_point()

## set start and end colors
ggplot(penguins, aes(x = bill_length_mm, y = bill_depth_mm, color = bill_length_mm))+
  geom_point()+
  scale_color_gradient(low = "blue", high = "red")

## use Brewer palettes
ggplot(penguins, aes(x = bill_length_mm, y = bill_depth_mm, color = bill_length_mm))+
  geom_point()+
  scale_color_gradientn(colours = brewer.pal(4,"YlOrRd"))

## use soilpalettes
ggplot(penguins, aes(x = bill_length_mm, y = bill_depth_mm, color = bill_length_mm))+
  geom_point()+
  scale_color_gradientn(colors = soilpalettes::soil_palette("redox"))

## 1d. VIRIDIS palettes
## viridis is a set of 5 colorblind-friendly palettes
## https://cran.r-project.org/web/packages/viridis/vignettes/intro-to-viridis.html
## use scale_viridis_c() for continuous variables
## use scale_viridis_d() for discrete/categorical variables

ggplot(penguins, aes(x = bill_length_mm, y = bill_depth_mm, color = bill_length_mm))+
  geom_point()+
  scale_color_viridis_c(option = "viridis")

ggplot(penguins, aes(x = bill_length_mm, y = bill_depth_mm, color = bill_length_mm))+
  geom_point()+
  scale_color_viridis_c(option = "plasma")

ggplot(penguins, aes(x = bill_length_mm, y = bill_depth_mm, color = bill_length_mm))+
  geom_point()+
  scale_color_viridis_c(option = "magma")

plot +
  scale_color_viridis_d(option = "inferno")

plot +
  scale_color_viridis_d(option = "cividis")


## 2. fill ----
## for bar graphs, box plots, violin plots, etc. 
## use scale_fill_..., similar to scale_color_

ggplot(penguins, aes(y = bill_length_mm, x = species, fill = species))+
  geom_violin()+
  scale_fill_viridis_d()

ggplot(penguins, aes(y = bill_length_mm, x = species, fill = species))+
  geom_boxplot()+
  scale_fill_manual(values = soilpalettes::soil_palette("paleustalf",3))

# 
## 3. shape ----
## use scale_shape_manual() to set shapes in scatterplots
## use numbers to denote shapes
## google "ggplot shapes" to see full list

ggplot(penguins, aes(x = bill_length_mm, y = bill_depth_mm, shape = species))+
  geom_point()+
  scale_shape_manual(values = c(4,1,8))

ggplot(penguins, aes(x = bill_length_mm, y = bill_depth_mm, shape = species))+
  geom_point()+
  scale_shape_manual(values = c(5,7,19))

#
## 4. linetype ----
ggplot(penguins, aes(x = bill_length_mm, y = bill_depth_mm, linetype = species))+
  geom_smooth(method = "lm")+
  scale_linetype_manual(values = c("solid", "dashed", "dotted"))

#

## 5. axis limits ----
plot +  
  # set x and y axis limits  
  xlim(0,60)+
  ylim(0,25)

#

## 6. annotations ----
## 6a. text annotations

plot +
  # add text annotations
  # by default, the annotations are center-aligned
  annotate("text", label = "this is some text", x = 40, y = 25)+
  # change size and color for text annotations
  annotate("text", label = "this is some larger text", x = 40, y = 23, size=5)+
  annotate("text", label = "this is some red text", x = 50, y = 20, color="red")

## 6b. shape annotations

plot+
  annotate("curve", x = 40, xend = 45, y = 22, yend = 24, curvature = -0.5)+
  annotate("text", label = "Adelie", x = 50, y = 24)

plot+
  annotate("rect", xmin = 30, xmax = 40, ymin = 12, ymax = 23,
           fill = NA, color = "black")

#
## 7. labels and titles ----

## option 1: use xlab, ylab, ggtitle
plot+
  # axis labels
  xlab("Bill length (mm)")+
  ylab("Bill depth (mm)")+
# add title
  ggtitle("Bill depth vs. length")

## option 2: use labs
plot+
  labs(x = "x axis",
       y = "y axis",
       color = "COLOR LEGEND KEY",
       title = "title",
       subtitle = "subtitle",
       caption = "data: Palmer Penguins")

#

## 8. themes ----
## the theme adjusts background color, panel borders, gridlines, font color, size, etc.
## use theme_... to change the themes

plot+
  theme_bw()

plot+
  theme_classic()

plot+
  theme_dark()

## 8b. CUSTOMIZE YOUR THEME
## start with a preset theme, and then use theme() to make further adjustments

plot+
  theme_bw()+
  theme(legend.position = "top",
        legend.title = element_blank(),
        legend.text = element_text(size = 12),
        legend.key.size = unit(1.5, 'lines'),
        panel.border = element_rect(color="black",size=1.5, fill = NA),
        
        plot.title = element_text(hjust = 0.05, size = 14),
        axis.text = element_text(size = 14, color = "red"),
        axis.title = element_text(size = 14, face = "bold", color = "black"))

## legend position
## to place the legend outside, use "top", "bottom", "left", right"
## to place the legend inside the plot, use normalized coordinates (0-1 scale)

plot+
  theme(legend.position = "right")

plot+
  theme(legend.position = c(0.1,0.15))

#
## 9. facets ----
## use facets to split your plots into multiple panels
## you can use facet_grid() or facet_wrap()
## both follow similar conventions of ROWS ~ COLUMNS
## watch out for the `.` in facet_grid()

## single facetting variable
plot+
  facet_wrap(~species)+
  theme(legend.position = "none")

plot+
  facet_grid(~species)

plot+
  facet_grid(species~.)

## multiple facetting variables

plot+
  facet_grid(species~island)+
  theme_bw()

plot+
  facet_wrap(species~island)+
  theme_bw()

# adjust axes with "free"
plot+
  facet_grid(species~island, scales = "free")+
  theme_bw()

plot+
  facet_grid(species~island, scales = "free_x")+
  theme_bw()

plot+
  facet_grid(species~island, scales = "free_y")+
  theme_bw()

#



## 10. combined ----

plot+
  scale_color_manual(values = pnw_palette("Bay",3))+
  labs(x = "Bill length (mm)",
       y = "Bill depth (mm)",
       title = "Penguin bills",
       subtitle = "bill depth vs. length, facetted by Island and Species",
       caption = "data = PalmerPenguins | colors = PNWColors")+
  facet_grid(species~island)+
  theme_bw()+
  theme(legend.position = "top",
        legend.key=element_blank(),
        legend.title = element_blank(),
        legend.text = element_text(size = 12),
        legend.key.size = unit(1.5, 'lines'),
        panel.border = element_rect(color="black",size=1.5, fill = NA),
        panel.grid.major = element_line(color = "grey80"),
        panel.grid.minor = element_line(color = "grey90"),
        
        plot.title = element_text(hjust = 0.0, size = 14),
        axis.text = element_text(size = 14, color = "black"),
        axis.title = element_text(size = 14, face = "bold", color = "black"),
        
        # formatting for facets
        panel.background = element_blank(),
        strip.background = element_rect(colour="white", fill="white"), #facet formatting
        panel.spacing.x = unit(1.5, "lines"), #facet spacing for x axis
        panel.spacing.y = unit(1.5, "lines"), #facet spacing for x axis
        strip.text.x = element_text(size=12, face="bold"), #facet labels
        strip.text.y = element_text(size=12, face="bold", angle = 270) #facet labels
  )

# SAVE YOUR PLOTS ----
# ggsave will save the last run plot only

## set the file format
ggsave("penguins_plot.tiff")
ggsave("penguins_plot.png")

## set the file size. the default  unit is inches
ggsave("penguins_plot.tiff", height = 5, width = 7)
