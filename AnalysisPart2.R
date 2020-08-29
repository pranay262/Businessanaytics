#########Filters and Selects####
df <- read.csv("R/Business Analytics/ities.csv",stringsAsFactors = FALSE)

#Select all rows where Cost>11 or Price <13
library(dplyr)
#Filter for selecting rows
df_cp <- filter(df,Cost > 11 | Price > 13)
?filter

#Select for selecting columns
dfcp <- select(df,Cost,Price)
head(dfcp)

#Piped Operator----
#Filter data where operations type is Sale and select columns Cost and Price
df_piped <- df %>% filter(OperationType=='Sale') %>% select(Cost,Price)

 # %in% example
#Suppose we have two employees---
employees <- c("Vincent Ball","Racheal Price")
df_2_emp <- df %>% filter(CashierName %in% employees)   #Shows all rows which have any of those 2 names
head(df_2_emp)

#To create a column with 2 groups (either they are above mean + 2sd or they r below it)----
df$Premium <- ifelse(df$Price> mean(df$Price)+2*sd(df$Price),1,0)
df$Premium

#Same thing using mutate
df <- df %>% mutate(Premiums= ifelse(df$Price> mean(df$Price)+2*sd(df$Price),1,0))
df$Premiums

#To find distinct line items----
premium_items <- df %>% filter(Premiums == 1) %>% select(LineItem) %>% distinct()
premium_items

non_premium_items <- as.list(df %>% filter(Premiums != 1) %>% select(LineItem) %>% distinct())
non_premium_items

############Using dplyr for Summary#############
#It summarises called avg_Price which contains mean of Price
data_price_cost_sum <- df %>% summarise(avg_Price = mean(Price), avg_Cost = mean(Cost))
summary(df)

#it will show how to summarize the Price and cost(using mean and median) by department
df_department <- df %>% group_by(Department) %>% summarise(avg_Price=mean(Price),avg_Cost=mean(Cost))
df_department

#To group by department by every Category
df_department_cat <- df %>% group_by(Department,Category) %>% summarise(avg_Price=mean(Price))
df_department_cat

######Handling Missing Values###############
#Number of missing values in total
sum(is.na(df))

#Number of missing values by column
colSums(is.na(df))

library(tidyr)

#mean imputation
tax <- replace_na(df$Tax,mean(df$Tax,na.rm = TRUE))
sum(is.na(tax))

#median imputation
total_due <- replace_na(df$TotalDue,median(df$TotalDue,na.rm = TRUE))
sum(is.na(total_due))


#########JOINS##################

df_ities_date <- read.csv("R/Business Analytics/df_ities_date.csv",stringsAsFactors = FALSE)
df_weather <- read.csv("R/Business Analytics/df_weather.csv",stringsAsFactors = FALSE)

#Left Join----
#Will contain all rows from ities data and if those rows are missing from weather data
#They will be filled with NA values
df_left_joined <- left_join(df_ities_date,df_weather,by='date')
colSums(is.na(df_left_joined))

#Full Join----
#will contain rows from both datasets but if is available in one and not in other it will be filled with NA
df_full_joined <- full_join(df_ities_date,df_weather,by='date')
colSums(is.na(df_full_joined))

#Inner join (Intersection)----
df_inner_joined <- inner_join(df_ities_date,df_weather,by='date')
colSums(is.na(df_inner_joined))

#############Forms of Representing Data############
df_long <- read.csv("R/Business Analytics/tidy_long.csv",stringsAsFactors = FALSE)
df_wide <- read.csv("R/Business Analytics/tidy_wide.csv",stringsAsFactors = FALSE)

#To convert from wide format to long format----
df_long_new <- df_wide %>% pivot_longer(cols='Quantity_Katherine.Roth': 'Quantity_Vincent.Ball',
                                        names_to = "Cashier", values_to = "Quantity")

#To convert from long format to wide format----
df_wide_new <- df_long_new %>% pivot_wider(id_cols = c(LineItem,CustomerSatisfaction),
                                           names_from= Cashier,values_from= Quantity)

############Mainpulating Strings##############
library(stringr)

df$LineItem_Length <- str_length(df$LineItem)

cor(df$LineItem_Length,df$Quantity)

#Detecting some useful pattern----
#How many times do we have beef
beef_items <- str_detect(df$LineItem,"Beef")
unique(df[beef_items,]$LineItem)

#If we want to see all the items that do not have beef
non_beef_items <- str_detect(df$LineItem,"Beef",negate = TRUE)