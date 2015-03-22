# Repo for the 'Getting & Cleaning Data' MOOC Project
This repo contains the necessary files to reproduce the conversion of the 'Human Activity Recognition using Smartphones' (referred to as HAR from this point onwards) into a tidy dataset.

## Contents of this repo
1. **README.md** - This file.
2. **CodeBook.md** - Data dictionary that describes variables, their units, factor levels and a small summary of what it records.
3. **run_analysis.R** - R script that converts the messy HAR data into a tidy data set.
4. **tidy.txt** - The tidy dataset

There may be some other files inside the repo, which the evaluator is kindly recommended to ignore, since they may pertain to exercises done during lecture videos.

## Objective of the tidying process
As stated by the project description:

> You should create one R script called run_analysis.R that does the following.

> 1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## The messy data
It contains 2 sets of data: training and test. Each set comprises 561 observations. The tidying up of the columns (variables) will be central to this project. Here's an overview of the raw data:

1. 2 separated sets: 1 train set in `./UCI HAR Dataset/train` with 7352 observations and 1 in `./UCI HAR Dataset/test` with 2947 observations
2. Each directory has 3 files and 1 directory. The directory will not be included in the processing of this dataset. The relevant files are the following, where XXX is the suffix that refers to either the *test* or the *train* sets:
  1. `features.txt` - The 561 variable names for this dataset
  2. `features_info.txt` - A rough codebook describing these 561 measurements
  3. `activity_labels.txt` - Catalog with the activity type the subject was performing while gathering data points
  4. `subject_XXX.txt` - The individual for which the data points are being gathered
  5. `X_XXX.txt` - Measurements of the 561 variables described in file `features.txt` (see CodeBook.md for further details)
  6. `y_XXX,txt` - Data points of the ID indicating the activity the subject was performing while gathering data points. Should be related to `activity_labels.txt`