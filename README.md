CleanData
=========

This ia a project assignment of CourseRA course "Getting and Cleaning Data".

The R script file run_analysis.R can be used to produce output file tidyDataSet.txt which is required for assignment.

In run_analysis.R, we proceed as:

Step 1, 
  (a) Use read.table to read data in "train/subject_train.txt" and "test/subject_test.txt", combine as an object subject.
      the object subject represent subjects who perform activities.
  (b) Use read.table to read data in "train/y_train.txt" and "test/y_test.txt", combine as an object y.
      the object y represent activities which are performed by subjects.
  (c) Use readLines, strsplit to construct object feactures, whcih has feature names as its second element.
  (e) Use read.table to read data in "train/X_train.txt" and "test/X_test.txt", combine as an object X.
      the object X represent features which are extracted from raw measurements measured when subjects perofrm activities.

Step 2,
  (a) Use grep to produce object featuremeanstd, which is used to extract only features conserned mean or std as required        by the assignment. 
  (b) Use gsub to produce more readable name for remaining features.
  (c) Use cbind to produced MergedDataSet, which is a data.frame object with 81 elements. The first two are subject and          activity, others are wanted features.
  
Step 3,
  (a) Use tapply with MergedDataSet to produce the required tidy data set tidyDataSet.
  (b) Use write.table with row.name=FALSE to produced the wanted text file tidyDataSet.txt for submitting.
  
  
 NOTE: Before execute run_analysis.R, we should set Samsung data directory as working directory.


