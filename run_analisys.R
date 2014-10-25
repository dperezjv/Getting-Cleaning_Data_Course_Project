## Getting and Cleaning Data Course Proyect
## run_analysis.R gets a tidy data from train and test data set from UCI HAR Dataset folder.

## Load features and activities:

features <- read.table("UCI HAR Dataset//features.txt", header=FALSE) ## 561 obs.

activity <- read.table("UCI HAR Dataset//activity_labels.txt", header=FALSE) ## 6 obs.

## Load train set with features as column names:

Xtrain <- read.table("UCI HAR Dataset//train/X_train.txt", header=FALSE, col.names=features$V2)


## Load train subjects:

trainSubject <- read.table("UCI HAR Dataset/train/subject_train.txt", header=FALSE)

## Load train labels:

trainActivity <- read.table("UCI HAR Dataset//train/y_train.txt", header=FALSE)

## Convert Xtrain to train data frame:

train <- as.data.frame(Xtrain)

## Insert Subjet variable in train data:

train$Subject <- trainSubject$V1

## Convert labels to a factor variables and set its levels:

trainActivity <- as.factor(trainActivity$V1)
levels(trainActivity) <- tolower(activity$V2)

## Insert Labels variable in train data:

train$Activity <- trainActivity

## Load test data with features as column names:

Xtest <- read.table("UCI HAR Dataset//test/X_test.txt", header=FALSE, col.names=features$V2)

## Load test subjects:

testSubject <- read.table("UCI HAR Dataset//test/subject_test.txt", header=FALSE)

## Load test Labels:

testActivity <- read.table("UCI HAR Dataset//test/y_test.txt", header=FALSE)

## Convert test data into a data frame:

test <- as.data.frame(Xtest)

## Insert Subjet variable into test data:

test$Subject <- testSubject$V1

## Convert labels to a factor variables and set its levels:

testActivity <- as.factor(testActivity$V1)
levels(testActivity) <- tolower(activity$V2)

## Insert Labels variable in train data:

test$Activity <- testActivity

## Merge train and test data into tidy data:
intersect(names(train), names(test))

tidyData <- merge(train, test, all=TRUE)


## Select mean and std variables:

control <- grepl("mean", names(tidyData))| grepl("std", names(tidyData))

tidyData2 <- tidyData[control]

control <- !grepl("Freq", names(tidyData2))

tidyData2 <- tidyData2[control]

## Change to Descriptive Variables Names:

names(tidyData2) <- c("timeBodyAccelerometerMeanX", "timeBodyAccelerometerMeanY","timeBodyAccelerometerMeanZ",             
                      "timeBodyAccelerometerStdX","timeBodyAccelerometerStdY", "timeBodyAccelerometerStdZ",                
                      "timeGravityAccelerometerMeanX","timeGravityAccelerometerMeanY","timeGravityAccelerometerMeanZ",     
                      "timeGravityAccelerometerStdX", "timeGravityAccelerometerStdY","timeGravityAccelerometerStdZ",       
                      "timeBodyAccelerometerJerkMeanX","timeBodyAccelerometerJerkMeanY","timeBodyAccelerometerJerkMeanZ",  
                      "timeBodyAccelerometerJerkStdfX","timeBodyAccelerometerJerkStdY","timeBodyAccelerometerJerkStdZ",    
                      "timeBodyGyrometerMeanX", "timeBodyGyrometerMeanY","timeBodyGyrometerMeanZ",                         
                      "timeBodyGyrometerStdX","timeBodyGyrometerStdY","timeBodyGyrometerStdZ",                             
                      "timeBodyGyrometerJerkMeanX","timeBodyGyrometerJerkMeanY","timeBodyGyrometerJerkMeanZ",              
                      "timeBodyGyrometerJerkStdX","timeBodyGyrometerJerkStdY","timeBodyGyrometerJerkStdZ",                 
                      "timeBodyAccelerometerEuclideanMean","timeBodyAccelerometerEuclideanStd","timeGravityAccelerometerEuclideanMean",
                      "timeGravityAccelerometerEuclideanStd","timeBodyAccelerometerJerkEuclideanMean","timeBodyAccelerometerJerkEuclideanStd",
                      "timeBodyGyrometerEuclideanMean", "timeBodyGyrometerEuclideanStd", "timeBodyGyrometerJerkEuclideanMean",
                      "timeBodyGyrometerJerkEuclideanStd","frequencyBodyAccelerometerMeanX", "frequencyBodyAccelerometerMeanY",
                      "frequencyBodyAccelerometerMeanZ", "frequencyBodyAccelerometerStdX","frequencyBodyAccelerometerStdY", 
                      "frequencyBodyAccelerometerStdZ", "frequencyBodyAccelerometerJerkMeanX","frequencyBodyAccelerometerJerkMeanY",
                      "frequencyBodyAccelerometerJerkMeanZ", "frequencyBodyAccelerometerJerkStdfX","frequencyBodyAccelerometerJerkStdY",
                      "frequencyBodyAccelerometerJerkStdZ", "frequencyBodyGyrometerMeanX", "frequencyBodyGyrometerMeanY",   
                      "frequencyBodyGyrometerMeanZ", "frequencyBodyGyrometerStdX","frequencyBodyGyrometerStdY",             
                      "frequencyBodyGyrometerStdZ", "frequencyBodyAccelerometerEuclidanMean","frequencyBodyAccelerometerEuclidanStd", 
                      "frequencyBodyAccelrometerJerkEuclideanMean","frequencyBodyAccelrometerJerkEuclideanStd","frequencyBodyGyrometerEuclideanMean",
                      "frequencyBodyGyrometerEuclideanStd", "frequencyBodyGyrometerJerkEuclideanMean","frequencyBodyGyrometerJerkEuclideanStd")
                      

## Insert Subject and Activity Variables:

tidyData2$Subject <- tidyData$Subject
tidyData2$Activity <- tidyData$Activity

## Load dplyr package

library(dplyr)

## Create a new data set with the average of each variable for each activity and each subject

resume <- tbl_df(tidyData2)
final <- resume %>%
         group_by(Activity, Subject)%>%
         select(-Activity, -Subject)%>%
         transmute(averagetimeBodyAccelerometerMeanX=mean(timeBodyAccelerometerMeanX),
                   averagetimeBodyAccelerometerMeanY=mean(timeBodyAccelerometerMeanY),
                   averagetimeBodyAccelerometerMeanZ=mean(timeBodyAccelerometerMeanZ),
                   averagetimeBodyAccelerometerStdX=mean(timeBodyAccelerometerStdX),
                   averagetimeBodyAccelerometerStdY=mean(timeBodyAccelerometerStdY),
                   averagetimeBodyAccelerometerStdZ=mean(timeBodyAccelerometerStdZ),
                   averagetimeGravityAccelerometerMeanX=mean(timeGravityAccelerometerMeanX),
                   averagetimeGravityAccelerometerMeanY=mean(timeGravityAccelerometerMeanY),
                   averagetimeGravityAccelerometerMeanZ=mean(timeGravityAccelerometerMeanZ),
                   averagetimeGravityAccelerometerStdX=mean(timeGravityAccelerometerStdX),
                   averagetimeGravityAccelerometerStdY=mean(timeGravityAccelerometerStdY),
                   averagetimeGravityAccelerometerStdZ=mean(timeGravityAccelerometerStdZ),
                   averagetimeBodyAccelerometerJerkMeanX=mean(timeBodyAccelerometerJerkMeanX),
                   averagetimeBodyAccelerometerJerkMeanY=mean(timeBodyAccelerometerJerkMeanY),
                   averagetimeBodyAccelerometerJerkMeanZ=mean(timeBodyAccelerometerJerkMeanZ),
                   averagetimeBodyAccelerometerJerkStdfX=mean(timeBodyAccelerometerJerkStdfX),
                   averagetimeBodyAccelerometerJerkStdY=mean(timeBodyAccelerometerJerkStdY),
                   averagetimeBodyAccelerometerJerkStdZ=mean(timeBodyAccelerometerJerkStdZ),
                   averagetimeBodyGyrometerMeanX=mean(timeBodyGyrometerMeanX),
                   averagetimeBodyGyrometerMeanY=mean(timeBodyGyrometerMeanY),
                   averagetimeBodyGyrometerMeanZ=mean(timeBodyGyrometerMeanZ),
                   averagetimeBodyGyrometerStdX=mean(timeBodyGyrometerStdX),
                   averagetimeBodyGyrometerStdY=mean(timeBodyGyrometerStdY),
                   averagetimeBodyGyrometerStdZ=mean(timeBodyGyrometerStdZ),
                   averagetimeBodyGyrometerJerkMeanX=mean(timeBodyGyrometerJerkMeanX),
                   averagetimeBodyGyrometerJerkMeanY=mean(timeBodyGyrometerJerkMeanY),
                   averagetimeBodyGyrometerJerkMeanZ=mean(timeBodyGyrometerJerkMeanZ),
                   averagetimeBodyGyrometerJerkStdX=mean(timeBodyGyrometerJerkStdX),
                   averagetimeBodyGyrometerJerkStdY=mean(timeBodyGyrometerJerkStdY),
                   averagetimeBodyGyrometerJerkStdZ=mean(timeBodyGyrometerJerkStdZ),
                   averagetimeBodyAccelerometerEuclideanMean=mean(timeBodyAccelerometerEuclideanMean),
                   averagetimeBodyAccelerometerEuclideanStd=mean(timeBodyAccelerometerEuclideanStd),
                   averagetimeGravityAccelerometerEuclideanMean=mean(timeGravityAccelerometerEuclideanMean),
                   averagetimeGravityAccelerometerEuclideanStd=mean(timeGravityAccelerometerEuclideanStd),
                   averagetimeBodyAccelerometerJerkEuclideanMean=mean(timeBodyAccelerometerJerkEuclideanMean),
                   averagetimeBodyAccelerometerJerkEuclideanStd=mean(timeBodyAccelerometerJerkEuclideanStd),
                   averagetimeBodyGyrometerEuclideanMean=mean(timeBodyGyrometerEuclideanMean),
                   averagetimeBodyGyrometerEuclideanStd=mean(timeBodyGyrometerEuclideanStd),
                   averagetimeBodyGyrometerJerkEuclideanMean=mean(timeBodyGyrometerJerkEuclideanMean),
                   averagetimeBodyGyrometerJerkEuclideanStd=mean(timeBodyGyrometerJerkEuclideanStd),
                   averagefrequencyBodyAccelerometerMeanX=mean(frequencyBodyAccelerometerMeanX),
                   averagefrequencyBodyAccelerometerMeanY=mean(frequencyBodyAccelerometerMeanY),
                   averagefrequencyBodyAccelerometerMeanZ=mean(frequencyBodyAccelerometerMeanZ),
                   averagefrequencyBodyAccelerometerStdX=mean(frequencyBodyAccelerometerStdX),
                   averagefrequencyBodyAccelerometerStdY=mean(frequencyBodyAccelerometerStdY),
                   averagefrequencyBodyAccelerometerStdZ=mean(frequencyBodyAccelerometerStdZ),
                   averagefrequencyBodyAccelerometerJerkMeanX=mean(frequencyBodyAccelerometerJerkMeanX),
                   averagefrequencyBodyAccelerometerJerkMeanY=mean(frequencyBodyAccelerometerJerkMeanY),
                   averagefrequencyBodyAccelerometerJerkMeanZ=mean(frequencyBodyAccelerometerJerkMeanZ),
                   averagefrequencyBodyAccelerometerJerkStdfX=mean(frequencyBodyAccelerometerJerkStdfX),
                   averagefrequencyBodyAccelerometerJerkStdY=mean(frequencyBodyAccelerometerJerkStdY),
                   averagefrequencyBodyAccelerometerJerkStdZ=mean(frequencyBodyAccelerometerJerkStdZ),
                   averagefrequencyBodyGyrometerMeanX=mean(frequencyBodyGyrometerMeanX),
                   averagefrequencyBodyGyrometerMeanY=mean(frequencyBodyGyrometerMeanY),
                   averagefrequencyBodyGyrometerMeanZ=mean(frequencyBodyGyrometerMeanZ),
                   averagefrequencyBodyGyrometerStdX=mean(frequencyBodyGyrometerStdX),
                   averagefrequencyBodyGyrometerStdY=mean(frequencyBodyGyrometerStdY),
                   averagefrequencyBodyGyrometerStdZ=mean(frequencyBodyGyrometerStdZ),
                   averagefrequencyBodyAccelerometerEuclidanMean=mean(frequencyBodyAccelerometerEuclidanMean),
                   averagefrequencyBodyAccelerometerEuclidanStd=mean(frequencyBodyAccelerometerEuclidanStd),
                   averagefrequencyBodyAccelrometerJerkEuclideanMean=mean(frequencyBodyAccelrometerJerkEuclideanMean),
                   averagefrequencyBodyAccelrometerJerkEuclideanStd=mean(frequencyBodyAccelrometerJerkEuclideanStd),
                   averagefrequencyBodyGyrometerEuclideanMean=mean(frequencyBodyGyrometerEuclideanMean),
                   averagefrequencyBodyGyrometerEuclideanStd=mean(frequencyBodyGyrometerEuclideanStd),
                   averagefrequencyBodyGyrometerJerkEuclideanMean=mean(frequencyBodyGyrometerJerkEuclideanMean),
                   averagefrequencyBodyGyrometerJerkEuclideanStd=mean(frequencyBodyGyrometerJerkEuclideanStd))%>%
         arrange(Activity, Subject)%>%
         unique()
print(final)

rm(Xtest)
rm(Xtrain)
rm(activity)
rm(features)
rm(resume)
rm(test)
rm(testSubject)
rm(tidyData)
rm(train)
rm(trainSubject)
rm(control)
rm(testActivity)
rm(trainActivity)