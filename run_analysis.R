##
## 1. Reading the files
## Important -- I assume that the files under the directory "UCI HAR Dataset" are copied under "courseproject" folder.
##           -- (Alternatively, one can use 'setwd' command to set the working directory.)
##
## When reading the files, I use "read.table" with header, and sep options. 
## 
X_test <- read.table(file="C:/Users/user/Desktop/coursera/getting_cleaning_data/courseproject/test/X_test.txt",header=FALSE,sep="")
X_train <- read.table(file="C:/Users/user/Desktop/coursera/getting_cleaning_data/courseproject/train/X_train.txt",header=FALSE,sep="")
y_train <- read.table(file="C:/Users/user/Desktop/coursera/getting_cleaning_data/courseproject/train/y_train.txt",header=FALSE,sep="")
y_test <- read.table(file="C:/Users/user/Desktop/coursera/getting_cleaning_data/courseproject/test/y_test.txt",header=FALSE,sep="")
subject_train <- read.table(file="C:/Users/user/Desktop/coursera/getting_cleaning_data/courseproject/train/subject_train.txt",header=FALSE,sep="")
subject_test <- read.table(file="C:/Users/user/Desktop/coursera/getting_cleaning_data/courseproject/test/subject_test.txt",header=FALSE,sep="")
features <- read.table(file="C:/Users/user/Desktop/coursera/getting_cleaning_data/courseproject/features.txt",header=FALSE,sep="")
##
## 2. Merging the train and test files for X, y and subject.
##
## Here, nrow() and ncol() commands are useful to check the number of the rows and columns of each train and test set. 
## 
## X_train -- 7352 rows, 561 columns
## X_test -- 2947 rows, 561 columns
## y_train -- 7352 rows, 1 column
## y_test -- 2947 rows, 1 column
## subject_train -- 7352 rows, 1 column
## subject_test -- 2947 rows, 1 column
##
## The number of columns of train and test variables are matching for each X, y and subject sets.
## One can use rbind to merge them.
X <- rbind(X_train,X_test)
y <- rbind(y_train, y_test)
subject <- rbind(subject_train,subject_test)
##
## 3. Naming the columns
## Although this is asked in the step 4 of the instructions, giving the names earlier makes a lot of sense.
##
## features are X variables, the names of the columns in X set therefore should be matched with the names in features set.
## y variable here is the integers that are corresponding to the activities, given in "activity_labels.txt" file.
##
names(X) <- features[,2]
names(y) <- c("activity")
names(subject) <- c("subject")
##
## Intermediate data looks like this when merging all together by column binding.
##
inter_data <- cbind(subject,y,X)
##
## 4. Extracting only the measures on mean and standard deviation. This is step 3 according to the instructions.
##
## Here I use grep function of R, to extract the indices from features set where the features column2 includes 'mean' or 'std'.
##
sel <- grep("mean|std", features$V2, ignore.case=TRUE, value=FALSE)
## I use the indices to extract only the mean and std measures from X set.
X_means <- X[,sel]
#
## I read activity_labels.txt file as a table in order to match its first column to the values in y set and replace the values with the names
## given in the column 2 of activity_labels.
#
activity_labels <- read.table(file="C:/Users/meltem/Desktop/coursera/getting_cleaning_data/courseproject/activity_labels.txt",header=FALSE,sep="")
#
# The following does a for loop for each row in the y set, matching the values from 1 to 6 to their corresponding activity definitions.
# When a match found, the integer values are replaced by activity labels, e.g., walking.
for (i in 1:nrow(y)) 
{
  for (j in 1:6) 
  {
    if (y[i,1] == j) {
      y[i,1] = as.character(activity_labels[j,2]) }
  }
}
##
## Check for y
## y
## 5. Now, merging all the above together to obtain the subject, activity and measurements in one data set.
data <- cbind(subject, y, X_means)
##
## 6. Final step is to obtain a tidy data set with mean values of each measurement for each subject and activity.
## 
tidy_data <- aggregate(data[,3:ncol(data)],list(data$subject,data$activity),mean)
##
## the step above changes the column names of subject and activity to 'Group1' and 'Group2' respectively.
## To rename them
colnames(tidy_data)[1] <- "subject"
colnames(tidy_data)[2] <- "activity"
##
## Finally writing it into a text file:
write.table(tidy_data, file="C:/Users/user/Desktop/coursera/getting_cleaning_data/courseproject/tidy_data.txt",row.names=FALSE)
