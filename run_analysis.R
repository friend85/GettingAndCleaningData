## R script for the project for Getting and Cleanign Data (coursera course).

# reading values for the test set (2947 observations).
# We assume the data folder is already in the same directory.
testSubject <- read.table("UCI HAR Dataset//test//subject_test.txt")
testActivity <- read.table("UCI HAR Dataset//test//y_test.txt")
testValues <- read.table("UCI HAR Dataset//test//X_test.txt")

# reading values for the train set (7352 observations).
trainSubject <- read.table("UCI HAR Dataset//train//subject_train.txt")
trainActivity <- read.table("UCI HAR Dataset//train//y_train.txt")
trainValues <- read.table("UCI HAR Dataset//train//X_train.txt")

# merging columns first (total of 563 columns).
testSet <- cbind(testValues, testSubject, testActivity)
trainSet <- cbind(trainValues, trainSubject, trainActivity)

# merging train and test sets (total of 10299 observations).
dataSet <- rbind(testSet, trainSet)

# Get only the needed columns (mean and std) for each variable. 
# We use the same column names as the original data.
columnNames <- read.table("UCI HAR Dataset//features.txt")
cols <- columnNames[grepl("mean",columnNames[,2]) | grepl("std",columnNames[,2]),1]
colNames <- columnNames[grepl("mean",columnNames[,2]) | grepl("std",columnNames[,2]),2]

dataSet <- dataSet[,c(cols,562,563)]

# Name the columns with descriptive column names.
colnames(dataSet) <- c("subject", "activity", as.character(colNames))

# Change the activities as labels. 
# (1: WALKING, 2: WALKING_UPSTAIRS, 3: WALKING_DOWNSTAIRS, 4: SITTING, 5: STAINDING, 6: LAYING)
dataSet[dataSet[,81]==1,81] <- "WALKING"
dataSet[dataSet[,81]==2,81] <- "WALKING_UPSTAIRS"
dataSet[dataSet[,81]==3,81] <- "WALKING_DOWNSTAIRS"
dataSet[dataSet[,81]==4,81] <- "SITTING"
dataSet[dataSet[,81]==5,81] <- "STANDING"
dataSet[dataSet[,81]==6,81] <- "LAYING"
dataSet[,81] <- factor(dataSet[,81]) 

# Write this extracted data to a txt file.
write.table(dataSet, "extractedData.txt", row.names=FALSE, col.names=FALSE)

# Now we find the tidy data set (averaging values for the given subject and activity).
subjects <- sort(unique(dataSet[,80]))
activities <- unique(dataSet[,81])

tidySet <- tidySet<-vector("list",81) # temporary list.

for (i in subjects) {
  for (ac in activities) {
    tidySet <- rbind(tidySet, c(as.vector(lapply(dataSet[dataSet[,80]==i & dataSet[,81]==ac,1:79], mean)),i,ac))
  }
}
# delete the first row.
tidySet <- tidySet[2:dim(tidySet)[1],]

colnames(tidySet)[80] <- "subject"
colnames(tidySet)[81] <- "acitivity"

# write this tidy data to a txt file.
write.table(tidySet, "tidyData.txt", row.names=FALSE, col.names=FALSE)
