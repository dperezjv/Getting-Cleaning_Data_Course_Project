Getting-Cleaning_Data_Course_Project
====================================

###Introduction

This repository is created for the Getting and Cleaning Data's Course Project. The purpose of this project is to demonstrate the ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis.

### Content

This repository contains:

    1. A R script called run_analisys.R 
    2. A UCI HAR Dataset folder that contains the raw data.
    3. The final tidy Data on tidyData.txt
    

###How to work:

 run_analysis.R gets a tidy data from train and test data set from UCI HAR Dataset folder.
  1. Load features and activities from features.txt and activity_labels.txt.
  2. Load train set with features as column names via X_train.txt called Xtrain.
  3. Load train subjects from subject_train.txt.
  4. Load train labels from y_train.txt
  5. Convert Xtrain to train data frame.
  6. Insert Subjet variable in train data.
  7. Convert labels to a factor variables and set its levels.
  8. Insert Activity variable in train data.
  9. Load test data with features as column names via X_test.txt called Xtest.
  10. Load test subjects from subject_test.txt.
  11. Load test Labels from y_test.txt.
  12. Convert Xtest data into a data frame.
  13. Insert Subjet variable into test data.
  14. Convert labels to a factor variables and set its levels.
  15. Insert Activity variable in train data.
  16. Merge train and test data into data frame called tidyData.
  17. Select mean and std variables via grepl function and set a data frame called tidyData2
  18. Change tidyData2 variables names to descriptive ones.
  19. Insert Subject and Activity Variables from tidyData.
  20. Load a dplyr package.
  20. Create a new data set with the average of each variable for each activity and each subject called final.
  21. Print final data set.

The finals data set are tidyData2 that contains all variables from the raw data and final that contains the average of each variable for each activity and each subject. Run run_analysis.R you get this two data load in the workspace.

  

