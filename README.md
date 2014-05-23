Project for Getting And Cleaning Data
======================================

This is the repository for the project for the Coursera course, "Getting and Cleaning Data."
-------------------------------------------------------------------------------------

It contains an R script file, called *run_nalysis.R*. It does the following.

1. Merges the training and test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive activity names. 
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

To use the script, do the following in R.

1. Copy the script file *run_analysis.R* in your working directory of R.
2. The folder, named *UCI HAR Dataset*, should be in the same directory.
3. In R, run `> source("run_analysis.R")`. Files for two data sets, *extractedData.txt* and *tidyData.txt*, will be created in the same directory.
