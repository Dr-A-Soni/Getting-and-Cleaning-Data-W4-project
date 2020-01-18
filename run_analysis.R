## setting the working directory if not correct
getwd()
setwd("C://Users/chinks/Downloads/Coursera project W4/")
getwd()
# loading the dplyr package 
library(dplyr)

# 1.Reading the data from  tohe downloaded file for this assignment.

#1.1 Reading the train data.
xtrain <- read.table(".//UCI HAR Dataset/train/X_train.txt")

ytrain <- read.table(".//UCI HAR Dataset/train/y_train.txt")

# 1.2 Reading the test data

xtest <-read.table(".//UCI HAR Dataset/test/X_test.txt")

ytest <- read.table(".//UCI HAR Dataset/test/y_test.txt")

# 1.3 Reading the sub. data

sub_train <- read.table(".//UCI HAR Dataset/train/subject_train.txt")

sub_test <- read.table(".//UCI HAR Dataset/test/subject_test.txt")

# 1.4 Reading the data descriptions- features

vari_names <- read.table(".//UCI HAR Dataset/features.txt")

# 1.5 Reading the activities labels

activ_labels <- read.table(".//UCI HAR Dataset/activity_labels.txt")

## Following the instructions for the assignment below are the steps:

## A) Merging the training and test test to create one data set. 

# a) for x set
X_total <- rbind(xtrain, xtest)

# b) for y set
Y_total <- rbind(ytrain, ytest)

# c) for subject set
Sub_total <- rbind(sub_train, sub_test)

# d) looking at dim of all
dim(X_total)
dim(Y_total)
dim(Sub_total)

# combining all a,b,c and creating one large data set.

ALL <- cbind(X_total,Y_total,Sub_total)
dim(ALL)

## B) Extracting only the measurement on the mean
#and Standard Deviation for each measurement in the data set (ALL).

Variables <- vari_names[grep("mean\\(\\)|std\\(\\)", vari_names[,2]),]

X_total <- X_total[,Variables[,1]]

## c) USing descriptive sctivity names to name the activities in the data set ALL. 

colnames(Y_total) <- "activity"

Y_total$activitylabel <- factor(Y_total$activity, labels = as.character(activ_labels[,2]))

activitylabel <- Y_total[,-1]

# d) Appropriately labelling the data set with descriptive variable names.

colnames(X_total) <- vari_names[Variables[,1],2]

## e) Now, from the data set in above step creating a second
    # independent tidy data set with the average of each variable for 
      # each activity and each subject.

colnames(Sub_total) <- "subject"

Complete <- cbind(X_total, activitylabel, Sub_total)

# average

Complete_mean <- Complete %>% group_by(activitylabel, subject) %>% summarise_each(funs(mean))


## creating a text file for the new tidy data

write.table(Complete_mean, file = ".//Getting-and-Cleaning-Data-W4-project/tidy_data.txt", row.names = FALSE,
            col.names = TRUE)

# cross checking data

dim(Complete_mean)
head(Complete_mean)








