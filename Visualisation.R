############Visualizing data using plots################
df <- read.csv("R/Business Analytics/ities_prem.csv",stringsAsFactors = FALSE)

library(ggplot2)

p <- ggplot(data=df)

#Aesthetic mapping
p1 <- ggplot(data= df, mapping = aes(x=Price))
p1

p2 <- p1 + geom_histogram(bins=200)
p2

#Lets log transform our data----
p1_log <- ggplot(data=df,mapping = aes(x=log(Price)) )
p2_log <- p1_log + geom_histogram(bins = 200)
p2_log

#Box plot----
#Zoom into a smaller range for Price (0-50) to see if we can see the box plot
p1 <- ggplot(data= df, mapping = aes(y=Price))

p2 <- p1 + geom_boxplot() + coord_cartesian(ylim = c(0,50))  #For zooming in
p2

#Box plot for log price
p1 <- ggplot(data= df, mapping = aes(y=log(Price)))

p2 <- p1 + geom_boxplot()
p2

#Explore a categorical variable
library(dplyr)
df <- df %>% mutate(Premium= ifelse(df$Price> mean(df$Price)+2*sd(df$Price),1,0))
df$Premium
#Bar chart with counts----
p1 <- ggplot(data=df %>% filter(Premium==1),mapping = aes(x=LineItem)) +geom_bar()
p1

#For flipping the graph
p1 <- ggplot(data=df %>% filter(Premium==1),mapping = aes(x=LineItem)) +geom_bar()
p1+coord_flip()

#Bar Charts with Proportions
p1 <- ggplot(data=df %>% filter(Premium==1),mapping = aes(x=LineItem)) 

p2 <- p1 + geom_bar(aes(y=..count../sum(..count..)))+
      scale_y_continuous(labels = scales::percent_format())
p2

####Scatter plot#######
#Creating visualization for association between 2 variables

p1 <- ggplot(data= df, mapping = aes(x=Quantity,y=Price))
p2 <- p1 + geom_point()
p2

p1 <- ggplot(data= df, mapping = aes(x=Quantity,y=Price))
p2 <- p1 + geom_point() + geom_smooth()   #Adds a line
p2

p1 <- ggplot(data= df, mapping = aes(x=log(Quantity),y=log(Price)))
p2 <- p1 + geom_point() +geom_smooth(method = "lm")
p2

#####Bi-variate variables########
#One is numerical and one is categorical

p1_log <- ggplot(data= df, mapping = aes(x=log(Price),fill=factor(Premium)))
p2_log <- p1_log + geom_histogram(aes(y=..density..),alpha=0.6)     
p2_log

#Box plot
p1_log <- ggplot(data= df, mapping = aes(y=log(Price),fill=Department))
p2_log <- p1_log + geom_boxplot() 
p2_log

#Violin plot
p1 <- ggplot(data= df, mapping = aes(x=factor(Premium),y=log(Price),fill=factor(Premium)))+ geom_violin()
p1

#####Between 2 categorical variables##########
cross_tab <- xtabs(~Department+WeekDay,data = df)
department <- rownames(cross_tab)
weekday <- colnames(cross_tab)

df1 <- expand.grid(department,weekday)
df1
Count <- as.vector(cross_tab)
df1$Count <- Count

#The number of observations for each department for each day of the week
p1 <- ggplot(data= df1, aes(x=Var1,y=factor(Var2),size=Count))
p2 <- p1+ geom_point(col="red") + labs(x="Department",y="Weekday")
p2

##########Multi dimensional plots##############
library(stringr)

df <- df %>% mutate(Beef= ifelse(str_detect(LineItem,"Beef"),1,0))  #To check if beef is there in item

p1 <- ggplot(data= df, mapping = aes(x=log(Quantity),y=log(Price),col=factor(Beef)))
p2 <- p1 + geom_point() + geom_smooth(method="lm",se=TRUE)
p2

######Intro to ggplot builder########
install.packages("esquisse")
#Use addins and select ggplot builder from that