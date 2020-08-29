#Read and Write data
#Read in data----
g <- read.csv(file = "C:/Users/HP/Documents/R/Business Analytics/jan17Items.csv", header=TRUE, sep=',')

j17i <- read.csv("Business Analytics/jan17Items.csv",
                stringsAsFactors = F,
                header = T)
head(j17i)

j17w <- read.csv("R/Business Analytics/jan17Weather.csv",
                 stringsAsFactors = F,
                 header = T,
                 sep='\t')

#Write data----
?write.csv  #For help regarding command
write.csv(j17w,"R/Business Analytics/j17w.csv",row.names = F)

j17w2 <- read.csv("R/Business Analytics/j17w.csv",
                  stringsAsFactors = F,
                  header=T,
                  sep=',')

#Getting to know your data----
#Read in your data
df <- read.csv("R/Business Analytics/jan17Items.csv",stringsAsFactors = F,header = T)
dfw <- read.csv("R/Business Analytics/jan17Weather.csv",
                stringsAsFactors = F,
                header = T,
                sep='\t')

#Explore the data frames----
str(df)
dim(df)
names(df)  #Print out the coulumn 

#Referencing and subsetting vectors by location----
v1 <- c(18:23)
v1[2]
v1[2:5]  #2nd to 5th item
v1[c(2,5)]  #2nd and 5th item

#Referencing and subsetting vectors by location----
dfw[1:5,1:3]  #1st to 5th row and 1st to 3rd column
dfw2 <- dfw[,1]
dfw2

#Referencing and subsetting vectors by column name----
dfw$date
dfw[1:5, c('date','PRCP')]
df$BarCode=NULL  #To get rid of a column

#Explore the shape of the data----
summary(dfw)
summary(df$Price)
summary(df[,c('Price','Cost')])

#Visually explore the shape of the data----
hist(dfw$TMAX)
plot(dfw$TMAX)
plot(dfw$TMIN,dfw$TMAX)
plot(dfw$TMAX,type='l')
plot(dfw[,c('TMIN','TMAX','PRCP')])

#Analysing more into the data----
str(df)

#Character Strings ----
x <- 'fox'
class(df$Time)
x <- c('fox','hound')

#Dates and Times----
class(dfw$date)

#Coercion- forcing data from one type to another type----
a <- 5
b <- '5'
class(b)
b <- as.numeric(b)
class(b)

#Packages----
install.packages("lubridate")

#Example of date format vs character format----
date1Words <- 'April 3, 2005'
date1Short <- '04/03/05'
date1Numeric <- 040305

#Use the as.Date function to convert strings to a data type----
d1w <- as.Date(date1Words,format= '%B %d, %Y')
d1s <- as.Date(date1Short,format= '%m/%d/%y')
d1n <- as.Date(date1Numeric,format= '%m/%d/%y')
d1n <- as.Date(date1Numeric,origin = '1970-01-01')

rm(d1n,d1s,d1w)

#Lubridate Package----
install.packages("lubridate")
library(lubridate)
d1w <- mdy(date1Words)
d1s <- mdy(date1Short)

x <- c('Product 1', 'Product 1', 'Product 2', 'Product 2', 'Product 3') 
plot(x)
d1n <- mdy(date1Numeric)
ymd('2005-04-03')

#Converting times to date time objects----
t1w <- mdy_hms('April 3, 2005 10:20:45')
t1w2 <- ydm_hms('2005, 03 April 10:20:45')
t1s <- ymd_hms('05/04/03 10:20:45')
t1n <- dmy_hm('030405T10:20')

#######Calculations that involve date and time#######
#Calculating differences in date and time----
d1n+28
t1n+28

bom<- ymd('2000-01-01')
daysSince2000 <- d1n - bom
class(daysSince2000)

t1s-t1n
difftime(d1n,bom,units='weeks')

#Extracting elements from a date time----
year(d1n)
month(d1n)
month(d1n,label=T)
day(d1n)
wday(d1n)
wday(d1n,label=T)
hour(t1s)
minute(t1s)
second(t1s)

####Using time functions with Business Data----
#Read in items and convert Time to date time format----
df <- read.csv("R/Business Analytics/jan17Items.csv",stringsAsFactors = F,header = T)
class(df$Time)
summary(df$Time)
df$Time <- ymd_hms(df$Time)
class(df$Time)
summary(df$Time)

#Calculate a new column:day of the week----
df$wday <- wday(df$Time,label=T)
class(df$wday)
summary(df$wday)

#Read the jan17 items data----
df <- read.csv("R/Business Analytics/jan17Items.csv",stringsAsFactors = F)
df$Time <- lubridate::ymd_hms(df$Time)  #Convert time to datetime
df$wday <- wday(df$Time,label=T)   #Create a new column for day of the week
class(df$wday)   #Notice the ordered factor type
summary(df$wday)  #The summary is helpful

#Example of why character strings are hard to analyze
class(df$Category)
summary(df$Category)
unique(df$Category)
plot(df$Category)

#Factors are helpful for analysis----
df$Category2 <- factor(df$Category)
str(df$Category2)
summary(df$Category2)   #Default is alphabetic
plot(df$Category2)  #Default is alphabetic
#Order is not ideal

#Forcats package----
install.packages('forcats')
library(forcats)

#Convert to factor and order by frequency----
?fct_infreq
df$Category3 <- forcats::fct_infreq(df$Category)
str(df$Category3)
summary(df$Category3)  
plot(df$Category3) 

#You can lump least frequent levels together----
#If there are too many levels let's keep the top 3 and group the rest together
df$Category4 <- fct_lump(df$Category, n=3)
summary(df$Category4)
plot(df$Category4)
df$Category4 <- fct_infreq(fct_lump(df$Category, n=3))
summary(df$Category4)
plot(df$Category4)

#You can relevel by hand----
df$Category5 <- fct_relevel(df$Category4, 'Salmon and Wheat Bran Salad','Chicken','general')
plot(df$Category5)

#######LOGICAL OPERATORS#############
#Business Data Applications----
df <- read.csv("R/Business Analytics/jan17Items.csv",stringsAsFactors = F)

#Identify rows of data that meet a certain condition----
df$Price>15  #Checks one by one if each price is >15
df[1:5,1:2]
ldf <- df[df$Price>15,]
brdf <- df[df$Category %in% c('Beef','Rice'),]  #Returns all the rows which have beef or rice in category
summary(brdf$Category)
summary(factor(brdf$Category))

#########Conditional Statements###################
df <- read.csv("R/Business Analytics/jan17Items.csv",stringsAsFactors = F)

#Compound Conditional Statements----

#Tell us if Ron is not a Column Name and if Cost is a column name
if(!'Ron' %in% names(df) ){
  print('Ron is not a column name')
}else if('Cost' %in% names(df)){
  print("Cost is a column name")
}else {
  print('Ron and cost are column names')
}

#The correct way
if(!'Ron' %in% names(df)& 'Cost' %in% names(df)){
  print('Ron is not a column name but Cost is')
}else{
  print('Ron and Cost are not column names')
}

#Replace NAs with median value----
summary(df$Price)
medPrice <- median(df$Price,na.rm=T)
df$Price <- ifelse(is.na(df$Price),medPrice,df$Price)  #If price is NA replace with median
summary(df$Price)


##########Stacking data frames Using Rbind and Cbind############
#Read in the 3 files :jan17Items.csv, feb17Items.csv, mar17Items.csv----
j <- read.csv("R/Business Analytics/jan17Items.csv",stringsAsFactors = F)
f <- read.csv("R/Business Analytics/feb17Items.csv",stringsAsFactors = F)
m <- read.csv("R/Business Analytics/mar17Items.csv",stringsAsFactors = F)

#Stacks the rows of 3 files together----
?rbind #For help on the function
allItems <- rbind(j,f,m)
str(allItems)
nrow(allItems) == nrow(j) + nrow(f) + nrow(m)

#stack columns using cbind----
leftSide <- allItems[,1:12]
rightSide <- allItems[,13:21]

allItems2 <- cbind(leftSide,rightSide)

#Notes----
#rbind only works if the number of columns and columns names are same
#rbind coerces column type to character if there's a discrepancy
#cbind only works if the number of rows are equal

###########LOOPS#############
filesToImport <- c('R/Business Analytics/jan17Items.csv', 'R/Business Analytics/feb17Items.csv','R/Business Analytics/mar17Items.csv')

allItem <- data.frame()
for(f in filesToImport){
  tempDf <- read.csv(f,stringsAsFactors = F)
  allItem <- rbind(allItem,tempDf)
  print(f)
}

library(lubridate)
allItem$Time <- ymd_hms(allItem$Time)
allItem$monthName <- month(allItem$Time,label = T)
summary(allItem$monthName)
plot(allItem$monthName)