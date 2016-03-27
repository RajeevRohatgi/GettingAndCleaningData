---
title: "CodeBook.md"
output: github_document
---

##### GitHub Documents
##### Coursera - JHU - Data Science Specialization - 3 Getting and Cleaning Data - Week 4 Project
##### Rajeev Rohatgi 2016-03-28  

This file describes operation of run_analysis.R .  

### Where Did the Data Come From ?
Human Activity Recognition Using Smartphones Data Set
from [link](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)
data [link](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)  

##### Citation: 
Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. A Public Domain Dataset for Human Activity Recognition Using Smartphones. 21th European Symposium on Artificial Neural Networks, Computational Intelligence and Machine Learning, ESANN 2013. Bruges, Belgium 24-26 April 2013.  

### Installation and Directories
The .R script runs from a working directory "." and expects that this directory has been set within R as the working directory.  The input data should be located in ./Data/UCI HAR Dataset/ .  Particularly the files activity_labels.txt and features.txt should be present at this level.  The input training and test data should be one further level down.  

./Data/UCI HAR Dataset/test should contain subject_test.txt, X_test.txt, y_test.txt;  

./Data/UCI HAR Dataset/train should contain subject_train.txt, X_train.txt, y_train.txt.  

Other files from the input dataset are not used.  

### Step-by-Step
##### 1. Setup paths for input & output directories
txDirMain points to the main input folder at ./Data/UCI HAR Dataset/
txDirTest points to the test data at ./Data/UCI HAR Dataset/test/
txDirTrain points to the training data at ./Data/UCI HAR Dataset/train/
txDirMerge points to the output data at ./Data/UCI HAR Merge/ . This folder is created if it does not exist.  

##### 2. Read input data
Training data is read from txDirTrain and Test data is read from txDirTest using read.table() on all .txt files in the respective folders.  

##### 3. Build master dataframe dfAll
Training and Test data from tbl_train and tbl_test are combined using dplyr::rbind().  The column names of the 79 features are read from features.txt into vNames and applied to dfAll.  

##### 4. Extract desired columns into dfX
The columns corresponding to mean() and std() features are identified by doing a grep() on vNames, yielding vector keep.columns. A reduced dataframe dfX is obtained by extracting all 10229 rows x 79 keep.columns columns.  

##### 5. Replace integer activity codes with descriptive names
This dataframe has integer activity codes 1:6, which are desired to be replaced by WALKING, SITTING, etc descriptive factor names. The activity names are extracted from activity_labels.txt.  A single column dataframe vActivity, with name activity, is formed from numeric column 1 of dfX by indexing into the column of activity names.  The vActivity column is bound to columns 2:end of dfX using dplyr::cbind(), thereby replacing numeric activity codes with descriptive factors.  
The numeric subject codes 1:30 are retained.  

##### 6. Form the means of each Variable for each Activity+Subject combination
reshape2::melt(dfX) is used to form a molten dataframe dfM, with ID columns activity and subject, and 10299x79 rows.  tapply(dfM) is used to collect mean for each of 180x79 Activity+Subject+Variable combinations.  The 6x30x79 output array is melted back into a dataframe DF2 having three ID columns (Activity, Subject, Variable) and an Average.Value column containing the corresponding mean calculated by tapply().

##### 7. Output CSV XLSX files
Finally, DF1 and DF2 are both output as CSV files.  DF2 is also output as XLSX file using xlsx::write.xlsx2.  DF1 was not able to be outputted by the .R script as an out-of-memory error was generated.  DF1...xlsx was created using Excel(TM).

##### 8. Misc
Periodically through the script, unnecessary variables and dataframes are purges using rm().

#### Disclaimer  
This script is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.  
Rajeev Rohatgi. March 2016.  

#### end
