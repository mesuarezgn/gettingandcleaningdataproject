# 0. Downloading and unziping the data

if(!file.exists("./data")){
  dir.create("./data")
}

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./data/dataset.zip")
unzip(zipfile="./data/dataset.zip",exdir="./data")


# 1. Merges the training and the test sets to create one data set.

### Load the data that will be used on this script
### The dplyr package is necessary for this step

library(dplyr)

subject_test <- tbl_df(read.table("./data/UCI HAR Dataset/test/subject_test.txt"))
x_test <- tbl_df(read.table("./data/UCI HAR Dataset/test/X_test.txt"))
y_test <- tbl_df(read.table("./data/UCI HAR Dataset/test/y_test.txt"))

subject_train <- tbl_df(read.table("./data/UCI HAR Dataset/train/subject_train.txt"))
x_train <- tbl_df(read.table("./data/UCI HAR Dataset/train/X_train.txt"))
y_train <- tbl_df(read.table("./data/UCI HAR Dataset/train/y_train.txt"))

features <- tbl_df(read.table("./data/UCI HAR Dataset/features.txt"))
activity_labels <- tbl_df(read.table("./data/UCI HAR Dataset/activity_labels.txt"))


### Changing the header for a descriptible name
names(x_test) <- features$V2
names(x_train) <- features$V2


### Adding the subject and activity names
x_test <- data.frame(subject_test, y_test, x_test)
x_train <- data.frame(subject_train, y_train, x_train)


### Combining the data
project_db <- bind_rows(x_test, x_train)
names(project_db)[1] <- "subject"
names(project_db)[2] <- "activity"


# 2. Extracts only the measurements on the mean and standard deviation for each measurement.

### Subset the database with only the columns that contains the "mean" word on it
project_db <- select(project_db, 
       subject, 
       activity,
       grep("mean|std", names(project_db)))

### Leaves behind the meanFreq variables. Please refer to the README.md file for a reasoning of this
project_db <- select(project_db, -grep("Freq", names(project_db)))


# 3. Uses descriptive activity names to name the activities in the data set

### Brings the activity names that match the id
project_db$activity <- activity_labels$V2[match(project_db$activity, activity_labels$V1)]

### Lowercasing the activity labels
project_db$activity <- tolower(project_db$activity)


# 4. Appropriately labels the data set with descriptive variable names.
library(tidyr)

### First I'm rearanging the data to show a narrow form. Please see note on the README.md
project_db <- gather(project_db, feature, measurement, -activity, -subject)

### Extract the mean and std words (operations)
secondElement <- function(x){x[2]}
operation <- sapply(strsplit(project_db$feature, "\\."), secondElement)

### Adds the operations to the database on a separte column
project_db <- data.frame(project_db, operation)

### Eliminates the std and mean subsets from the features variables
project_db$feature <- gsub("\\.std\\.\\.|\\.mean\\.\\.","",project_db$feature)
project_db$feature <- gsub("\\.","",project_db$feature)

### It sorts the data to spread the table by operation (mean and std)
project_db <- arrange(project_db, operation, subject, activity, feature)
project_db$tepmid <- 1:(nrow(project_db)/2)
project_db <- spread(project_db, operation, measurement)
project_db$tepmid <- NULL

head(project_db)
  
# 5. From the data set in step 4, creates a second, independent tidy 
# data set with the average of each variable for each activity and each subject.

### Group the data and summarizes it.
tidy_data <- group_by(project_db, subject, activity, feature)
tidy_data <- summarize(tidy_data, meanavg = mean(mean), stdavg = mean(std))

### Creates the .txt file
write.table(tidy_data, "tidy_data.txt", row.name=FALSE)


### Note: to read back this file in R, you can use the script: data <- read.table("tidy_data.txt", header = TRUE)