# Getting and Cleaning Data

## Project requirement

You should create one R script called run_analysis.R that does the following.

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set.
4. Appropriately labels the data set with descriptive activity names.
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## how the run_analysis.R script works

1. Package "data.table" and "reshape2" are required for this project, so load them first (assuming they are installed)
2. Load all datasets for both test and train from the home directory
3. Name the X dataset with features, and then extract only the measurements on the mean and standard deviation for each measurement which complete step 2
4. Uses descriptive activity names to name the activities in the data set which complete step 3
5. Name y and subject dataset which complete step 4
6. Bind X, y, and subject data for both test and train and then merge them together which complete step 1
7. Make specific tidy data as required in step 5 and a tidy_data.txt will be generated in the home directory
