## codebook for Assignment 1 - getting and cleaning data

This codebook describes the content of the tidy data file that was created from
Samsung data files that were provided as part of the assignment. This codebook does not describe the processing steps. These steps are described in the README.md file that part of this repo.

### Data description
The data for the project is split into two groups, train and test. Each group of files are in their own folders. The script assumes this data structure  is in place when processing this data. 

The features (variables) are defined in accompnaying text files. In fact the script loads the feature file to get a list of column names for this data. It uses this data to remove unneeded columns. 

The data within test and train folders are devided into X and Y data. The Y data is the lables for the acitivity types. The script appends the Y data to the final data frame. The scripts assumes that there is one row in the Y data for every observation in the correspondind test/train data files. Lastly the subject data which identifies east subject used to produce this data is in subject file. This file is loaded and appended the final data set and script makes the assumption as the Y data.

Once the subject and activity data is appeneded to test and train data the script appends test and train to create a merged file.

The final tidy data set contains the following columns:

subject -- this is the subject that performed the activty
activitiy_type -- this the activitiy that was measured. There 6 types of activities. These are:
+ 1 WALKING
+ 2 WALKING_UPSTAIRS
+ 3 WALKING_DOWNSTAIRS
+ 4 SITTING
+ 5 STANDING
+ 6 LAYING

The remaining columns are mean to std columns that where included in the original data sets. The content of these columns where not changed.

