
#Test set
test= read.table ("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset//test//X_test.txt")

# subject_test.txt : Each row identifies the subject 
#who performed the activity for each window sample. Its range is from 1 to 30. 
test_subject =read.table ("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset//test//subject_test.txt")


#Joins the test_subject data to the data frame 
#providing identity ID

test_w_subject = cbind (test_subject, test)

#activity_of_test
#'test/y_test.txt': Test labels.
activity_test = read.table ("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset//test//y_test.txt")

test_full= cbind (activity_test, test_w_subject)

#Training set
train= read.table ("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset//train//X_train.txt")

# subject_train.txt : Each row identifies the subject
train_subject =read.table ("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset//train//subject_train.txt")

train_w_subject = cbind (train_subject, train)

#activity train
#'train/y_train.txt': train labels.
activity_train = read.table ("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset//train//y_train.txt")

train_full = cbind (activity_train, train_w_subject)


#read the data with the original 561 names of the variables (feature vector)
variables_561= read.table ("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset//features.txt")


#Merges the training and the test sets to create one data set.
full_set= rbind (test_full, train_full)

#descriptive activity names
full_set$V1 = factor(full_set$V1, 
                      labels=c("WALKING", "WALKING_upstairs", "WALKING_downstairs", 
                                "SITTING", "STANDING", "LAYING"))


#To name the first two variables of the full set of data (activity and participant number)
names(full_set)[1]<-"Activity"
names(full_set)[2]<-"Participant_ID"


#Appropriately labels the data set with descriptive variable names.
columns_names=as.character(variables_561$V2)


names(full_set) <- c(names(full_set)[1:2],columns_names)



#picking out the mean and standard deviation columns and subsetting to those ones.

job <- names(full_set)

variables_mean_std <- job[grepl('(mean\\(\\))|(std\\(\\))', job)]

tidy_data1<- subset(full_set,select=c(names(full_set)[1:2],variables_mean_std))


#Creates a second, independent tidy data set with the average of each variable for each activity and
#each subject.

tidy_data5  = aggregate(tidy_data1[,-c(1:2)], by = tidy_data1[,1:2], FUN=mean  ) 
?write.table

write.table (tidy_data5, file ="tidy_data.txt", row.name=FALSE   )




