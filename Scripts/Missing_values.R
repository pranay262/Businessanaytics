# Identifying and Handling Missing Value

# In this lesson, we will discuss how to identify and handle missing values in R
#####################################################################################################
## Important Note - The results you see in the video and in this notebook may diverge slightly due to 
## differences in the datasets (we provide small dataset to you).
#####################################################################################################


# Function to check NA values. # is.na

# If you do is.na(df$column), you will get a logical vector with true where there are NAs. 

# let's create a vetcor called "sales" with a few values
sales <- c(10,12,NA,15, NA)

is.na(sales)

# If we add sum before is.na(sales), we will get the total number of missing values
sum(is.na(sales)) # This is because, TRUE values are internally saved as 1's and FALSe values as 0's


# Read the data ities as df
df <- read.csv("ities.csv")

# Therefore, if you want to know the number of missing values in LineItem column 

sum(is.na(df$LineItem))

# The output is zero, this means there is no missing value in the LineItem column. 

# If you want to test the number of missing values in the whole dataframe 
sum(is.na(df)) 

# There are so many missing values in the whole dataset. 

# However, this is not very helpful as we don't see which columns are missing these values. 

# Therefore, we will use a function colSums which returns column wise sum
colSums(is.na(df))

# We see that most missing values are coming from three columns Cardholdername, Tax, and TotalDue. 


## Handling Missing Values
# Once we find missing values, there are various ways to handle missing values, we can either fill them
# 1) Using mean of the entire column - if the column has normal distribution
# 2) using median of the entire column - if there are outliers in the data
# 3) Model-bases approaches that use information in other variables. Out of scope here. 

# or  
# 4) drop the rows which have missing values

 

# we can use the function replace_na  from the "tidyr" package
# replace_na takes two arguments
# i)  dataframe
# ii) replacement - what do we want the na value to be replaced by

library(tidyr)

# 1) Mean Imputation

# In the code below, we tell R to replace the missing values in df$Tax column by the mean of the column
# and save in a separate object "tax"

tax <- replace_na(df$Tax, mean(df$Tax, na.rm=TRUE))

# Checking the number of missing values in "tax" object, our expectation is zero missing values
sum(is.na(tax))

# Median Imputation

# In the code below, we tell R to replace the missing values in df$TotalDue column by the median of the column
# and save in a separate object "total_due"
total_due <- replace_na(df$TotalDue, median(df$TotalDue, na.rm=TRUE))

# Checking the number of missing values in "total_due" object, our expectation is zero missing values
sum(is.na(total_due))

# We see that all missing values are replaced by their mean and median respectively. 

# If you want to remove rows with missing value, you may use the filter command
df_non_missing <- df %>% filter(!is.na(Tax))

# !is.na returns True wherever there is no NA

# Checking missing values in all columns 
colSums(is.na(df_non_missing))

# All the missing values are gone from Tax and TotalDue, although we removed only the missing values in the TAX column. 
# This happened because these were the same rows that were missing both Tax and TotalDue. 

# Here is a word of caution, before removing the missing values or filling them with NA, first asses their nature
# are they missing randomly or is there a pattern in them. There are useful visualizations that help in asessing that. 