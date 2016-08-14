# CodeBook for Getting and Cleaning Data Course Project

## Raw Data

The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone.

**Data file**: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

**Data Set Description**: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

There are 3 types of files:

x: rows of feature measurements
y: the activity labels corresponding to each row of X. Encoded as numbers.
subject: the subjects on which each row of X was measured. Encoded as numbers.

In addition, to determine which features are required, we look at the list of features:

features.txt

The encoding from activity labels ids to descriptive names.

activity_labels.txt

## Data read

We create one dataset for each data sets in the downloade folder, one for features names, one for activity lables, 
X test, y test, subject test, and so on.

## Transformation

We use rbind function to bind test data set and train data set base on features, subject and activity and cbind function to create our new complete data set.

Then, we use a for loop to iterate on each 6 activities and transform activities numbers in characters with their corresponding activity labels.

Using the gsub function, we replace variables names with descriptive ones.

We then finish by creating a new data.table from our newDataset, average each variables and order them by Subject and Activity.

The output is a text file named "TidyData.txt".

**FChemin** 2016-08-15
