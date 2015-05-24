## To be run within the UCI HAR Dataset folder
## Data download: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
## Documentation:http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

## Generate "features" list, which will provide labels to our measures
file<-"./features.txt"
features<-read.table(file)

## Take in "test" subjects set
file<-"./test/subject_test.txt"
test_subjects<-read.table(file,col.names="Subject")

## Take in "test" activities set
file<-"./test/Y_test.txt"
test_activities<-read.table(file,col.names="Activity")

## Take in "test" measure values and assign "features" list to column names
file<-"./test/X_test.txt"
test_set<-read.table(file)
colnames(test_set)<-features[,2]

## Create "Test" label for data imported from "test" folder
test_labels<-as.data.frame(rep("Test",nrow(test_set)))
colnames(test_labels)<-"Type"

## Combine "test" data above into a dataset called "test_full"
test_full<-cbind(test_labels,test_subjects,test_activities,test_set)


## Take in "train" subjects set
file<-"./train/subject_train.txt"
train_subjects<-read.table(file,col.names="Subject")

## Take in "train" activities set
file<-"./train/Y_train.txt"
train_activities<-read.table(file,col.names="Activity")

## Take in "train" measure values and assign "features" list to column names
file<-"./train/X_train.txt"
train_set<-read.table(file)
colnames(train_set)<-features[,2]

## Create "Train" label for data imported from "train" folder
train_labels<-as.data.frame(rep("Train",nrow(train_set)))
colnames(train_labels)<-"Type"

## Combine "train" data above into a dataset called "train_full"
train_full<-cbind(train_labels,train_subjects,train_activities,train_set)

## Combine "test_full" and "train_full" datasets
full_set<-rbind(test_full,train_full)

## Remove previously created dataset components
rm(list=c("features","file","test_activities","test_full","test_labels","test_set","test_subjects","train_activities","train_full","train_labels","train_set","train_subjects"))


## Identify columns that identify the data, plus means and standard deviations for the measures
new_cols<-c(1:9,44:49,84:89,124:129,164:169,204:205,217:218,230:231,243:244,256:257,269:274,348:353,427:432,506:507,519:520,532:533,545:546)

## Gather column names from above columns
new_col_names<-colnames(full_set)[new_cols]

## Truncate "full_set" to only include the above columns
full_set<-full_set[new_cols]

## Assign the associated column names
colnames(full_set)<-new_col_names

## Take in activity labels to assign to "Activity" column
file<-"activity_labels.txt"
activity_labels<-read.table(file)[2]

## Convert Activity column to character so that it can take in the new labels
full_set$Activity<-as.character(full_set$Activity)

## For each activity type found in "full_set", replace the numeric value with its associated label
for (x in 1:nrow(activity_labels)) {
  label<-as.character(activity_labels[x,1])
  full_set[full_set$Activity==x,]$Activity<-label
}


## Create a new "full_means" dataset 
full_means<-data.frame(Type="")
full_means<-full_means[-1,]

## Apply mean function across each measure in “full_set” for each activity and then each subject
## Save to "full_means" and apply associated column name
for (x in 4:ncol(full_set)) {
  full_means<-cbind(full_means,c(sapply(split(full_set[,x],full_set$Activity),mean),
                                 sapply(split(full_set[,x],full_set$Subject),mean)))
  colnames(full_means)[x-3]<-colnames(full_set)[x]
}

## Capture row names and assign to first column
Type<-rownames(full_means)
full_means<-cbind(Type,full_means)

## Remove everything but the "full_set" and "full_means" datasets
rm(list=c("activity_labels","file","label","new_col_names","new_cols","x","Type"))