# function to load and merge files
#
# it assumes the file location 
# 
# returns a DF of the merged files
# this function completes step 1 and 4 of the assignment
load_merge_files <- function()
{  
  x_test='test/X_test.txt'
  y_test='test/y_test.txt' 
  x_train='train/X_train.txt' 
  y_train='train/y_train.txt'
  subject_test='test/subject_test.txt'
  subject_train='train/subject_train.txt'
  features='features.txt'
  
  
  # get feature names from features.txt
  feature_list = read.csv(file=features, sep="", col.names=c('id', 'feature_name'), header=F) 
  
  #load the file. Use feature name in feature_list df for column names
  x.test.df <- read.csv(file=x_test, col.names=feature_list$feature_name, 
                        sep="", header=F)
  #add y_test as a new column we loaded in x.test.df
  x.test.df <- cbind(x.test.df,read.csv(file=y_test, col.names=c("activity_type"),
                                        sep="", header=F))
  
  #add subject as a new column we loaded in x.test.df
  x.test.df <- cbind(x.test.df,read.csv(file=subject_test, col.names=c("subject"),
                                        sep="", header=F))
  
  x.train.df <- read.csv(file=x_train, col.names=feature_list$feature_name, 
                         sep="", header=F)
  #add y_test as a new column we loaded in x.test.df
  x.train.df <- cbind(x.train.df,read.csv(file=y_train, col.names=c("activity_type"),
                                          sep="", header=F))
  
  #add subject as a new column we loaded in x.test.df
  x.train.df <- cbind(x.train.df,read.csv(file=subject_train, col.names=c("subject"),
                                          sep="", header=F))
  
  #combine x.train.df and x.test.df
  merged.df <- rbind(x.train.df, x.test.df)
}

#this function removes all fields that are not mean or std or activity lables from
# the data frame passed to it.
#It essentially removes all fields that don't have 'mean' or 'std' in their name 
#The activity label and subject fields are NOT removed.
# this function completes step 2 of the assignment
extract_mean_std <- function(df)
{
  #list of columns with mean or freq in their name
  df <- df[,c(grep("mean|std|activity_type|subject", names(merged.df)))]
  df
}

#this function sets the activity labels in the
#activity label column. It uses the labels
#defined in activity_label.txt file shown below
#1 WALKING
#2 WALKING_UPSTAIRS
#3 WALKING_DOWNSTAIRS
#4 SITTING
#5 STANDING
#6 LAYING
#return the updated df
# this function completes step 2 of the assignment
set_activity_labels <- function(df)
{
  df$activity_type <- ifelse(df$activity_type==1, 'WALKING', df$activity_type)
  df$activity_type <- ifelse(df$activity_type==2, 'WALKING_UPSTAIRS', df$activity_type)
  df$activity_type <- ifelse(df$activity_type==3, 'WALKING_DOWNSTAIRS', df$activity_type)
  df$activity_type <- ifelse(df$activity_type==4, 'SITTING', df$activity_type)
  df$activity_type <- ifelse(df$activity_type==5, 'STANDING', df$activity_type)
  df$activity_type <- ifelse(df$activity_type==6, 'LAYING', df$activity_type)
  df
}

merged.df <- load_merge_files()
mean.std.df <- extract_mean_std(merged.df)
mean.std.df <- set_activity_labels(mean.std.df)
#use melt/cast combination to create a tidy data set
#there will be one row for each combination of Subject/activity and 
#the rest of columns will contain the mean of each features in mean.std.df data
#frame
library(reshape)
mean.per.subject.activity.df <- melt(mean.std.df, id.vars = c("subject", "activity_type"))
final.df <- cast(subject+activity_type~variable, data=mean.per.subject.activity.df, fun=mean)
write.csv(final.df, file="final_tidy_ds.txt", row.names=F)