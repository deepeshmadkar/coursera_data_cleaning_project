# Getting and Cleaning Data - Coursera Course Project.

## Prerequisite
  1. The dataset url - "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip" 
  2. Download and install reshape2 library.

## Steps
The R script with the name `run_analysis.R`, performs the following steps:

1. Setting up working Directory
2. Downloading the file and storing in data directory.
3. creating a .gitignore file and appending the data directory, so data directory wont be pushed in git repository.
4. Downloading and unziping action.
5. Loading activity labels & features from activity_labels.txt & features.txt.
6. Extracting only mean and standard deviation on the required.
7. Loading the train dataset.
8. Binding the train dataset to train variable.
9. Loading the test dataset
10. Binding the test dataset to test variable.
11. Merging the test and train dataset and creating new variable named - alldata.
12. Applying label to the new merged dataset.
13. Converting the activities and subject into factors
14. Loading the reshape library 
15. converting and casting the new dataset to molten dataframe and casting the required.
16. Writing the dataframe to the txt file, named - `tidy.txt`

## Conclusion
 By running the script you will be able to write the output in `tidy.txt`
