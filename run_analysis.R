# You should create one R script called run_analysis.R that does the following. 
# Merges the training and the test sets to create one data set.
# Extracts only the measurements on the mean and standard deviation for each measurement. 
# Uses descriptive activity names to name the activities in the data set
# Appropriately labels the data set with descriptive variable names. 
# From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
if(!require("dplyr")){
    install.packages("dplyr")
}
require("dplyr")

if(!require("reshape2")){
    install.packages("reshape2")
}
require("reshape2")

downloadDataset = function(){
    downloadArchive <- "Dataset.zip"
    extractDir <- "extract"
    if(!file.exists(downloadArchive)){        
        datasetUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        download.file(datasetUrl, destfile=downloadArchive, method="curl")
    }
    
    if(!file.exists(extractDir)){
        dir.create(extractDir)
        unzip(downloadArchive, exdir = extractDir)
    }
}

mergeTrainingAndTestDatasets = function(){
    features <- read.table("extract/UCI HAR Dataset/features.txt")
    
    x_test <- read.table("extract/UCI HAR Dataset/test/X_test.txt")
    x_train <- read.table("extract//UCI HAR Dataset/train/X_train.txt")
    
    activity_labels <- read.table("extract//UCI HAR Dataset/activity_labels.txt")
    subject_train <- read.table("extract//UCI HAR Dataset/train//subject_train.txt")
    subject_test <- read.table("extract//UCI HAR Dataset/test//subject_test.txt")
    
    y_train <- read.table("extract//UCI HAR Dataset/train/y_train.txt")
    y_test <- read.table("extract//UCI HAR Dataset/test/y_test.txt")
    
    names(x_test) <- features$V2
    names(x_train) <- features$V2
    
    y_train_labels <- merge(y_train, activity_labels, by="V1")
    y_test_labels <- merge(y_test, activity_labels, by="V1")
    
    subj_train <- cbind(subject_train, y_train_labels, x_train)
    subj_test <- cbind(subject_test, y_test_labels, x_test)
    
    all_data <- rbind(subj_test, subj_train)
    rm(x_test)
    rm(x_train)
    rm(subj_train)
    rm(subj_test)
    rm(y_train_labels)
    rm(y_test_labels)
    rm(y_test)
    rm(y_train)
    rm(subject_test)
    rm(subject_train)
    interesting_columns <- grepl("mean|std", features$V2)
    
    all_data_subcols <- all_data[, interesting_columns]
    
    names(all_data_subcols)[1] <- "Subject"
    names(all_data_subcols)[2] <- "Activity"
    names(all_data_subcols)[3] <- "Activity.Label"
    rm(all_data)
    
    all_data_subcols
}

writeTidyData <- function(data){
    melted_data <- melt(data, id.vars = c("Subject", "Activity", "Activity.Label"))
    tidy_data <- dcast(melted_data, Subject + Activity + Activity.Label ~ variable, fun.aggregate = mean, 
                       na.rm = TRUE)
    write.table(tidy_data, file = "tidy_data.txt", row.names=FALSE)
}

downloadDataset()
all_data <- mergeTrainingAndTestDatasets()
writeTidyData(all_data)

