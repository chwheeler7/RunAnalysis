Data Definitions
================

This script generates two datasets - "full_set" and "full_means".

The "full_set" dataset contains identifying columns "Type", "Subject" and "Activity", followed by means and standard deviations for each of the measures in the UCI HAR dataset.
    "Type" defines the data source - whether the associated rows were imported from the "test" or "train" folder.
    "Subject" identifies the subject involved in the subject (numbers 1-30). This data comes from the "subject_test.txt" file for "test" and "subject_train.txt" file for "train"."
    "Activity" identifies the activity taking place at the time that each measure was captured. This data comes in numeric form from the "Y_test.txt" and "Y_train.txt" files, before being labeled with the appropriate activity names found in the "activity_labels.txt" file.
    The remaining columns contain mean and standard deviation data for each of the measures captured in the "X_test.txt" and "X_train.txt" files. Other calculations in those files (eg. max, min, correlation) have been dropped. For more information on the measures, see details in "Feature Selection" below.

The "full_means" dataset contains a row for each of the six activities and thirty subjects. Each column then captures the mean for each measure in "full_set" split by activity and subject (using sapply). For more information on the measures, see details in "Feature Selection" below.

For more detailed information on the components that go into each of these datasets, see the comments in the run_analysis.R script.


Feature Selection 
=================

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 

mean(): Mean value
std(): Standard deviation

The complete list of variables of each feature vector is available in 'features.txt'
