run_analysis <- function(){
  
  #load features, transpose and remove first line
  features<-read.table("features.txt")
  column.headers <- rbind(data.frame(V1 = 0,V2 = "Activity"), features)
  column.headers <- rbind(data.frame(V1 = 0,V2 = "Subject"), column.headers)
  
  #load test data
  test.x <- read.table("test/X_test.txt")
  test.activity <- read.table("test/y_test.txt")
  test.subject <- read.table("test/subject_test.txt")
  test.x<-cbind(Activity = test.activity$V1, test.x)
  test.x<-cbind(Subject = test.subject$V1, test.x)
  test.x <- setNames(test.x, column.headers$V2)




  
  #load train data
  train.x <- read.table("train/X_train.txt")
  train.activity <- read.table("train/y_train.txt")
  train.subject <- read.table("train/subject_train.txt")
  train.x<-cbind(Activity = train.activity$V1, train.x)
  train.x<-cbind(Subject = train.subject$V1, train.x)
  train.x <- setNames(train.x, column.headers$V2)
  
  merged.data <- rbind(train.x, test.x)
  
  merged.data$Activity<-gsub("1", "Walking", merged.data$Activity)
  merged.data$Activity<-gsub("2", "Walking Upstairs", merged.data$Activity)
  merged.data$Activity<-gsub("3", "Walking Downstairs", merged.data$Activity)
  merged.data$Activity<-gsub("4", "Sitting", merged.data$Activity)
  merged.data$Activity<-gsub("5", "Standing", merged.data$Activity)
  merged.data$Activity<-gsub("6", "Laying", merged.data$Activity)

  tidy<-merged.data[, grep("Activity|Subject|mean\\(\\)|std\\(\\)", names(merged.data))]
  
  write.table(tidy, "tidy.txt")

}