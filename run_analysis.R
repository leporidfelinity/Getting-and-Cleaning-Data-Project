# You should create one R script called run_analysis.R that does the following. 
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set.
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. From the data set in step 4, creates a second, independent tidy data set with the 
# average of each variable for each activity and each subject.

# Package "data.table" and "reshape2" are required for this project
library(data.table)
library(reshape2)

# Load X, y, and subject data for both test and train
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")

X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")

# Load activity_labels as activity_lables
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")
# Load features as data_column_names
data_column_names <- read.table("./UCI HAR Dataset/features.txt")

# Name X data with features for each column
names(X_test) <- data_column_names[,2]
names(X_train) <- data_column_names[,2]

# Extract only the measurements on the mean and standard deviation for each measurement
# Complete step 2
extract_measurements <- grepl("mean|std", data_column_names[,2])
X_test <- X_test[,extract_measurements]
X_train <- X_train[,extract_measurements]

# Uses descriptive activity names to name the activities in the data set
# Complete step 3
y_test[,2] = activity_labels[y_test[,1],2]
y_train[,2] = activity_labels[y_train[,1],2]

# Name y and subject data
# Complete step 4
names(y_test) = c("Activity_Label", "Activity")
names(subject_test) = "Subject"
names(y_train) = c("Activity_Label", "Activity")
names(subject_train) = "Subject"

# Bind X, y, and subject data for both test and train
test_data <- cbind(y_test, subject_test, X_test)
train_data <- cbind(y_train, subject_train, X_train)

# Merge test and train data
# Complete step 1
merged_data = rbind(test_data, train_data)

# Make specific tidy data
# Complete step 5
# Melt data
id_labels   = c("Activity_Label", "Activity", "Subject")
measure_vars_labels = setdiff(colnames(merged_data), id_labels)
melt_data <- melt(merged_data, id = id_labels, measure.vars = measure_vars_labels)

# Apply mean function to dataset using dcast function
tidy_data <- dcast(melt_data, Activity + Subject ~ variable, mean)
write.table(tidy_data, file = "./tidy_data.txt")
