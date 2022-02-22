######## Logistic Regression ##############################3

# Multicollinearity - Correlation between independent variables

# R Squared - Overall fitness of the model - 
# VIF - Variance Inflation Factor - proxy of multicollinearity VIF is proportional to Multicol
# General cutoff is 2 (Subjective).

# Every input variable made as Y and compute linear regression to compute R2. So VIF = 1/(1-R2)

# Conditions for finalizing the linear and logistic model

  # P value should be low, variables are significant
  # Signs of Beta should be in line with business context
  # Multicollinearity of input variables should be low (VIF)
  # R square should be high

# If Beta is positive, the probability is higher

# P(Y) = eY/(1+eY)

# Y = log(P(Y)/(1-P(Y))) = mX+C

# Check for performance (variables we get after model implementation) and observation window 
# (variables used for model building)


df5 <-read.csv("GOODBAD.csv")
dim(df5)
table(df5$GoodBad)

df5$GoodBad <- ifelse(df5$GoodBad == -1,1,df5$GoodBad)
df5$GoodBad <- ifelse(df5$GoodBad == 1,1,0)
df5$GoodBad

# Sampling

sampling <- sort(sample(nrow(df5),nrow(df5)*.7))

length(sampling)                 

train<-df5[sampling,] # training sample
test <- df5[-sampling,] #  validation sample
nrow(train)
nrow(test)

### Model building

# Iteration 1
glm <-glm(GoodBad~Check_Account_Status,family = binomial,data=train)
summary(glm)

names(train)

# Iteration 2
glm <-glm(GoodBad~Check_Account_Status+CreditHistory,family = binomial,data=train)
summary(glm)

cor(train$Check_Account_Status,train$CreditHistory)

predicted <- predict(glm,data=test,type="response")

#confusion matrix

predbkt<- ifelse(predicted<0.5,'G','B')
table(predbkt,train$GoodBad)

# ROCR Curve(ROCR package), AUC, GINI  (2 * AUC - 1) - A way to measure how good the model is 



