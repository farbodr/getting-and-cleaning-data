## Project 1 - Getting and Cleaning data

The script used to create the output for this project is in one file called
run_analysis.R

You will find this script in this repo.

This script make an assumption about the location of the data files it needs. To run this script place in the root dir where the (Samsung) data for this project resides. The script assumes the test and train data are in their own folders.

IF YOU CHOSE TO RUN THIS SCRIPT PLEASE ENSURE THAT THE SCRIPT IS IN THE SAMSUNG DATA ROOT FOLDER (UCI HAR Dataset)

To run this script use the source method as shown below:

```r
source('run_analysis.R')
```

The script itself should be fairly easy to follow. There are three functions that transform the data. These functions
are then followed by code that produces the tidy data file required for this assignment.

The first method loads the data and merged the data files. This function also adds columns for subject and activity labels. The second function removes any column without 'mean', 'std', 'activity_type' or 'subject' in its name. Lastly, the last function replace activity types with meaningful names. 

```r
merged.df <- load_merge_files()
mean.std.df <- extract_mean_std(merged.df)
mean.std.df <- set_activity_labels(mean.std.df)
```

After cleaning and transforming the training and test data the script reshapes the data to create the tidy data file. The last step writes the data out into a CSV file.

```r
#use melt/cast combination to create a tidy data set
#there will be one row for each combination of Subject/activity and 
#the rest of columns will contain the mean of each features in mean.std.df data
#frame
library(reshape)
mean.per.subject.activity.df <- melt(mean.std.df, id.vars = c("subject", "activity_type"))
final.df <- cast(subject+activity_type~variable, data=mean.per.subject.activity.df, fun=mean)
write.csv(final.df, file="final_tidy_ds.txt", row.names=F)
```
