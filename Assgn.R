########Assignment###########

#1A. Calculate the number of missing values in each column?   

df <- read.csv("R/Business Analytics/ities_short.csv",stringsAsFactors = FALSE)

colSums(is.na(df))

#2.2A. Create a new variable LineItem_LongName coded as 1 #############
#if the length of LineItem is greater than the mean, otherwise 0.  
library(stringr)
df <- df %>% mutate(LineItem_LongName= ifelse(str_length(LineItem)> mean(str_length(LineItem)),1,0))
head(df$LineItem_LongName)

#Visualisation
#2B. Visualize relationship between Department and LineItem_LongName using the number of observations.
cross_tab <- xtabs(~Department+LineItem_LongName,data = df)
department <- rownames(cross_tab)
longname <- colnames(cross_tab)

df1 <- expand.grid(department,longname)
df1
Count <- as.vector(cross_tab)
df1$Count <- Count
p1 <- ggplot(data= df1, aes(x=Var1,y=factor(Var2),size=Count))
p2 <- p1+ geom_point(col="red") + labs(x="Department",y="LineItem_longName")
p2

###########In a shorter way
ggplot(data =df) + geom_count(mapping = aes(x = Department, y = factor(LineItem_LongName)))


#3.################
#3A. Name top 10 CashierName based on the total quantity sold (hint - arrange function can help you sort a column)
#First create the dataframe aggregated at the Cashier Level, with the Total_Quantity
#Creates cashier name according to total quantity
Cashier <- df %>% group_by(CashierName) %>% 
  summarize(Total_Quantity = sum(Quantity)) %>% 
  arrange(desc(Total_Quantity))

#3B. Visualize the 10 CashierNames and their total quantity sold 
ggplot(data = Cashier[1:10,], mapping = aes(x=reorder(CashierName, -Total_Quantity), y=Total_Quantity)) +
  geom_bar(stat="identity") +
  theme(axis.text.x=element_text(angle=45,hjust=1,vjust=1))

#####4.################
#4A. Name bottom 5 LineItems based on average Price
#First create the dataframe aggregated at the LineItem level, with the Average_Price
LineItem <- df %>% group_by(LineItem) %>% 
  summarize(Avg_Price = mean(Price)) %>% 
  arrange(Avg_Price)

#Visualisation
#4B. Visualize the 5 LineItems and their average Price

ggplot(data = LineItem[1:10,], mapping = aes(x=reorder(LineItem, -Avg_Price), y=Avg_Price)) +
  geom_bar(stat="identity") +
  theme(axis.text.x=element_text(angle=45,hjust=1,vjust=1))


#5.###############
#5A. Transform the data into a structure where each unique row is a combination of Month and Department. 
#The data must have columns on Average Price, Average Quantity and Average Cost. 

#In the transformed data frame, visualize the relationship between Average Price, Average Quantity and Average Cost
Month_Dept <- df %>% group_by(Month, Department) %>% 
  summarize(Avg_Price = mean(Price), Avg_Quantity = mean(Quantity), Avg_Cost = mean(Cost) )

#visualisation
#5B.  In the transformed data frame, visualize the relationship between Average Price, Average Quantity and Average Cost 
ggplot(data=Month_Dept, mapping = aes(x= Avg_Price, y = Avg_Quantity, color = Avg_Cost)) +
  geom_point(position = "jitter")

#We can't see much here, Let's look at data within a narrow range by restricting the xlimit and ylimit for the figure.
ggplot(data=Month_Dept, mapping = aes(x= Avg_Price, y = Avg_Quantity, color = Avg_Cost)) +
  geom_point(position = "jitter") +
  lims(y = c(0,2.5), x = c(0,100))

