#CodeBook 

This code book describes the  data and transformations used by run_analysis.R and the variables to produce the output of tidydata.txt

##Data Source:

Site from where the Data was fetched

    http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
    
##Data for the Project

    https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
    
        
##About the Data set :

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain
        
For each record it is provided:
======================================

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.


### Input Data Set

- X_train.txt contains variable features that are intended for training.
- y_train.txt contains the activities corresponding to X_train.txt.
- subject_train.txt contains information on the subjects from whom data is collected.
- X_test.txt contains variable features that are intended for testing.
- y_test.txt contains the activities corresponding to X_test.txt.
- subject_test.txt contains information on the subjects from whom data is collected.
- activity_labels.txt contains metadata on the different types of activities.
- features.txt contains the name of the features in the data sets

##run_analysis.R 
        
###Step 1. Merge the training and test data sets together.

The data from the train and test data sets were merged using rbind()

####Variables defined and their purpose are given below:

- X_train.txt is read into table trainData
- y_train.txt is read into table trainLabel
- subject_train.txt is read into table trainSubject
- X_test.txt is read into table testData
- y_test.txt is read into table testLabel
- subject_test.txt is read into table testSubject
- features.txt is read into table features
- activity_labels.txt is read into table activityLabels
- The Subject, Activity and Features are merged to create CompleteData
- Indices of columns that contain std or mean, activity and subject are taken into colMeanStd .
- extractedData is created with data from columns in filteredColData
- Uses descriptive activity names to name the activities in the data set
- Appropriately labels the data set with descriptive activity names
- Creates tidyData, a second, independent tidy data set with the average of each variable for each activity and each subject. 
- tidyData is written into Tidy.txt

The file tidydata.txt.txt is created.

###Output :

Files are available in the working directory - UCI-HAR-Dataset
         
        tidydata.txt