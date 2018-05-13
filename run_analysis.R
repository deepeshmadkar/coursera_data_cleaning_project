# Setting up working Directory
workingDirectoryPath <- "/Learnings/Rprogrammings/coursera_data_cleaning_project"
setwd(workingDirectoryPath)

# Downloading the file and storing in data directory
# using .gitignore for not uploading the data directory
# so it can be downloaded on run

# checking if data directory exists if not creating it
if(!file.exists("./data")){
 dir.create("data") 
}

# setting the download url and fileName variable to save in data directory
downloadUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
fileName <- "./data/har_dataset.zip"

# checking if file exists or already downloaded, if not it will download
if (!file.exists(fileName)){
  download.file(downloadUrl, fileName, method="curl")
}

# checking if file exists, prior unzip 
# ?unzip - to check the required params for unzipping

if (!file.exists("./data/UCI HAR Dataset")) { 
  unzip(zipfile = fileName, exdir = "./data") 
}

# Loading activity labels & features
activityLabels <- read.table("./data/UCI HAR Dataset/activity_labels.txt")
activityLabels[,2] <- as.character(activityLabels[,2])
features <- read.table("./data/UCI HAR Dataset/features.txt")
features[,2] <- as.character(features[,2])

# Extracting only mean and standard deviation
featuresWanted <- grep(".*mean.*|.*std.*", features[,2])
featuresWanted.names <- features[featuresWanted,2]
featuresWanted.names = gsub('-mean', 'Mean', featuresWanted.names)
featuresWanted.names = gsub('-std', 'Std', featuresWanted.names)
featuresWanted.names <- gsub('[-()]', '', featuresWanted.names)

# loading the train dataset
train <- read.table("./data/UCI HAR Dataset/train/X_train.txt")[featuresWanted]
trainActivities <- read.table("./data/UCI HAR Dataset/train/Y_train.txt")
trainSubjects <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")

# binding the train dataset to train variable
train <- cbind(trainSubjects, trainActivities, train)

# loading the test dataset
test <- read.table("./data/UCI HAR Dataset/test/X_test.txt")[featuresWanted]
testActivities <- read.table("./data/UCI HAR Dataset/test/Y_test.txt")
testSubjects <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")

# binding the test dataset to test variable
test <- cbind(testSubjects, testActivities, test)

# merging the test and train dataset and creating new variable
allData <- rbind(train, test)

# applying label to the new merged dataset
colnames(allData) <- c("subject", "activity", featuresWanted.names)

# converting the activities and subject into factors
allData$activity <- factor(allData$activity, levels = activityLabels[,1], labels = activityLabels[,2])
allData$subject <- as.factor(allData$subject)

# converting an the new dataset named - allData into molten data frame
# install the reshape2 package, if it is not there and load the library.
# install.packages("reshape2")
# ?melt - to check the required params for converting
# ?dcast - to check the required params for casting in data frame
library(reshape2)

allData.melted <- melt(allData, id = c("subject", "activity"))
allData.mean <- dcast(allData.melted, subject + activity ~ variable, mean)

# checking the results of 5 rows
head(allData)

# writing the file as text format
write.table(allData.mean, "tidy.txt", row.names = FALSE, quote = FALSE)