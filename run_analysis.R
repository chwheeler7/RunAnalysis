## To be run within the UCI HAR Dataset folder
## Data download: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
## Documentation:http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

file<-"./features.txt"
features<-read.table(file)

file<-"./test/subject_test.txt"
test_subjects<-read.table(file,col.names="Subject")

file<-"./test/Y_test.txt"
test_activities<-read.table(file,col.names="Activity")

file<-"./test/X_test.txt"
test_set<-read.table(file)
colnames(test_set)<-features[,2]

test_labels<-as.data.frame(rep("Test",nrow(test_set)))
colnames(test_labels)<-"Type"

test_full<-cbind(test_labels,test_subjects,test_activities,test_set)


file<-"./train/subject_train.txt"
train_subjects<-read.table(file,col.names="Subject")

file<-"./train/Y_train.txt"
train_activities<-read.table(file,col.names="Activity")

file<-"./train/X_train.txt"
train_set<-read.table(file)
colnames(train_set)<-features[,2]

train_labels<-as.data.frame(rep("Train",nrow(train_set)))
colnames(train_labels)<-"Type"

train_full<-cbind(train_labels,train_subjects,train_activities,train_set)

full_set<-rbind(test_full,train_full)

new_cols<-c(1:9,44:49,84:89,124:129,164:169,204:205,217:218,230:231,243:244,256:257,269:274,348:353,427:432,506:507,519:520,532:533,545:546)

new_col_names<-colnames(full_set)[new_cols]

full_set<-full_set[new_cols]

colnames(full_set)<-new_col_names

full_set$Activity<-as.character(full_set$Activity)

file<-"activity_labels.txt"
activity_labels<-read.table(file)[2]

for (x in 1:nrow(activity_labels)) {
  label<-as.character(activity_labels[x,1])
  full_set[full_set$Activity==x,]$Activity<-label
}

full_means<-data.frame(Type="")
full_means<-full_means[-1,]

for (x in 4:ncol(full_set)) {
  full_means<-cbind(full_means,c(sapply(split(full_set[,x],full_set$Activity),mean),
                                 sapply(split(full_set[,x],full_set$Subject),mean)))
  colnames(full_means)[x-3]<-colnames(full_set)[x]
}