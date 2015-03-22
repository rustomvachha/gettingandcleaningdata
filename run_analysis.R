## Getting and Cleaning Data Project

################## INITIAL SETUP ###############################
## Clear console in R
cat("\014")  
# or Crtl + L

## set working directory
## you may change this to your local working directory
setwd("~/KAM/Coursera/Data Specialization/Getting-and-Cleaning-data/project/UCI HAR Dataset")
################## INITIAL SETUP ###############################

################## READ AND COMBINE THE DATA ###############################
## read TEST data
dfXtest <-read.table("test/X_test.txt")

dfytest <-read.table("test/y_test.txt")

dfsubject_test <- read.table("test/subject_test.txt")

## combine the TEST data for X, y and subject 
dftest <- cbind(dfsubject_test, dfytest,dfXtest)


## read TRAINING data
dfXtrain <-read.table("train/X_train.txt")

dfytrain <- read.table("train/y_train.txt")

dfsubject_train <- read.table("train/subject_train.txt")

## combine the TRAIN data for X, y and subject 
dftrain <- cbind(dfsubject_train, dfytrain,dfXtrain)

## concatanate the test and training data into one dataframe
dfall <- rbind(dftest,dftrain)
################## READ AND COMBINE THE DATA ###############################


################## ASSIGN THE COLUMN NAMES FOR THE FEATURES ################
## Read the features. It is VERY important to put stringsAsFactors=FALSE. 
## Otherwise, when you use df_feature_names
## to create the column names, it will put a number (level) instead of the actual value, like "tBodyAcc-mean()".
df_features <- read.table("features.txt", stringsAsFactors=FALSE)

## The feature value is in the second column
df_feature_names <- df_features$V2

## create a character vector of all the column names
df_col_names <- c("subject","activity",df_feature_names)

## assign the column names to the dataframe
names(dfall) <- df_col_names


# the first two 1:Subject, 1:Activity and rest derived from the list of columns
names(dfall[, c(1,2,grep("mean",df_col_names), grep("std",df_col_names))])
dfstdmean <- dfall[, c(1,2,grep("mean",df_col_names), grep("std",df_col_names))]
################## ASSIGN THE COLUMN NAMES FOR THE FEATURES ################



################## PROVIDE DESCRIPTIVE NAMES TO ACTIVITIES ################
## renaming the activities to something meaningful
dfstdmean$activity[dfstdmean$activity == "1"] <- "Walking"
dfstdmean$activity[dfstdmean$activity == "2"] <- "Walking_Upstairs"
dfstdmean$activity[dfstdmean$activity == "3"] <- "Walking_Downstairs"
dfstdmean$activity[dfstdmean$activity == "4"] <- "Sitting"
dfstdmean$activity[dfstdmean$activity == "5"] <- "Standing"
dfstdmean$activity[dfstdmean$activity == "6"] <- "Laying"
################## PROVIDE DESCRIPTIVE NAMES TO ACTIVITIES ################

################## CREATE AND WRITE THE TIDY DATA SET ###################################
## add dplyr library
library("dplyr", lib.loc="/Library/Frameworks/R.framework/Versions/3.1/Resources/library")

dfstdmeangroup <- group_by(dfstdmean,subject,activity)
## check the data using View() 
View(dfstdmeangroup)

## obtain the mean for each subject and activity and verify using View
dfstdmeangroupsm<-summarise_each(dfstdmeangroup,funs(mean))
View(dfstdmeangroupsm)

##### write the database into a file
write.table(dfstdmeangroupsm, file="./tidydatastdmean.txt", row.name=FALSE)

#### verify the data is written correctly by reading the file
dfread <- read.table("./tidydatastdmean.txt")
View(dfread)
################## CREATE AND WRITE THE TIDY DATA SET ###################################







