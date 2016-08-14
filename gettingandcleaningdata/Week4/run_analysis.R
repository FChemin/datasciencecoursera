## You should create one R script called run_analysis.R that does the following:

## 1) Merges the training and the test sets to create one data set.
## 2) Extracts only the measurements on the mean and standard deviation for each measurement.
## 3) Uses descriptive activity names to name the activities in the data set
## 4) Appropriately labels the data set with descriptive variable names.
## 5) From the data set in step 4, creates a second, independent tidy data set with the average 
## of each variable for each activity and each subject.

## Workspace and files setup

setwd("/home/florian/Documents/Coursera/datasciencecoursera/Week4")
library(data.table); library(dplyr)

url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
f <- download.file(url, destfile = "wearable_database.zip", method = "curl")

unzip("wearable_database.zip", exdir = "/home/florian/Documents/Coursera/datasciencecoursera/Week4")

## Read test & training dataset

featuresname <- read.table(file = "~/UCI HAR Dataset/features.txt")
activitylabels <- read.table(file = "~/UCI HAR Dataset/activity_labels.txt")
testdata <- read.table(file = "~/UCI HAR Dataset/test/X_test.txt")
testsubject <- read.table(file = "~/UCI HAR Dataset/test/subject_test.txt")
testactivity <- read.table(file = "~/UCI HAR Dataset/test/y_test.txt") 
traindata <- read.table(file = "~/UCI HAR Dataset/train/X_train.txt")
trainsubject <- read.table(file = "~/UCI HAR Dataset/train/subject_train.txt")
trainactivity <- read.table(file = "~/UCI HAR Dataset/train/y_train.txt")

## 1) Merging the sets and create one dataset

features <- rbind(testdata, traindata)
subject <- rbind(testsubject, trainsubject)
activity <- rbind(testactivity, trainactivity)
colnames(features) <- t(featuresname[2])
colnames(subject) <- "Subject"
colnames(activity) <- "Activity"
complete_dt <- cbind(features, subject, activity)

## 2) Extract mean and stdev for each measurement

columns_mean_stdev <- grep(".*Mean.*|.*Std.*", names(complete_dt), ignore.case = TRUE)
columns <- c(columns_mean_stdev, 562, 563)
newDataset <- complete_dt[, columns]

## 3) Rename activities in dataset with descriptive activity names

newDataset$Activity <- as.character(newDataset$Activity)
for (i in 1:6){
  newDataset$Activity[newDataset$Activity == i] <- as.character(activitylabels[i,2])
}
newDataset$Activity <- as.factor(newDataset$Activity)

## 4) Rename dataset variables with descriptive names
## t = Time, f = Frequency, Acc = Accelerometer, Gyro = Gyroscope, Mag = Magnitude, BodyBody = Body, -std() = STD, -mean() = Mean
## gravity = Gravity, tBody = TimeBody, angle = Angle, -freq = Frequency

names(newDataset) <- gsub("^t", "Time", names(newDataset))
names(newDataset) <- gsub("^f", "Frequency", names(newDataset))
names(newDataset) <- gsub("Acc", "Accelerometer", names(newDataset))
names(newDataset) <- gsub("Gyro", "Gyroscope", names(newDataset))
names(newDataset) <- gsub("Mag", "Magnitude", names(newDataset))
names(newDataset) <- gsub("BodyBody", "Body", names(newDataset))
names(newDataset) <- gsub("-std()", "STD", names(newDataset))
names(newDataset) <- gsub("-mean()", "Mean", names(newDataset))
names(newDataset) <- gsub("gravity", "Gravity", names(newDataset))
names(newDataset) <- gsub("tBody", "TimeBody", names(newDataset))
names(newDataset) <- gsub("angle", "Angle", names(newDataset))
names(newDataset) <- gsub("-freq", "Frequency", names(newDataset))

## 5) Create a new tidy data set

newDataset$Subject <- as.factor(newDataset$Subject)
newDataset <- data.table(newDataset)
TidyData <- aggregate(. ~Subject + Activity, newDataset, mean)
TidyData <- TidyData[order(TidyData$Subject,TidyData$Activity),]
write.table(TidyData, file = "TidyData.txt", row.name = FALSE)