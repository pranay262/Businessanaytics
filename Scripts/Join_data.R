# To merge two datasets 

#####################################################################################################
## Important Note - The results you see in the video and in this notebook may diverge slightly due to 
## differences in the datasets (we provide small dataset to you).
#####################################################################################################

# We will merge two weather data, "df_weather" with the ities data, "df_ities_date". 

# please use only one of the ways to read the data 
df_weather <- read.csv("df_weather.csv") # make sure the data "df_weather.csv" is in your working directory

# or 

df_weather <- readRDS("df_weather.RDS") # make sure the data "df_weather.RDS" is in your working directory


# df_ities_date - The ities dataset aggregated at the date level - each row is a unique date
# wetaher_date - weather data where each row is a unique date.

# date column will be used as the primary key. 

# install.packages("dplyr") # remoev the "#" before "install.packages" if you need to load the packages
library(dplyr)

# a) LEFT_JOIN - Where all the rows from the left dataframe (specified first in the function) are retained in the 
# merged dataset. If any of the rows from left df is missing in the right df, na values are filled in the columns from
# the right df

df_left_joined <- left_join(df_ities_date, df_weather, by = "date")

# Check missing values - we expect na values only in the columns from df_weather
colSums(is.na(df_left_joined))





# b)RIGHT_JOIN - Where all the rows from the right dataframe (specified second in the function) are retained in the 
# merged dataset. If any of the rows from right df is missing in the left df, na values are filled in the columns from
# the left df

df_right_joined <- right_join(df_ities_date, df_weather, by = "date")

# Check missing values - we expect na values only in the columns from df_ities_date
colSums(is.na(df_right_joined))





# c) Full_JOIN - UNION

df_full_joined <- full_join(df_ities_date, df_weather, by = "date")

colSums(is.na(df_full_joined))




# d) INNER_JOIN - INTERSECTION  

df_inner_joined <- inner_join(df_ities_date, df_weather, by = "date")

colSums(is.na(df_inner_joined))

#########################################END##############################################


