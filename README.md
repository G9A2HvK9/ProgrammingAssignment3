# ProgrammingAssignment3
Programming Assigngment from course 3 - getting &amp; cleaning data - Johns Hopkins University data science track on coursera

## Assignment:
You should create one R script called run_analysis.R that does the following:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Method:

1. Open R-Studio and run:
`install.packages('zip', 'tidyr', 'data.table')`

2. Run `run_analysis.r`

3. The script will output a .txt file, which aggregates the raw data into average for every measurement variable along the factor variables of participant and activity type. For a closer description, please refer to the codebook.


## In the script:

The script takes the Human Activity Recognition Using Smartphones Data Set (available [here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)) and modifies it to present a cleaner data set, which aggregates the raw data into averages.

The final output presents a clean data set under the name `final_data.txt` where training and test data are combined into a single data table. The raw data readings are averaged along the factor variables of participant and activity. Accordingly the output delivers the average reading for each activity carried out by each participant.