### Getting and Cleaning Data Course Project

setwd("C:/documents/s626191/Documents/Bibliothèque/Formation Coursera/Getting and Cleaning Data/Week 4/Course Project/UCI HAR Dataset")
#setwd("F:/Documents/Actuariat/Formation Big Data Coursera/Getting and Cleaning Data/Week 4/Course Project/UCI HAR Dataset")
#setwd("E:/Documents/Actuariat/Formation Big Data Coursera/Getting and Cleaning Data/Week 4/Course Project/UCI HAR Dataset")

data_test <- read.table("./test/X_test.txt")
data_train <- read.table("./train/X_train.txt")
label_test <- read.table("./test/y_test.txt")
label_train <- read.table("./train/y_train.txt")
subject_test <- read.table("./test/subject_test.txt")
subject_train <- read.table("./train/subject_train.txt")

# 1.Merges the training and the test sets to create one data set.

data_test <- cbind(label_test,data_test)
data_test <- cbind(subject_test,data_test)
data_train <- cbind(label_train,data_train)
data_train <- cbind(subject_train,data_train)
data <- rbind(data_test,data_train)

names(data)

features <- read.table("features.txt")
features[,2] <- as.character(features[,2])


nbvar=563
for(i in 3:nbvar){
  names(data)[i]<-features[i-2,2]
}

names(data)

# 2.Extracts only the measurements on the mean and standard deviation for each measurement.

moyenne <- grepl("mean",names(data))
moyenne <- as.numeric(moyenne)
et <- grepl("std",names(data))
et <- as.numeric(et)
moyennefreq <- grepl("meanFreq",names(data))
moyennefreq <- as.numeric(moyennefreq)
keep <- moyenne+et-moyennefreq
keep <- as.logical(keep)
keep[1]<-TRUE
keep[2]<-TRUE

data2 <- data[,keep]
head(data2,1)

# 3.Uses descriptive activity names to name the activities in the data set.

activity <- read.table("activity_labels.txt")

data2$V1.1 <- factor(data2$V1.1,levels=c("1","2","3","4","5","6"),labels=c("LAYING","SITTING","STANDING","WALKING","WALKING_DOWNSTAIRS","WALKING_UPSTAIRS"))
head(data2)

# 4.Appropriately labels the data set with descriptive variable names. 

data3 <- data2
names(data3)<-sub("\\()","",names(data3))
names(data3)<-sub("-","",names(data3))
names(data3)<-sub("mean","Mean",names(data3))
names(data3)<-sub("std","Std",names(data3))
names(data3)<-sub("^t","time",names(data3))
names(data3)<-sub("^f","frequency",names(data3))
names(data3)<-sub("Acc","Accelerometer",names(data3))
names(data3)<-sub("Gyro","Gyroscope",names(data3))
names(data3)<-sub("Mag","Magnitude",names(data3))
names(data3)<-sub("BodyBody","Body",names(data3))
names(data3)[1]<-"Subject"
names(data3)[2]<-"Activity"

names(data3)

# 5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

data4 <- aggregate(x=data3[,3:68],by=list(data3$Subject,data3$Activity),FUN=mean)
summary(aggregate( data = data3,Subject~timeBodyAccelerometerMagnitudeMean,FUN=mean))
names(data4)[1] <- "Subject"
names(data4)[2] <- "Activity"

write.table(x=data4,"./tidy_data.txt",row.name=FALSE)
