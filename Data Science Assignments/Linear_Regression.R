############# Predictive Analytics with R #####################################

######################### Linear Regression ###################################

df3 <- read.csv("MMix.csv",header=TRUE,stringsAsFactors = FALSE)

head(df3)

df4<-df3[,1:12]
head(df4)
summary(df4)

# Model building

#Iteration 1 - only one X - Base.Price
Reg <- lm(NewVolSales ~ Base.Price,data=df4) # y~x

# Sales = m * Base price + C

Reg
summary(Reg)

# Errors of good model normally distributed with zero mean - Most of the data accumulated in the mean

# Multivariate regression model

# Iteration 2 - Base Price + Instore

Reg <- lm(NewVolSales ~ Base.Price+InStore,data=df4)
summary(Reg)

# Lower the P-Value, higher the significance

# Iteration 3 - Base Price + Instore + TV

Reg <- lm(NewVolSales ~ Base.Price+InStore+TV,data=df4)
summary(Reg)

# Iteration 4 - Base Price + Instore + WebCamp

Reg <- lm(NewVolSales ~ Base.Price+InStore+WebCamp,data=df4)
summary(Reg)

# WebCamp doesnt add value as Beta value doesnt correlate to logical thinking , so rejecting.

# Choose the model with highest R square

###### Testing the models

# Get predicted values

PredSales<-predict(Reg,data=df4)

# Find residuals

Residuals <- resid(Reg)

plot(Residuals)

# To check for multicollinearity
library(HH)
vif(Reg) # VIF of x variable 


