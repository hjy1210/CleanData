##rm(list=ls())
########## need set Samsung data directory as working directory
##workingdir<-"f:/documents/CleanData/UCI HAR Dataset"
##setwd(workingdir)

# Use read.table to read data in "train/subject_train.txt" and "test/subject_test.txt", combine as an object subject.
# the object subject represent subjects who perform activities.
subject_train<-read.table(file="train/subject_train.txt")
subject_train<-subject_train$V1
subject_test<-read.table(file="test/subject_test.txt")
subject_test<-subject_test$V1
subject<-c(subject_train,subject_test)

activity<-read.table(file="activity_labels.txt")
names(activity)<-c("Code","Activity")
# Use read.table to read data in "train/y_train.txt" and "test/y_test.txt", combine as an object y. 
# the object y represent activities which are performed by subjects.
y_train<-read.table(file="train/y_train.txt")
y_train<-y_train$V1
y_test<-read.table(file="test/y_test.txt")
y_test<-y_test$V1
y<-c(y_train,y_test)

# Use readLines, strsplit to construct object feactures, whcih has feature names as its second element.
features<-readLines("features.txt")
tokens<-strsplit(features," ")
features<-data.frame(Code=sapply(tokens,function(x){as.numeric(x[1])}),
                     Feature=sapply(tokens,function(x){x[2]}))
# Use read.table to read data in "train/X_train.txt" and "test/X_test.txt", combine as an object X. 
# the object X represent features which are extracted from raw measurements measured when subjects perofrm activities.
X_train<-read.table(file="train/X_train.txt")
names(X_train)<-features$Feature
X_test<-read.table(file="test/X_test.txt")
names(X_test)<-features$Feature
X<-rbind(X_train,X_test)

# Use grep to produce object featuremeanstd, which is used to extract only features conserned mean or std as required by the assignment.
featuremeanstd<-features[c(grep("mean",features$Feature), grep("std",features$Feature)),]
Xsub<-X[,featuremeanstd$Code]

# Use gsub to produce more readable name for remaining features.
names(Xsub)<-gsub("[()]","",names(Xsub))
# Use cbind to produced MergedDataSet, which is a data.frame object with 81 elements. 
# The first two are subject and activity, others are wanted features.
MergedDataSet<-cbind(data.frame(subject=factor(subject)),data.frame(activity=activity$Activity[y]),Xsub)

# Use tapply with MergedDataSet to produce the required tidy data set tidyDataSet.
tidyDataSet<-data.frame(subject=rep(as.character(1:30),each=6),activity=rep(activity$Activity,30))
for ( i in 3:length(MergedDataSet)){
  tidyDataSet<-cbind(tidyDataSet,numeric(180))
  a<-tapply(MergedDataSet[[i]],INDEX=list(MergedDataSet[[1]],MergedDataSet[[2]]),mean)
  for (r in rownames(a)) {
    for (c in colnames(a)){
      tidyDataSet[[i]][tidyDataSet[[1]]==r & tidyDataSet[[2]]==c]<-a[r,c]
    }
  }
}
names(tidyDataSet)<-names(MergedDataSet)
# Use write.table with row.name=FALSE to produced the wanted text file tidyDataSet.txt for submitting.
write.table(tidyDataSet,file="tidyDataSet.txt",row.name=FALSE)
