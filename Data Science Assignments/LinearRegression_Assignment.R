# Predict the housing price in the suburbs of boston

# Read input file
df<-read.csv("boston_prices.csv",stringsAsFactors = TRUE)

## Get the dimensions of the data
class(df)
head(df)
dim(df)

# Get the summary statistics of the overall data
summary(df)

# Missing value treatment 

colSums(is.na(df))

# There were missing values in MEDV which is a dependent variable, since we have more than 500 records we can drop the na values as this wont affect much

df<-df[-(which(is.na(df$MEDV))),]
colSums(is.na(df))
dim(df)
# Outlier check for each DV :

par(mfrow=c(2,7))

list <-names(df)
list<-list[-4]

for(i in  1:length(list))
{
  boxplot(df[,list[i]],main=list[i])
}
  
dev.off
## CRIM
summary(df$CRIM)
box<-boxplot(df$CRIM)
quantile(df$CRIM,p=c(1:100)/100)

index <- which(df$CRIM > 4)# Treating 4 and more as potential outlier
index
class(index)
df$CRIM[index] <- 4
plot(density(df$CRIM))
summary(df$CRIM)

## ZN

summary(df$ZN)
box<-boxplot(df$ZN)
quantile(df$ZN,p=c(1:100)/100)

##Charles

summary(df$Charles.River.dummy.variable)

## Nitric Oxides

summary(df$nitric.oxides.concentration)

boxplot(df$nitric.oxides.concentration)

# Average rooms

summary(df$X.rooms.dwelling)
boxplot(df$X.rooms.dwelling)
quantile(df$X.rooms.dwelling,p=c(1:100)/100)

index <- which(df$X.rooms.dwelling > 8)# Treating 8 and more as potential outlier
index
class(index)
df$X.rooms.dwelling[index] <- 8
plot(density(df$X.rooms.dwelling))
summary(df$X.rooms.dwelling)

# AGE 

summary(df$AGE)
boxplot(df$AGE)
quantile(df$AGE,p=c(1:100)/100)

# DIS

summary(df$DIS)
boxplot(df$DIS)
quantile(df$DIS,p=c(1:100)/100)

index <- which(df$DIS > 9)# Treating 9 and more as potential outlier
index
class(index)
df$DIS[index] <- 9
plot(density(df$DIS))
summary(df$DIS)

#RAD

summary(df$RAD)
boxplot(df$RAD)
quantile(df$RAD,p=c(1:100)/100)

index <- which(df$RAD > 7)# Treating 8 and more as potential outlier
index
class(index)
df$RAD[index] <- 7
plot(density(df$RAD))
summary(df$RAD)


#TAX

summary(df$TAX)
boxplot(df$TAX)
quantile(df$TAX,p=c(1:100)/100)

index <- which(df$TAX> 450)# Treating 450 and more as potential outlier
index
class(index)
df$TAX[index] <- 450
plot(density(df$TAX))
summary(df$TAX)

# PUP

summary(df$PTRATIO)
boxplot(df$PTRATIO)

#B

summary(df$B)
boxplot(df$B)
quantile(df$B,p=c(1:100)/100)

index <- which(df$B < 300)# Treating 450 and more as potential outlier
index
class(index)
df$B[index] <- 300
plot(density(df$B))
summary(df$B)

#LSTAT

summary(df$LSTAT)
boxplot(df$LSTAT)

index <- which(df$LSTAT> 30)# Treating 30 and more as potential outlier
index
class(index)
df$LSTAT[index] <- 30
plot(density(df$LSTAT))
summary(df$LSTAT)

########### Correlation check for IV and DV

plot(df$CRIM,df$MEDV)
cor(df$CRIM,df$MEDV)

plot(df$ZN,df$MEDV)
cor(df$ZN,df$MEDV)

plot(df$INDUS,df$MEDV)
cor(df$INDUS,df$MEDV)

plot(df$Charles.River.dummy.variable,df$MEDV)
cor(df$Charles.River.dummy.variable,df$MEDV)

plot(df$nitric.oxides.concentration,df$MEDV)
cor(df$nitric.oxides.concentration,df$MEDV)

plot(df$X.rooms.dwelling,df$MEDV)
cor(df$X.rooms.dwelling,df$MEDV)

plot(df$AGE,df$MEDV)
cor(df$AGE,df$MEDV)

plot(df$DIS,df$MEDV)
cor(df$DIS,df$MEDV)

plot(df$RAD,df$MEDV)
cor(df$RAD,df$MEDV)

plot(df$TAX,df$MEDV)
cor(df$TAX,df$MEDV)

plot(df$PTRATIO,df$MEDV)
cor(df$PTRATIO,df$MEDV)

plot(df$B,df$MEDV)
cor(df$B,df$MEDV)

plot(df$LSTAT,df$MEDV)
cor(df$LSTAT,df$MEDV)

## Correlation check between DV

plot(df$X.rooms.dwelling,df$TAX)
cor(df$X.rooms.dwelling,df$TAX)

plot(df$CRIM,df$LSTAT)
cor(df$CRIM,df$LSTAT)

library(car)
## Model Building 

# Iteration 1
reg = lm(MEDV~LSTAT,data=df)
summary(reg)

#Iteration 2 
reg = lm(MEDV~LSTAT+X.rooms.dwelling,data=df)
summary(reg)

# Iteration 3

reg = lm(MEDV~LSTAT+X.rooms.dwelling+TAX,data=df)
summary(reg)

# Iteration 4

reg = lm(MEDV~LSTAT+X.rooms.dwelling+PTRATIO,data=df)
summary(reg)

# Iteration 5

reg = lm(MEDV~LSTAT+X.rooms.dwelling+PTRATIO+DIS,data=df)
summary(reg)

# Iteration 6

reg = lm(MEDV~LSTAT+X.rooms.dwelling+PTRATIO+DIS+RAD,data=df)
summary(reg)

# Iteration 7

reg = lm(MEDV~LSTAT+X.rooms.dwelling+PTRATIO+DIS+TAX,data=df)
summary(reg)

# Iteration 8

reg = lm(MEDV~LSTAT+X.rooms.dwelling+PTRATIO+DIS+TAX+B,data=df)
summary(reg)

# Iteration 9

reg = lm(MEDV~LSTAT+X.rooms.dwelling+PTRATIO+DIS+TAX+B+nitric.oxides.concentration,data=df)
summary(reg)

# Iteration 10

reg = lm(MEDV~LSTAT+X.rooms.dwelling+PTRATIO+DIS+nitric.oxides.concentration,data=df)
summary(reg)

# Iteration 11

reg = lm(MEDV~LSTAT+X.rooms.dwelling+PTRATIO+DIS+nitric.oxides.concentration+Charles.River.dummy.variable,data=df)
summary(reg)

# Iteration 12

reg = lm(MEDV~LSTAT+X.rooms.dwelling+PTRATIO+DIS+nitric.oxides.concentration+Charles.River.dummy.variable,data=df)
summary(reg)

vif(reg)
Predvalues <- predict(reg,data=df)
residual <- resid(reg)
plot(Predvalues,residual,abline(0,0))
