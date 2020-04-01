# INTRODUCTORY R
# Kaizad F. Patel
# ---------------
# 1. importing files
#

# NOTES ----
# you can use the # sign to comment your code
# any text/script that follows the # sign will not be run as a command
# you can use this to add comments and describe steps in your script

# Adding 4 hyphens (----) at the end of a comment line will turn it into a section
# you can minimize sections to keep the script neat


# step 1. importing files of different types ----
# you can import .csv files without any additional packages
data_csv = read.csv("data/3soils_wsoc_pore.csv")

# you need the `readxl` package for .xlsx files
# first, load the package
library(readxl)
# by default, read_excel imports the first spreadsheet. 
# specify the sheet you want to import
data_xlsx = read_excel("data/3soils_wsoc_pore.xlsx", sheet = "wsoc")

#

# step 2. info about data ----
# list the column names
names(data_csv)

# structure of the columns
# this tells you if a variable is numeric or categorical,
# how many factors, etc.
str(data_csv)

# change the format of the columns
data_csv$Site = as.factor(data_csv$Site)
data_csv$SampleID = as.character(data_csv$SampleID)
data_csv$`Water.Soluble.Organic.Carbon..mg.L.` = as.factor(data_csv$`Water.Soluble.Organic.Carbon..mg.L.`)


# list the first 6 entries of the data table
head(data_csv)

# find the dimensions of the data table (rows and columns)
dim(data_csv)

# to call the info in a given cell, use coordinates
# DATAFILE[ROW,COLUMN]
# e.g. 10th row and 5th column
data_csv[10,5]

# you can also use the name of the column
data_csv[10,"Site"]


# to call all the entries in a column
# the space before the comma = all rows are selected
data_csv[,1]

# call all entries in the first three columns
data_csv[,1:3]

# call all columns for the first row
data_csv[1,]


#
# step 3. processing and cleaning up ----
# make a subset of the first three columns
data_sub1 = data_csv[,1:2]

# make a subset by removing the first two columns
data_sub2 = data_csv[,-(1:2)]

# avoid spaces, periods, and symbols in column names
# letters, numbers, and underscores work best

# rename the offending columns in data_sub2
names(data_sub2)[names(data_sub2) == "Pore.Size.Domain"] = "pore_size"
names(data_sub2)[names(data_sub2) == "Water.Soluble.Organic.Carbon..mg.L."] = "wsoc_mg_L"

#
# step 4. export ----
write.csv(data_sub2, "processed/wsoc_processed.csv")
# if you open this file, you will see:
# a. row numbers as a separate column
# b. "NA" in blank cells

# try this now
# na = "" makes all NA blank,
# and row.names=FALSE will exclude row names
write.csv(data_sub2, "processed/wsoc_processed.csv", na="", row.names = FALSE)

print("SUCCESS!!!")

