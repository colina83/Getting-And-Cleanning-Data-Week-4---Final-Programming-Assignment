### Final Project ###

library(dplyr)
### Imports the Variable for Train ###


########################################################################################################################################################
#Training set

train_data_X <- read.table("~/R Course/Cleanning and Getting Data/Final Programing Assingment/train/X_train.txt", header = FALSE , colClasses = "numeric")  

#Training label

train_labels_y <- read.table("~/R Course/Cleanning and Getting Data/Final Programing Assingment/train/y_train.txt", header = FALSE , colClasses = "numeric") 

# Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

train_subject <- read.table("~/R Course/Cleanning and Getting Data/Final Programing Assingment/train/subject_train.txt", header = FALSE , colClasses = "numeric") 
 
###########################################################################################################################################################
# Test Set 

test_data_X <- read.table("~/R Course/Cleanning and Getting Data/Final Programing Assingment/test/X_test.txt", header = FALSE , colClasses = "numeric")  

# Test label 

test_labels_y <- read.table("~/R Course/Cleanning and Getting Data/Final Programing Assingment/test/y_test.txt", header = FALSE , colClasses = "numeric") 

# Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

test_subject <- read.table("~/R Course/Cleanning and Getting Data/Final Programing Assingment/test/subject_test.txt", header = FALSE , colClasses = "numeric")

##############################################################################################################################################################

# 1.- Merges the training and the test sets to create one data set.
# This code will combined the colums 

TestData_X <- cbind(test_subject,test_labels_y,test_data_X)

TrainData_Y <- cbind(train_subject,train_labels_y,train_data_X)

# This Part will merge both datasets 

MergeData <- rbind(TestData_X,TrainData_Y)

#This part will change the column name 
features <- read.table("~/R Course/Cleanning and Getting Data/Final Programing Assingment/features.txt" , header = FALSE , colClasses = "character")
features <- select(features,V2)
features <- rbind("subject", "activity", features)
features_v <- features$V2
colnames(MergeData) <- features_v

###############################################################################################################################################################

#2.- Extracts only the measurements on the mean and standard deviation for each measurement.

col_std_mean <- grep("-(subject|activity|mean|std)\\(\\)",names(MergeData)) # Extracts Mean
col_std_mean <- c(1,2,col_std_mean)
MergeData_mean_std <- MergeData[col_std_mean]



#############################################################################################################################################################

#3.- Uses descriptive activity names to name the activities in the data set
## In this Part of the Script we will rename the test labels to a clear tidy name to define the activity ##

MergeData_mean_std$activity[MergeData_mean_std$activity == 1] <- "WALKING" 
MergeData_mean_std$activity[MergeData_mean_std$activity == 2] <- "WALKING_UPSTAIRS" 
MergeData_mean_std$activity[MergeData_mean_std$activity == 3] <- "WALKING_DOWNSTAIRS" 
MergeData_mean_std$activity[MergeData_mean_std$activity == 4] <- "SITTING"
MergeData_mean_std$activity[MergeData_mean_std$activity == 5] <- "STANDING"
MergeData_mean_std$activity[MergeData_mean_std$activity == 6] <- "LAYING"

#####################################################################################################################################################

##################################################################################################################################

## 4.- Appropriately labels the data set with descriptive variable names.

## The first Step is to change the names 

names(MergeData_mean_std) <- gsub("^f", "Frequency ",names(MergeData_mean_std))
names(MergeData_mean_std) <- gsub("Acc", "Acceleration ",names(MergeData_mean_std))
names(MergeData_mean_std) <- gsub("BodyBody", " Body ",names(MergeData_mean_std))
names(MergeData_mean_std) <- gsub("Gyro", " Gyroscope ",names(MergeData_mean_std))
names(MergeData_mean_std) <- gsub("^t", " Time Body ",names(MergeData_mean_std))
names(MergeData_mean_std) <- gsub("Mag", "Magnitude ",names(MergeData_mean_std))
names(MergeData_mean_std) <- gsub("Acceleration", "_Acceleration",names(MergeData_mean_std))

#############################################################################################################################################3

## 5.- From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

tidy_data <- group_by(MergeData_mean_std, subject, activity)
final_tidy_data <- summarize_each(tidy_data,funs(mean))


write.table(final_tidy_data, "~/R Course/Cleanning and Getting Data/Final Programing Assingment/tidydata.txt", col.names = TRUE, row.names = FALSE)




