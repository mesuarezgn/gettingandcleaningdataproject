# Getting and Cleaning Data - Final Project
Final project for the Getting and Cleaning Data Course by Johns Hopkins University on Coursera

## Assigment Description
The purpose of this project was to demonstrate the ability to collect, work with, and clean a data set.

The data used was downloaded from the following link:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The technical description of the data (the scientific study that generated the raw information) is beyond the scope of this document, but the details can be found on the folliwng link:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The purporse of the assigment was to create a R script called run_analysis.R that does the following:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set.
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Solution Approach
In this repository you will find the following files:
* README.md
* CodeBook.md
* run_analysis.R
* tidy_data.txt

## tidy_data.txt Notes
In the process of the creating the final documents I went to the forums and I found that many people have different interpretations of how to arrange the data on the tidy_data.txt file. I would like to address two main threads to help my graders on the process of my evaluation:

### 1. mean() vs meanFreq()

I chose the stricted interpretation of the instructions and the tidy data only shows the variables that had the mean() substring on their names, since meanFreq() is another type of measurement. 

### 2. Narrow vs Wide form

I chose the narrow reprentation of the data in order to eliminate the redundancy of each variable (one for the mean and another time for the standard deviation).

This paper helped me to decide this approach:

https://thoughtfulbloke.wordpress.com/2015/09/09/getting-and-cleaning-the-assignment/







