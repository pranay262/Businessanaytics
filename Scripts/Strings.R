# This script shows string manipulation using stringr package
#####################################################################################################
## Important Note - The results you see in the video and in this notebook may diverge slightly due to 
## differences in the datasets (we provide small dataset to you).
#####################################################################################################

# Install "stringr", if not installed already, by rmeoving the # in the line below
# install.packages("stringr")

# Load the package
library(stringr)


# Checking string length 
# we can use str_length to calculate the length of strings

# we can create variables such item_name_length and see if it relates with other variables.
df$LineItem_Length <-  str_length(df$LineItem)


# We can test correlation of LineItem_Length with other variables such as Quantity, Price, and Cost
cor(df$LineItem_Length, df$Quantity)
cor(df$LineItem_Length, df$Price)
cor(df$LineItem_Length, df$Cost)



# Changing cases
# Convert to lowercase - str_to_lower
a <- c("RICE", "Beverages")
b <- str_to_lower(a)
b



# Convert to upper case - str_to_upper
str_to_upper(b)




# Detecting some useful pattern

# Let's say we want to know how many items have beef, we use the code below 
beef_items <- str_detect(df$LineItem, "Beef") 

# str_detect retruns True wherever the pattern is found

unique(df[beef_items,]$LineItem) # unique function removes duplicate, you may also use "distinct" function from "dplyr"

# In the above code I ask R to first get all the rows that have TRUE value in beef column and the column "LineItem'


# If we want to see how many don't have beef
non_beef_items <- str_detect(df$LineItem, "Beef", negate = TRUE) # using negate we get TRUE where pattern is not detected

unique(df[non_beef_items,]$LineItem)


# replace something in your string
# Syntax - str_replace(dataframe, pattern, replacement)
string <- "We will learn how to replace our strings"
str_replace(string, "how", "WHY")

# In the code above pattern is "how" and replacement is "why"



# split the string on the basis of specified pattern
string <- "We will learn how to split our strings"
str_split(string, pattern = "")


####################################################End#############################################################

