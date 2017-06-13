# Getting And Cleaning Data - Course Project

Explanation about the R script named 'run_analysis.R'.

**Step 1 :** setting the working directory.

**Step 2 :** reading the data sets in R thanks to the read.table. The files that are first used are the following :
- X_test.txt -> table data_test
- y_test.txt -> table lable_test
- subject_test.txt -> table subject_test
- X_train.txt -> table data_train
- y_train.txt -> table label_train
- subject_train.txt -> table subject_train

**Step 3 :** thanks to the cbind function two columns are added to the data_test and data_train tables. The first column represents now the subjects and the second column reprensents the activities.

**Step 4 :** merging the data_test and data_train thanks to the rbind function in order to create one bigger data set named data

**Step 5 :** reading the data set 'features.txt' in R with read.table.The variables of the table 'data' are renamed according to the feature table.

**Step 6 :** Extracting only the measurements on the mean and standard deviation for each measurement. The function grepl is used in order to extract only the variables which contain the words 'mean' and 'std'. Be carefull to exclude the variables which contain the word 'meanFreq'. The table resulting is named 'data2'.

**Step 7 :** reading the data set 'activity_labels.txt' in R with read.table -> table activity.Thanks to the factor function, the numbers written in the column of the activities are replaced by labels that are descriptive activity names according to the table activity.

**Step 8 :** labelling the data set with descriptive variables names using the sub function :
- the '()' and the '-' are deleted
- 'mean' is becoming 'Mean'
- 'std' is becoming 'Std'
- 'Acc' is becoming 'Accelerometer'
- 'Gyro' is becoming 'Gyroscope'
- 'Mag' is becoming 'Magnitute'
- the 't' at the beginning of the variables names are replaced by 'time'
- the 'f' at the beginning of the variables names are replaced by 'frequency'
The first column is named 'Subject' and the second 'Activity'.The table resulting is named 'data3'.

**Step 9 :** From the data set "data3", creating a second, independent tidy data set with the average of each variable for each activity and each subject.
The function which is used is aggregate. The table resulting is named 'data4'.

**Step 10 :** Copying this file in a .txt file named 'tidy_data.txt'.
