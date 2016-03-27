---
title: "README.md"
output: github_document
---

##### GitHub Documents
##### Coursera - JHU - Data Science Specialization - 3 Getting and Cleaning Data - Week 4 Project
##### Rajeev Rohatgi 2016-03-28  
### Where Did the Data Come From ?
Human Activity Recognition Using Smartphones Data Set
from [link](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)
data [link](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)  

##### Citation: 
Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. A Public Domain Dataset for Human Activity Recognition Using Smartphones. 21th European Symposium on Artificial Neural Networks, Computational Intelligence and Machine Learning, ESANN 2013. Bruges, Belgium 24-26 April 2013.  

### List of Files  

##### 1. run_analysis.R  
This script analyzes the above dataset and generates three output files (2,4,5 below).  

##### 2. DF1mean+std.csv  
This file contains 9.6MB output dataframe DF1 in CSV format.  DF1 contains 10300 rows x 81 columns.  The first row lists the column names, while the following 10299 rows contain observations.  Each observation is associated with "activity" in column 1=A and a "subject" in column 2=B.  The remaining 79 columns 3=C => 81=CC provide mean() and standard deviation std() feature values for that observation, labeled according to the column name, e.g. tBodyAcc-mean()-X for mean body acceleration in the X direction.  Feature values are all normalized on -1:1.  

##### 3. DF1mean+std.xlsx  
This file contains 9.3MB output dataframe DF1 in XLSX format.  Other than file format, the contents of this file are identical with the abovementioned .csv file.  Because of memory errors, this file was not created by the above .R script.

##### 4. DF2tidy_averages.csv  
This file contains 0.8MB output dataframe DF2 in CSV format.  DF2 contains 14221 rows x 4 columns.  The first row lists the column names, while the following 14220 rows contain observations.  Each observation is associated with "Activity" in column 1=A, a "Subject" in column 2=B, and a "Variable" in column 3=C.  Column 4=D contains the "Average.Value" associated with the observation Activity+Subject+Variable indicated in the first three columns.  

##### 5. DF2tidy_averages.csv  
This file contains 0.4MB output dataframe DF2 in XLSX format.  Other than file format, the contents of this file are identical with the abovementioned .csv file.  

### Installation and Directories
The .R script runs from a working directory "." and expects that this directory has been set within R as the working directory.  The input data should be located in ./Data/UCI HAR Dataset/ .  Particularly the files activity_labels.txt and features.txt should be present at this level.  The input training and test data should be one further level down.  

./Data/UCI HAR Dataset/test should contain subject_test.txt, X_test.txt, y_test.txt;  

./Data/UCI HAR Dataset/train should contain subject_train.txt, X_train.txt, y_train.txt.  

Other files from the input dataset are not used.  

#### Disclaimer  
This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.  
Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.  
Rajeev Rohatgi. March 2016.  

#### end
