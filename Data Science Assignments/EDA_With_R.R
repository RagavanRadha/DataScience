### Data Visualization with R ######################################

# Base plotting and ggplot2 (package for visualization)

# Base plotting

# Using plot() to study continuous variable

library(datasets)
data(iris)
str(iris)
dim(iris)

# Scatter plot

plot(x=iris$Petal.Width,y=iris$Petal.Length) 

#Adding labels and titles

plot(x=iris$Petal.Width,y=iris$Petal.Length,main="Title",xlab='X',ylab="y") 

# Adding colors to that

plot(x=iris$Petal.Width,y=iris$Petal.Length,main="Title",xlab='X',ylab="y",col='red') 

# Adding different plotting symbol

plot(x=iris$Petal.Width,y=iris$Petal.Length,main="Title",xlab='X',ylab="y",col='red',pch=2) 
plot(x=iris$Petal.Width,y=iris$Petal.Length,main="Title",xlab='X',ylab="y",col='red',pch=3) # pch will take 0:18 

# Adding more options

plot(x=iris$Petal.Width,y=iris$Petal.Length,main="Title",xlab='X',ylab="y",col='red',type='b') # type b denotes point and connect it via line

# Making conditional bivariate plot

plot(x=iris$Petal.Width,y=iris$Petal.Length,main="Title",xlab='X',ylab="y",col=iris$Species)
plot(x=iris$Petal.Width,y=iris$Petal.Length,main="Title",xlab='X',ylab="y",col=iris$Species,pch=as.numeric(iris$Species))
plot(x=iris$Petal.Width,y=iris$Petal.Length,main="Title",xlab='X',ylab="y",col=iris$Species,cex=as.numeric(iris$Species)) # cex change the size of symbol

plot(x=iris$Petal.Width,y=iris$Petal.Length,main="Title",xlab='X',ylab="y",col=iris$Species,pch=as.numeric(iris$Species)) # cex change the size of symbol

legend(0.5,7,c("Setosa","Versicolor","Verginica"),pch=1:3,col=1:3)

# Univariate Analysis

# Histogram and Boxplot used to understand the distribution of one continuous variables

#Boxplot - To detect outliers

boxplot(iris$Petal.Length,col="red",main="Title")
summary(iris$Petal.Length)# Petal length is negatively skewed 
box<-boxplot(iris$Sepal.Width)
summary(iris$Sepal.Width)
class(box$out) # Show the outliers

# Normal distribution - mean mode and median is almost equal

############### EDA - case study with Market Mix data #########################################

mix<-read.csv("MMix.csv")

library(ggplot2)
library(dplyr)

names(mix)

# Univariate analysis

#Distributions of sales
quantile(mix$NewVolSales,p=c(1:100)/100) # Divide data into 100 equal parts

# Find the average sales by website campaign

df<-mix%>%group_by(mix$Website.Campaign)%>%summarise(Avg_sales=mean(mix$NewVolSales))%>%as.data.frame()
df

aggregate(mix$NewVolSales,by=list(mix$Website.Campaign),mean)

# Correlation : Relation between continuous variables

cor(mix[c(1,2,4)])

# Relation between continuous variables can be explained using correlation and scatter plot
library(corrgram)
plot3 = corrgram(mix[c(1,2,4)],lower.panel = panel.cor,upper.panel = panel.pts )

################## EDA - session 2 ###################################

## How to make sense out of the data ?

# Credit history data - German bank

# How would you relate it to the target variable?

df1<-read.csv("GOODBAD.csv",stringsAsFactors = TRUE)

summary(df1)
colSums(is.na(df1))
# For duration column, Mean > Median so it is positively skewed i.e. longer tail at the right
# Duration - 72 can be potential outlier which is significantly different from rest of the data

quantile(df1$Duration)
hist(df1$Duration)
boxplot(df1$Duration)
plot(density(df1$Duration))

new = quantile(df1$Duration,p=c(1:100)/100)
new = quantile(df1$Duration,seq(0.99,1,0.001)) # To check for 99% to 100%
new
# Looks like 72 is one such value and actually different from rest of the data, so it can be potential outlier

df1[df1$Duration > 60,]

# Outlier treatment - drop, replace with global average or replace with local average, sometimes client tell you,
# capping at 99% percentile or 1% percentile, regression

summary(df1$Amount)

new = quantile(df1$Amount,p=c(1:100)/100)
new
boxplot(df1$Amount)

nrow(df1[df1$Amount>15000,])

table(df1$CreditHistory,df1$GoodBad)
table(df1$GoodBad,df1$Check_Account_Status)/nrow(df1)
table(df1$GoodBad,df1$CreditHistory)/nrow(df1)

# Data preparation

# Treat outlier

dim(df1)
index<-which(df1$Duration > 61) # > 61 is potential outlier
length(index)
df1<-df1[-index,] # Delete the row of outlier
dim(df1)

x <- boxplot(df1$Amount)
str(x)
list<-x$out
length(list)

index <-which(df1$Amount %in% list)
index
length(index)
summary(df1$Amount)

mean_sw<-mean(df1$Amount,na.rm = TRUE) # Outliers treated with local average
df1$Amount[index] <- mean_sw
summary(df1$Amount)

boxplot(df1$Amount)

# Missing value imputation

df1$Age[which(is.na(df1$Age))] <- mean(df1$Age,na.rm=TRUE)
colSums(is.na(df1))

#na omit

library(randomForest)
df1$Age<-na.roughfix(df1$Age) # Create customised constituent for missing values

# Error value & transformation

df1$GoodBad <- ifelse(df1$GoodBad == -1,1,df1$GoodBad)
df1$GoodBad <- ifelse(df1$GoodBad == 1,1,0)
df1$GoodBad

# Qualitative to Quantitative data Transformation

# Nested if condition
df1$Check_Account_Status =
  with(df1,ifelse(df1$Check_Account_Status == "A11",1,
                  ifelse(df1$Check_Account_Status == "A12",2,
                         ifelse(df1$Check_Account_Status == "A13",3,
4))))
head(df1$Check_Account_Status)

# Dummy variable creation - Create n-1 dummies for factor of n levels

library(dummies)
dummy<-dummy(df1$CreditHistory)
dim(dummy)
df1<-cbind(df1,dummy)
head(df1)

# Correlation - To understand the strength of relationship between two continuous variables
# Quantify the interdependencies between x variables

cor(df1$Amount,df1$Duration)

names(df1)
