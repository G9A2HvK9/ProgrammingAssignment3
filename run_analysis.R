library(zip)

## Opens connection to data location and downloads file, if no data directory exists
if(!file.exists('./99_Data')){
        fileUrl <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
        temp <- tempfile()
        download.file(url = fileUrl, destfile = temp)
        unzip(zipfile = temp)
        file.rename('./UCI HAR Dataset/', './99_Data')
}

## loads data sets into console
train_

