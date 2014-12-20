This code merges and prepares a data set for observations of 6 activities of 30 subjects.
The data was collected from the Samsung Galaxy smartphones and distributed in separate training and test sets
along with activity labels and feature (X variable) descriptions. The download links are below:
   
   http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

   https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

*** Important note ***

The code assumes that the data is downloaded into the specified directory of the user.
The user should change the path of the datasets in order to be able to read the files.

***

The code does the following:
 
* Reads the files from the specified directory.
* Merges the train and test files for X, y and subject sets.
* Names the columns of each set.
* Selects the measurements that include only 'mean' and 'standard deviation' from 'features', 
  uses the selection indices to extract only these from X set.
* Renames the values in y set, using the activity labels.
* Merges the properly named subject, y and X sets.
* Extracts the mean values of each measurement for each subject and activity group.
* Writes the final result into a text file 'tidy_data.txt'



   