library(zip)
library(tidyr)
library(data.table)

## Opens connection to data location and downloads file, if no data directory exists
if(!file.exists('./99_Data')){
        fileUrl <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
        temp <- tempfile()
        download.file(url = fileUrl, destfile = temp)
        unzip(zipfile = temp)
        file.rename('./UCI HAR Dataset/', './99_Data')
}

## imports training data into various data tables
subject_train <- data.table::fread(
        file = './99_Data/train/subject_train.txt',
        header = FALSE,
        verbose = TRUE,
        col.names = 'participant',
        strip.white = TRUE,
)

activities_train <- data.table::fread(
        file = './99_Data/train/y_train.txt',
        header = FALSE,
        verbose = TRUE,
        col.names = 'activitylabel',
        strip.white = TRUE,
)

headings_train <- data.table::fread(
        file = '99_Data/features.txt',
        header = FALSE,
        verbose = TRUE,
        sep = ' ',
        col.names = c('featurename'),
        select = 2,
        strip.white = TRUE
)

column_selectors_train <- headings_train[
        like(featurename, pattern = '*(-std|-mean)'),
        which = TRUE
]

column_names_train <- headings_train[
        like(featurename, pattern = '*(-std|-mean)')
]


column_names_train$featurename <- column_names_train[, featurename := gsub('\\(\\)', '', column_names_train$featurename)]
column_names_train$featurename <- column_names_train[, featurename := gsub('-', '', column_names_train$featurename)]
column_names_train$featurename <- tolower(column_names_train$featurename)

data_train <- data.table::fread(
        file = './99_Data/train/X_train.txt',
        header = FALSE,
        verbose = TRUE,
        sep = ' ',
        col.names = unlist(column_names_train),
        select = column_selectors_train,
        strip.white = TRUE
)

factor_train <- data.table::fread(
        text = rep('train', lengths(subject_train)),
        header = FALSE,
        verbose = TRUE,
        col.names = c('set')
)

## combines all data tables containing training data into one data table
training_data <- cbind(
        subject_train,
        activities_train,
        factor_train,
        data_train
)

## Imports test data into various data tables
subject_test <- data.table::fread(
        file = './99_Data/test/subject_test.txt',
        header = FALSE,
        verbose = TRUE,
        col.names = 'participant',
        strip.white = TRUE,
)

activities_test <- data.table::fread(
        file = './99_Data/test/y_test.txt',
        header = FALSE,
        verbose = TRUE,
        col.names = 'activitylabel',
        strip.white = TRUE,
)

headings_test <- data.table::fread(
        file = '99_Data/features.txt',
        header = FALSE,
        verbose = TRUE,
        sep = ' ',
        col.names = c('featurename'),
        select = 2,
        strip.white = TRUE
)

column_selectors_test <- headings_test[
        like(featurename, pattern = '*(-std|-mean)'),
        which = TRUE
]

column_names_test <- headings_test[
        like(featurename, pattern = '*(-std|-mean)')
]

column_names_test$featurename <- column_names_test[, featurename := gsub('\\(\\)', '', column_names_test$featurename)]
column_names_test$featurename <- column_names_test[, featurename := gsub('-', '', column_names_test$featurename)]
column_names_test$featurename <- tolower(column_names_test$featurename)

data_test <- data.table::fread(
        file = './99_Data/test/X_test.txt',
        header = FALSE,
        verbose = TRUE,
        sep = ' ',
        col.names = unlist(column_names_test),
        select = column_selectors_test,
        strip.white = TRUE
)

factor_test <- data.table::fread(
        text = rep('test', lengths(subject_test)),
        header = FALSE,
        verbose = TRUE,
        col.names = c('set')
)

## combines all data tables containing test data into one data table
test_data <- cbind(
        subject_test,
        activities_test,
        factor_test,
        data_test
)

## combines test and training data into one large data table
full_data <- rbind(
        test_data,
        training_data
)

## Assigns descriptive names to activity factor by importing activity names into data table
activity_labels <- data.table::fread(
        file = './99_Data/activity_labels.txt',
        header = FALSE,
        verbose = TRUE,
        sep = ' ',
        col.names = c('labels'),
        select = 2,
        strip.white = TRUE
)

full_data$activitylabel <- factor(full_data$activitylabel, levels = (1:6), labels = unlist(activity_labels))


## creates second, tidy data set, compressing multiple readings for each activity along factor variable
final_data <- full_data[,
        lapply(.SD, mean, na.rm = TRUE),
        by = list(participant, activitylabel, set),
        .SDcols = unlist(column_names_test)
]

