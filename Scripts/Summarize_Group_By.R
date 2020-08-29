# Hi, in this lesson we will discuss how to aggregate our data using two useful functions
# from dplyr package: summarise and group_by

# Data aggregation is an important step in data analysis and preparation. 

# First, let's quickly recap why we may want to aggregate the data


# In the data prepraration video, we discussed that it's important to structure our data
# according to our analysis goals. If the analysis is about identifying the best customers, 
# our data must be structured such that each row corresponds to a unique consumer.
# However, if our data is at a transaction level which means each row corresponds to each transaction
# then, there will be many rows that may correspond to the same customer (who may have placed many orders). 
# Thus, before doing any customer level analysis, we will have to aggregate data at the customer level. 
# Remember that we can aggergate transactional level data to consumer level using any of these mean, sum, 
# median, etc. 

# Let's see how we can use summarize function from dplyr to aggregate data 

# First we will take a simple example of aggregating data using the existing unit of observation
# This means just calculating mean, total, etc over the entire rows in the dataset

# The syntax for the summarize command is as follows
# data_summary <- data %>% summarise(avg_col1 = mean(col1))

# Here, first we pass data to the summarize command using %>% and then tell R to calculate mean of col1
# from our data and save the mean into a column called avg_col1. 

#####################################################################################################
## Important Note - The results you see in the video and in this notebook may diverge slightly due to 
## differences in the datasets (we provide small dataset to you).
#####################################################################################################

# Load and install package "dplyr"

#install.packages("dplyr") # If the package is already installed, let this line be commented
# else, remove hash before "install.packages" function above
library(dplyr)

# Calculating mean price and cost for our ities dataset

df <- read.csv("ities.csv") # make sure the data "ities.csv" is in your working directory

df_price_cost_summ <- df %>% summarise(avg_Price = mean(Price), avg_Cost = mean(Cost))

# This was easy, however, you would see that this is not very useful. We could have used simple "summary"
# command to get summaries over all rows together. 
summary(df)

# For aggregating data at a different level, we must first group our data by a column such as CustomerCode, 
# Department, CashierName, etc. 

# Below we show how to summarize the Price and Cost (using mean) by Department 

df_dpartment <- df %>% group_by(Department) %>% summarise(avg_Price = mean(Price), 
                                                          avg_Cost = mean(Cost))


####################################################################################################
# Important Note - dplyr shows both summarise and summarize functions. 
# sometimes R throws error due to function name conflict with other packages. 
# Thus, if you get an error do this trick - "dplyr::summarise" or "dplyr::summarize"
# What "::" does is that it tells R to get the function from the package specified before "::'. 
####################################################################################################


# If you want to get mean Price for each department every day of the week, you can specify two column names
# Department and WeekDay spearated by a comma.

df_deparement_day <- df %>% group_by(Department, WeekDay) %>% summarize(avg_Price = mean(Price))

# To summarize (pun totally intended), we learned how to sumamrize/ aggregate our data at different levels using two
# important function summarise and group_by