This script compiles data from the UCI HAR Dataset, which can be downloaded from the following link: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip.

The script starts by reading the list of dataset measures in the “features.txt” file. It then delves into the “test” folder to capture the “test” subjects and activities (from “subject_test.txt” and “Y_test.txt” respectively). It labels each of these values as “Type” = “Test”. It then tacks on the measure values found in “X_test.txt”, which have their column headers defined by “features.txt”.

An additional dataset is then created in the same way using the “train” folder with the equivalent files (“subject_train.txt”, “Y_train.txt”, “X_train.txt”). The “Type” column is marked “Train”. The two datasets are then combined into a single dataset, called “full_set”.

The previously created dataset components (all by “full_set”) are dropped to clear unused memory.

The “full_set” dataset is then trimmed horizontally, removing all columns, excepted for the row-identifying first three (“Type”, “Subject”, “Activity”) and the means and standard deviations for each measure.

To make the data a little more readable, the “Activity” column’s numeric values (1-6) are switched out for named values, which are defined in the “activity_labels.txt” file.

Then a separate dataset - “full_means” - is created. The mean function is applied across each measure column in “full_set” for each activity and then each subject. The output is then saved to “full_means” before clearing out everything but the final datasets (“full_set” and “full_means”).