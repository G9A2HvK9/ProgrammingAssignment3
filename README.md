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
	install.packages('zip', 'tidyr', 'data.table')

2. Run 'run_analysis.r'

3. The script will result in 2 .csv files bing placed into the working directory. 'final_data.csv' and 'full_data.csv'. For a description of both files, please refer to the codebook.