#Setup required libraries
require(tidyr)
require(dplyr)
require(reshape2)
require(Hmisc)

# Automatically download and uncompress data.
destFile <- "./har_Dataset.zip"
harZipUrl <- "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(harZipUrl, destFile, mode = "wb")
unzip(destFile, overwrite = T)
baseDir <- "./UCI HAR Dataset"

# Setup file locations & make sure they're there. Stop with an error otherwise.
activityLabelsFile <- paste(baseDir, "/activity_labels.txt", sep = "")
featuresFile <- paste(baseDir, "/features.txt", sep = "")
subjectTestFile <- paste(baseDir, "/test/subject_test.txt", sep = "")
subjectTrainFile <- paste(baseDir, "/train/subject_train.txt", sep = "")
xTestFile <- paste(baseDir, "/test/X_test.txt", sep = "")
xTrainFile <- paste(baseDir, "/train/X_train.txt", sep = "")
yTestFile <- paste(baseDir, "/test/y_test.txt", sep = "")
yTrainFile <- paste(baseDir, "/train/y_train.txt", sep = "")
if (!file.exists(activityLabelsFile) |
            !file.exists(featuresFile) |
            !file.exists(subjectTestFile) |
            !file.exists(subjectTrainFile) |
            !file.exists(xTestFile) |
            !file.exists(xTrainFile) |
            !file.exists(yTestFile) |
            !file.exists(yTrainFile)) {
        stop("Dataset not completely downloaded. Re-run script from the beginning")
}

# Read-in data using filenames assembled below
activityLabels <- read.csv(activityLabelsFile, header = F, stringsAsFactors = F)
features <- read.csv(featuresFile, header = F, stringsAsFactors = F, sep="")
subjectTest <- read.csv(subjectTestFile, header = F, stringsAsFactors = F)
subjectTrain <- read.csv(subjectTrainFile, header = F, stringsAsFactors = F)
xTest <- read.csv(xTestFile, header = F, stringsAsFactors = F, sep = "") # specify separator as "" in order take ANY WHITE space as separator
xTrain <- read.csv(xTrainFile, header = F, stringsAsFactors = F, sep = "") # see previous comment
yTest <- read.csv(yTestFile, header = F, stringsAsFactors = F)
yTrain <- read.csv(yTrainFile, header = F, stringsAsFactors = F)

# Clean activity labels by separating IDs from activity labels and creating column headers accordingly
activityLabels <- separate(activityLabels, V1, c("id", "activity"), sep = " ")

# Ensure there are no intersections between subjectTest & subjectTrain data.
if (!length(intersect(subjectTest$V1, subjectTrain$V1)) == 0) {stop("Check your input files. I've found intersections between subject test & train files")}

# Bind subjectTrain & subjectTest datasets by row. Order is important!!! First go with TEST data, then go with TRAIN data. Otherwise data may be inconsistent when binding
subjects <- rbind(subjectTest, subjectTrain)

# Bind X datasets by row, TEST data first, TRAIN data next. This is the core of the measurements from the dataset.
# We find that together they form a 10299 x 561 dataset, hence the subject and the y datasets must contain
# the same number of rows
x <- rbind(xTest, xTrain)

# Bind y datasets by row, TEST data first, TRAIN data next.
y <- rbind(yTest, yTrain)

# Verify that these 3 datasets (x, y and subjects) contain the same number of rows
if (nrow(x) != nrow(y) & nrow(y) != nrow(subjects)) {stop("Datasets are of different lengths. The 3 must be of the same length.")}

# Append y and subjects dataframes to x to form an 'almost tidy' dataset. At this point only column names for
# the 561 measurements and human-readable columns and activity labels.
almostTidy <- mutate(x, activityDuringMeasurement = as.integer(y$V1), experimentSubject = as.integer(subjects$V1))

# Join activity labels with almostTidy dataframe to have both activity id and label
# First, convert id in activityLabels to integer
activityLabels$id <- as.integer(activityLabels$id)
# Then join with almostTidy
almostTidyWithActivity <- inner_join(x=almostTidy, y=activityLabels, by = c("activityDuringMeasurement"="id"))

# Add columns from file features.txt. This completes item 1 in the list of tidying objectives.
names(almostTidyWithActivity) <- c(features$V2, "activityId", "experimentSubject", "activityType")

# Create a tidy dataset with subjects, human-readable activity labels, and means and stdevs measurements
# First get subject and activity labels first into new dataframe
tidy <- almostTidyWithActivity[,grep("experimentSubject|activityType", names(almostTidyWithActivity))]
# Next get all mean() and std() columns
tidy <- cbind(tidy, almostTidyWithActivity[,grep("mean\\(\\)|std\\(\\)", names(almostTidyWithActivity))])
# Next, create human-readable variable names
names(tidy) <- gsub("tBody","time_Body",names(tidy))
names(tidy) <- gsub("tGravity","time_Gravity",names(tidy))
names(tidy) <- gsub("fBody","freq_Body",names(tidy))
names(tidy) <- gsub("tGravity","time_Gravity",names(tidy))
names(tidy) <- gsub("Acc","Accelerometer",names(tidy))
names(tidy) <- gsub("Gyro","Gyroscope",names(tidy))
names(tidy) <- gsub("Mag","Magnitude",names(tidy))
names(tidy) <- gsub("\\(\\)","",names(tidy))

# Creates a second, independent tidy data set with the average of each variable for each activity and each subject
tidyFinal <- tidy %>% group_by(experimentSubject, activityType) %>% summarise_each(funs(mean))

# Verification
if (!mean(tidy[tidy$activityType == 'LAYING' & tidy$experimentSubject == 1,3]) == 
            tidyFinal[tidyFinal$activityType == 'LAYING' & tidyFinal$experimentSubject == 1, 3]) {
     stop("Your contingency table is not correct. Mean time_BodyAccelerometer-mean-X for subject 1 while LAYING should be 0.2215982")   
}

# Write final tidy dataset. This concludes the project.
write.table(tidyFinal, file="./tidyFinal.txt")