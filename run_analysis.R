## Step 2 -  Merges the training and the test sets to create one data set.

## Set Working Directory
setwd("D:/R/Courses/Getting and Cleaning Data")

## Read the Activity Levels and Feautres Lists
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")
features <- read.table("UCI HAR Dataset/features.txt")

#Read the Subjects
train_subjects <- read.table("UCI HAR Dataset/train/subject_train.txt")
test_subjects <- read.table("UCI HAR Dataset/Test/subject_test.txt")

##Read the Activity Data
train_data <- read.table("UCI HAR Dataset/train/X_train.txt")
test_data <- read.table("UCI HAR Dataset/test/X_test.txt")

##Read the Labels
train_label <- read.table("UCI HAR Dataset/train/y_train.txt")
test_label <- read.table("UCI HAR Dataset/test/y_test.txt") 


##Join the Data
join_data <- rbind(train_data,test_data)
join_subjects <- rbind(train_subjects,test_subjects)
join_label <-rbind(train_label,test_label)


## Step 2 - Extracts only the measurements on the mean and standard deviation for each measurement. 

#Get only the rows we need
deviations <- grep("mean|std", features[, 2])
join_data <- join_data[, deviations]
##Clean up the labels
names(join_data) <- gsub("mean","Mean",names(join_data))
names(join_data) <- gsub("std","Std",names(join_data))
names(join_data) <- gsub("-","",names(join_data))

## Step 3 - Uses descriptive activity names to name the activities in the data set


activity <- activity_labels[join_label[,1],2]
join_label[, 1] <- activity
names(join_label) <- "Activity"

## Step 4 - Appropriately labels the data set with descriptive variable names. 

names(join_subjects) <- "Subject"
all_data <- cbind(join_subjects, join_label, join_data)
write.table(all_data, "clean_data.txt")

