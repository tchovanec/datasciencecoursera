
library(dplyr)
library(data.table)

if(!file.exists("./data")){dir.create("./data")}


##Checks to see if the file exists and if it doesn't it will downlaod and unzip the .zip file
destfile <- "./data/Dataset.zip"
if(!file.exists(destfile)){
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "./data/Dataset.zip")
unzip(zipfile = "./data/Dataset.zip", exdir = "./data")
}

##This will get the list of files in the UCI HAR Dataset folder
filepath <- file.path("./data", "UCI HAR Dataset")
files <- list.files(filepath, recursive=TRUE)
files

##Reads in the train label file
trainLabel <- read.table(file.path(filepath, "train","y_train.txt"), header = FALSE)

##Reads in the test Label file
testLabel <- read.table(file.path(filepath, "test", "y_test.txt"), header = FALSE)

##Reads in the train Data file
trainData <- read.table (file.path(filepath, "train","X_train.txt"), header = FALSE)

##Reads in the test Data file
testData <- read.table (file.path(filepath, "test","X_test.txt"), header = FALSE)

##Reads in the train subject data
trainSubject <- read.table(file.path(filepath, "train", "subject_train.txt"), header = FALSE)

##Reads in the test subject data
testSubject <- read.table(file.path(filepath, "test", "subject_test.txt"), header = FALSE)


##Merges the data sets together
subjectData <- rbind(trainSubject, testSubject)
labelData <- rbind(trainLabel, testLabel)
data <- rbind(trainData, testData)

##Reads in the feature data
features <- read.table(file.path(filepath, "features.txt"),header = FALSE)

##Names the Columns
colnames(subjectData) <- "Subject"
colnames(labelData) <- "Activity"
colnames(data) <- t(features[2])
                    
##Cbind all 3 data sets to create one complete data set                    
CompleteData <- cbind(data, labelData, subjectData)


##Extract the Means and Std 
colMeanStd <- grep("mean\\(\\)|std\\(\\)",x = names(CompleteData), ignore.case=TRUE)
filteredColData <- c(colMeanStd,562:563)
extractedData <- CompleteData[,filteredColData]

##Reads in the activity names file
activityLabels <- read.table(file.path(filepath, "activity_labels.txt"), header= FALSE)

## Assign Descriptive Names to the Activity field
extractedData$Activity <- as.character(extractedData$Activity)
for(i in 1:6) {
  extractedData$Activity[extractedData$Activity == i] <- as.character(activityLabels[,2])
}
extractedData$Activity <- as.factor(extractedData$Activity)


##Label the data with descriptive names                                    
names(extractedData)<-gsub("^t", "time", names(extractedData))
names(extractedData)<-gsub("^f", "frequency", names(extractedData))
names(extractedData)<-gsub("Acc", "Accelerometer", names(extractedData))
names(extractedData)<-gsub("Gyro", "Gyroscope", names(extractedData))
names(extractedData)<-gsub("Mag", "Magnitude", names(extractedData))
names(extractedData)<-gsub("BodyBody", "Body", names(extractedData))

##Extract tidy data set
tidyData<-aggregate(. ~Subject + Activity, extractedData, mean)
tidyData<-tidyData[order(tidyData$Subject,tidyData$Activity),]
write.table(tidyData, file = "tidydata.txt",row.name=FALSE)

