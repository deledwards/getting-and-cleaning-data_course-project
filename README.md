getting-and-cleaning-data_course-project
========================================
## Data Source
-----------
The data was collected as part of the following project:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 


## The Source Dataset
---------------------
The source dataset is from: 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

Please refer to the README in the above zip for an explanation of the source data

## Transformation Details
There are 5 parts:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive activity names.
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Implementation Details.
* Implementation consists of a single R script, run_analysis.R.
* Script makes use of required libraries, ```reshape2``` and ```dplyr```.
* function downloadDataset downloads the zip file and extracts the data files
* function mergeTrainingAndTestDatasets merges test and train datasets and create appropriate labels.
* function writeTidyData creates a new dataset grouped by subject and activity, with averages of all the observed datapoints we are interested in (means and std's)
