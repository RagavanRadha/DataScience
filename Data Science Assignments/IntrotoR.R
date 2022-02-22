sessionInfo() #packages attached for the session
?mean #To search in base R document

#variable creation
var1_num<- 23 # gets operator
var2_char<-"Ragav"
class(var1_num)
class(var2_char)
typeof(var1_num)
typeof(var2_char)

var3_seq<-1:10
class(var3_seq)
typeof(var3_seq)

seq(2,100,1) # Sequence of numbers from start to stop with step
#Data Strcutures in R

#1. Vector --> One dimension of same data type 

var_vec<-c(1,2,3)
class(var_vec)
typeof(var_vec)

vec <- 1:10
class(vec)

#Accessing 
var_vec[1:2]
var_vec[c(1,3)]
var_vec[seq(1,3,1)]

var_vec2 <- 1:10
var_vec2[c(seq(1,3),7)]

# Number of elements in vector
length(var_vec2)

# 2. Matrices --> Two dimension and element of same data type

mat1<-matrix(seq(2,100,2),5,10)
class(mat1)
typeof(mat1)

#Accessing
mat1[1,2]
mat1[c(1,2,3),]
mat1[,3] # It is a vector as it is one dimension
mat1[1,1]<-"Ragav"
class(mat1)
typeof(mat1)
mat1

# 3. Array --> More than one dimension and element of same date type, collection of matrices

arr1<-array(c(1,2,3,"Ragav","Brins","Arav"),dim=c(2,2,3)) # 2 rows 2 columns and 3 matrices
arr1

class(arr1)
typeof(arr1)

# Accessing [Row,Columns,Matrix]
arr1[1,1,1] # 1st row, 1st column and 1st matrix
arr1[1,1:2,]
arr1[,,3]
arr1[,1,1]
class(arr1[,,1])


# 4. List --> Can have many data types with many data structures as well

list1<-list(mat1,arr1,var_vec)
class(list1)
typeof(list1)
list1

class(list1[[3]])
length(list1[[1]][1,])
# Accessing

list1[[2]]
list1[[2]][1,1,2]
list1[[3]]

list2<-list(mat1,arr1,list1)
list2

list2[[3]][[2]][2,1,3]
################################################################################3
####          Data manipulation with R - Session 1 #########################

# 5. DataFrames 

View(iris)
installed.packages()

# How to load data from various sources ?

# Read JSON File

library(jsonlite)
web1<-fromJSON("JSONurl")
web1

# Read CSV File

csv <-read.table("Path file name",sep = ",",header = True) 
# Path file name should be "\\" or "/"

# Read text File

csv <-read.table("Path file name",sep = "\t",header = True) 
# Path file name should be "\\" or "/"

#Read XML File

library(XML)
text<-readLines(url("urlname"))
m1<-readHTMLTable(text,asText=TRUE) # To read the HTML table in the web page
class(m1) # List


######################################################################################

# Data Manipulation in R

getwd() #Present working directory
setwd("C:/Users/ragav") #Change the working directory
getwd()
setwd("C:/Users/ragav/Documents")
getwd()

#Save workspace 

# As .R file - will save only code
# As .Rdata file - will save both code and data

setwd("C:\\Users\\ragav\\R Programming")
save.image("Workspace_IntroTOR.Rdata")

# Load workspace
load("Workspace name")

# Accessing columns 
library(datasets)
iris
colnames(iris)
iris$Sepal.Length
head(iris) # six rows by default
head(iris,3)
tail(iris)

nrow(iris)
ncol(iris)
dim(iris)
str(iris)
summary(iris)

# Create new dataframe of subset of iris
iris1 <-iris[,1:3]
iris1

# To change the datatype of column (Typecast)
iris$Species<-as.character(iris$Species) # to convert to char
str(iris)

# as.numeric,as.logical,as.factor, as.data.frame, as.array

iris$Index <- as.numeric(iris$Index)
names(iris)
colnames(iris)

# Change column name 

names(iris)
colnames(iris)[2]="Sepal.Width.Old"
class(names(iris))

#What is the index of "Sepal.Width.New"? Which command will tell you the position
which(names(iris)=="Sepal.Width.Old") # Double equal is for comparison
names(iris)[which(names(iris)=="Sepal.Width.Old")]="Sepal.Width"
names(iris)

length(iris) # Number of columns in the dataframe
length(iris$Sepal.Length) # Number of rows in the dataframe

# Summary statistics
mean(iris$Sepal.Length)
min(iris$Sepal.Length)
max(iris$Sepal.Length)
sd(iris$Sepal.Length)
var(iris$Sepal.Length)

View(iris)
unique(iris$Species) # To find unique values in column
length(unique(iris$Species)) # Count of unique values

#Filter dataframe
iris_setosa <-subset(iris,iris$Species=="setosa" 
                     & iris$Petal.Width==0.2 & iris$Sepal.Width > 500)    # & - AND and | - OR Operator

View(iris_setosa)
class(iris_setosa)

# Add new columns in a dataframe

iris$Sepal.Length_New<-iris$Sepal.Length*100
names(iris)
View(iris)
iris <-iris[,c(1,6,2:5)] # Order the columns
View(iris)

#Concatenate two columns

iris$product <-iris$Sepal.Length*iris$Sepal.Width
names(iris)
View(iris)

iris<-iris[,c(1:3,7,4:6)]
round(1234.9019,1)#Round function

sort(iris$Sepal.Length) #Ascending
sort(iris$Sepal.Length,decreasing=TRUE) #Descending
class(iris$Sepal.Length)

order(iris$Sepal.Length) # Tells you the index where you have smallest value
iris$Sepal.Length[order(iris$Sepal.Length)]
iris$Sepal.Length[order(-iris$Sepal.Length)]
head(iris$Sepal.Length)

iris_4<-iris[order(iris$Sepal.Length),] # Sort based on ascending index of column
View(iris_4)
# Sort only sort the specific column, not advisable to use for dataframe. Order should be used

# String Manipulation

iris$Ragavan <- paste("Ragavan","Radha",sep = "_") #Concat the strings
View(iris)
iris$Ragavan<-substr(iris$Ragavan,start=3,stop=5) #Extract the strings based on the position
substr("Ragavan",start=nchar("Ragavan")-3,stop=nchar("Ragavan"))
iris$Species<-gsub("set","par set",iris$Species)

obj<-c("Ragavan_is_the_best_person","Radha_is_the_great_person")
obj1<-gsub("Ragavan","Brindha",obj) # Replace the value
obj[2]
obj1
strsplit(obj,"_") # Splitting the text based on the separator
obj5 <- strsplit(obj,"_")
obj5
obj5[[1]][2]

length(strsplit(obj," "))
class(strsplit(obj," "))
?strsplit


# How to handle dates in R


Date_var<-"2019/12/12"

Date_var1<-as.Date(Date_var,"%Y/%m/%d")
Date_var1
Date_var1+10

class(Date_var1)
Date_var1


# If year is in 2 digits (%y) and 4 digits (%Y)
# If month is in  digits (%m) and full string (%B), short string (%b)
# If date - %d

Date_var3<-c("16/March/12","28/April/22")
Date_Var4 <- as.Date(Date_var3,"%y/%B/%d")
Date_Var4+10


library(lubridate) # Package for date manipulation

date1<-"20-JAN-19"
date1<-dmy(date1)

week(x)
wday(x)

date2<-"JAN-20-2000"
mdy(date2)
class(date2)
class(mdy(date2))

ymd("20191003")
mdy("July 4th,2000")

day(date1)
month(date1)

date<-ymd("2022 April 30")
date
class(date)

yq("2001:Q1") # Extract the quarter

x<-dmy_hms("12-Jan-2020 15:24:10") # Working with date and time

date(x)
day(x)
month(x)
hour(x)
minute(x)
week(x)
am(x)

##############################################################################

################ Manipulation of Data in R - Session 2 ###############
# Connect R with database

# Accessing Database via R, the below mentioned Packages

#ORACLE - RODBC
#MySQL -RmySql
#SQLite - RSQLite
#Hadoop - RHadoop(RMR,RHBASE,RHDFS,RHIVE)
#Tableau - Rserve

# DataBase Server Name, DataBase Name, User ID and Password, DataBase_Driver

library(DBI) # DataBase Interface for all databases 
library(RSQLite)

driver <-dbDriver("SQLite")
db_file <- "Database path name"
conn<-dbConnect(driver,db_name,db_file,username,pwd,hostname)

# mydb= dbConnect(MySQL(),user='abc',password='123',dbname='customerdb',host='12.13.14')


# Required - DB server name, DB name, userid,pwd, db driver

driver <-dbDriver("SQLite") # RSQLite package is required
conn<-dbConnect(driver,db_file)
dbListTables(conn) # To list all the tables
dbListFields(conn,"Tablename") # To list all the columns in specific table 
tmp<-dbReadTable(conn,"Tablename") # Read the content of table in R

dbGetQuery(conn,"Select * from tablename") #Execute the SQL query
dbWriteTable() #to write dataframe into DBtable

# Understanding Factors - 6th datastructures

vf<-factor(c("Ragav","Brindha","Aravinth"))
v1 <-c("a","b","c")
v1_vec <-as.factor(v1)
v1_vec
v1_num<-as.integer(v1_vec) # Assigns number to particular factor of level
v1_num

#How to enforce own number levelling in the data?

#Combining two dataframes horizontally - stacking data frame rbind

iris_1 <- iris [20:30,]
iris_2 <- iris [ 31:50,]

iris_12 <- rbind(iris_1,iris_2)#Row binding of two dataframes , should have same number/name of columns 
dim(iris_12)

#To add index column
iris$Index <- 1:nrow(iris)
View(iris)

colnames(iris)

iris <-iris[,c(8,1:7)]
names(iris)
#Column binding of dataframes

iris_3 <- iris[1:10,c(1,2,3)]
iris_4<- iris[1:10,c(4,5)]
iris_34 <- cbind(iris_3,iris_4) # Column binding should have same number/name of rows
dim(iris_34)

#smartbind - Binding unequal number of rows/column

library(gtools)
View(iris)
iris1<-iris[1:5,c(1,2)]
iris2<-as.data.frame(iris[5:8,3])
View(iris1)
View(iris2)
iris12<-smartbind(iris1,iris2)
View(iris12)

# Merging two columns 

obj <- merge(df1,df2,by=c("col1","col2")) #Combine all columns and get matched values - Inner join
obj <-merge(df1,df2,all.x=TRUE) # Combine all the rows of df1 with matching rows of df2
obj <-merge(df1,df2,all.y=TRUE) #Combine all the rows of df2 with matching rows of df1
obj <-merge(df1,df2) #inner join
obj <-merge(df1,df2,all.x = TRUE, all.y = TRUE) # Full outer join - Returns all rows of x and y

obj <- merge(df1,df2,by.x="colname",by.y="colname") # if two columns are same but names are different

# Apply family of function

# How to create a dataframe which contains only numeric datatype ?? Hint - sapply
# How to create a dataframe which contains only character datatype ?? 

library(datasets)
iris
View(iris)
iris<-iris[,2:6]
apply(iris,1,mean) # 1 -> mean of each row - Row wise
apply(iris,2,mean) # 2 -> mean of each column - Column wise

# 1 for rows and 2 for columns

# apply,tapply,mapply,vapply,lapply,ldply,ddply................

tapply(columnname1,list(columnname2),mean) #calculate mean of col1 based on grouping col2, this is groupby

#Reshaping data
#transpose

iris_t <- t(iris) # Columns as Rows and Rows as Columns
View(iris_t)

# Long form to wide form conversion
# Wide form to long form conversion

#crosstabulation - how to find number of record for each category

library(datasets)
data(iris)
View(iris)

table(iris$Species) # table command for cross tabulation
View(iris)

#dplyr package - powerful package for data manipulation
library(dplyr)
library(datasets)
mtcars
View(mtcars)

mydata <- mtcars
mtcars<-distinct(mtcars) # To remove duplicates
mtcars1<-rename(mtcars,displacement =disp,cylinder=cyl) # Rename columns
View(mtcars1)

mtcars2<-filter(mtcars,cyl==6) #Subset of dataframe
View(mtcars2)

mtcars%>%filter(cyl==4) #pipeline package %>%
mtcars3<-mutate(mtcars,mpg_cyl_ratio=mpg/cyl) # Create new columns in the dataframe keeping all the columns intact
View(mtcars3)

mtcars4<-mutate_all(mtcars,funs("Percent"=./100)) # Create new columns for each existing columns
View(mtcars4)
dim(mtcars4)

#Missing values

data(airquality)
View(airquality)
mean(airquality$Solar.R, na.rm=TRUE) # Calculate mean by ignoring missing values
mean(airquality$Solar.R,na.rm = TRUE) # Calculate mean by ignoring missing values

(which(is.na(airquality$Ozone))) #To spot the missing values
ozone_na<-length(which(is.na(airquality$Ozone))) #Count of missing values
percent_data <-ozone_na/nrow(airquality) #Percent of missing values 
percent_data

colSums(is.na(airquality))# Count of missing values in each column
colSums(is.na(airquality))/nrow(airquality) # Percent of missing values in each column

# Missing value treatment?

# 1. Impute or replace
# 2. Ignore or drop
# 3. Drop the column have missing values (More NA Values)

#Two considerations (Purely based on data availability)
# 1. For model building, you should have sizeable amount of data
# 2. Missing Value Treatment is an expensive exercise and doesn't give you exact results

# Ignore the missing values

airquality_without_na <-na.omit(airquality) # Remove entire row which has NA values in airquality df
colSums(is.na(airquality_without_na))

# Impute - with average values
airquality$Ozone[which(is.na(airquality$Ozone))]<-mean(airquality$Ozone,na.rm=TRUE)

#MICE Package and RandomForest - Advanced Missing Values Imputation packages


library(mice) # Imputation by classification and regression trees
library(randomForest)

na.roughfix(randomForest) # Rough imputation of missing values


