# Making choice - whether to keep information in the row vs in the column
# OR
# Choosing the long vs wide format

# Install and load "tidyr" package

install.packages("tidyr")
library(tidyr)

# Let's understand two data format: long vs wide format. 
# To represent the same information, we may choose a longer vs a wider format. 

# For illustration purpose, I am showing two datasets, essentially capturing same information 
# but in two different formats. 

#####################################################################################################
## Important Note - The results you see in the video and in this notebook may diverge slightly due to 
## differences in the datasets.
#####################################################################################################

# Long Format

# Read the data. You may use any of these depending on in which format is your input file available
df_long <- readRDS("tidy_long.RDS")  # make sure the data "tidy_long.RDS" is in your working directory

or 

df_long <- read.csv("tidy_long.csv") # make sure the data "tidy_long.csv" is in your working directory

# As we see that the values in both linItem and Cashier columns repeat, this means
# niether has a unique row corresponding to it. Thus, the unit of observation
# can't be either Cashier or LineItem. Therefore, each row in this datatset is a combination 
# of LineItem and CashierName. 

# The third column captures the quantities of each lineitem sold by each employee. 
# The last column captures customer statisfaction level for each row. 
# You must note that customer satisfaction is fixed for each line item and does not depend on the 
# employee bacause it must have been observed at lineitem level and not employee level. 


## Wide Format
# Read the data. You may use any of these depending on in which format is your input file available

df_wide <- readRDS("tidy_wide.RDS") # make sure the data "tidy_wide.RDS" is in your working directory

or 

df_wide <- read.csv("tidy_wide.csv") # make sure the data "tidy_wide.csv" is in your working directory


# When we see this data format, we realize that it's at the level of lineitem such that each row
# belongs to a unique lineitem. The quanitites sold by each employee is in the column now. 

# We see the two formats. Let's see how we can convert from one to another. 

# Before we see the R commands, it may be good idea to visualzie in our mind the when we go from
# long to wide, the number of rows go down and the number of columns increase. And viceversa. 

# let's see how we convert wide into long first. 
# Let's see that 

df_long_new <- df_wide %>% pivot_longer(cols = `Quantity_Katherine Roth`:`Quantity_Vincent Ball`, names_to = "Cashier", values_to = "Quantity")
df_long_new <- df_long_new[, c(1,3,4,2)] # here using "c(1,3,4,2)", I just change the order in 
# which columns appear in the df_long_new

# Let's understand the code above
# It has three important arguments 
# 1) cols --> This argument takes the names of the columns we need to drop
# 2) names_to --> This argument takes a name for the new column that will capture the names of the dropped column
# 3) values_to --> This argument takes a name for the new column that will hold the values of the dropped column



## From long to wide - how to take this long back to wide
# We must not forget that going from long to wide, we will create new columns and 
# the rows will be reduced

df_wide_new <- df_long_new %>% pivot_wider(id_cols = c(LineItem, CustomerSatisfaction), names_from = Cashier,values_from = Quantity)
# Let's understand the code above
# It has three important arguments 
# 1) id_cols --> This argument takes the names of the columns that WON'T be spread
# 2) names_from --> This argument asks for the column from which we will get the NAMES of the new columns
# 3) values_from --> This argument asks for the column from which we will get the VALUES of the new columns

# Please note that there are many arguments you can provide. However, the best way
# to learn these things is by practicing them in more contexts. 

# through the assignments, we will help you learn these better. 

# The key takeaways from this lesson are:
# 1) Tidy data is a format where each row captures the unit of analysis
# and each column is a variable

#####################################################################################################

# Additional Notes

# Well you would typicaly hear people say that long is the tidy format. However, that terminology
# most often confuses people. 

# Thus, rather than think in terms of long vs wide, we must think in terms of what is the unit of 
# observation and which are the variables?

# And as mentioned earlier, ask yourself what is the business question and what is the level of analysis
# needed.

# If your question is
# Which employees' quanitity sold has the most impact on customer satisfaction?
# You need "qantity sold by each employee" as a separate variable to relate it with the customer satisfaction 
# column
# Therefore wide format is more suitable. 
# Vs
# However, if the question is 

# Which employee  and lineitem combination have the highest sales? 

# Then you don't need each employee quantity sold in a separate column. Rather the employees name 
# should be part of the observations. Thus a long format is more suitable. 

