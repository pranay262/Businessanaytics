# In this lesson, we will discuss two important operators:

#####################################################################################################
## Important Note - The results you see in the video and in this notebook may diverge slightly due to 
## differences in the datasets (we provide small dataset to you).
#####################################################################################################

# 1) %>%
# 2) %in%

# install the package (by removing the # below), if not already. 
# install.packages("dplyr")
# Load the dplyr package
library(dplyr)

# Read the dataset  form your working directory

df <- read.csv("ities_short.csv")

# 1) %>%

# If we need to filter the data where OperationType is "SALE" and then select the columns "Cost" and 
# "Price", we can do it using "%>%" in a single line of code. 



df_piped <- df %>% filter(OperationType == "SALE") %>% select(Cost, Price) 

# If we were to do the same without "%>%", we can do using either of two ways:

# i) Create an intermediate object (df_1) with the filtered rows and then use select function on df_1  
    
df_1 <- filter(df, OperationType =="SALE")    

df_2 <- select(df_1, Price, Cost)    

# Or

# ii) You may use this complicated code, where your pass "filter(df, OperationType == "SALE")" in the select
# command.
select(filter(df, OperationType == "SALE"), Price, Cost)


# 2) %in%

# This is used to check which elements of a list are present in another list. This returns a boolean vector
# of TRUE and FALSE. 

# Let's say we have the name of two Cashiers in employees object below
employees <- c("Vincent Ball", "Rachael Price" ) 


# Now we want to filter our ities data only for these employees

df_2_emp <- df %>% filter(CashierName %in% employees)

# This function allows us to see which all elements of the first list, CashierName, are present in the second 
# list, employees.  


# Check this out 
df$CashierName %in% employees # This retruns a data object with same number of elements as are in
# df$CashierName - putting True for the elements of df$CashierName that are present in employees.

# On the other hand, if we run the command below, we get the list of TRUE and FALSE for employees that are in the 
# list CashierName

employees %in% df$CashierName


# Thus, you see their order matters with %in%
 

 
 
 
 
 
 
 
