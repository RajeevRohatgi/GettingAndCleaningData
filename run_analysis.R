# -----------------------------------------------------------------------------
# run_analysis.R
#
# Coursera - JHU - Data Science Specialization - 3 Getting and Cleaning Data - Week 4 Project
#
# 2016-03-28 Rajeev Rohatgi
#
# Set up directories ----------------------------------------------------------
# Starting directory should be where this source file is located, just above /data/UCI HAR Dataset/
# setwd ("<..>/3 Get+Clean Data/Week 4")
txDirMain <-"./data/UCI HAR Dataset"
txDirTrain<-"./data/UCI HAR Dataset/train"
txDirTest <-"./data/UCI HAR Dataset/test"
txDirMerge<-"./data/UCI HAR Merge"
if(!file.exists(txDirMerge)) {
    dir.create(txDirMerge)
}
# setwd(txDirMerge) -- keep working directory at home level

# Read TRAIN data files and bind columns --------------------------------------
vFiles<-list.files(path=txDirTrain,"*\\.txt$")
for (iFile in vFiles){
 assign(paste("tbl_",sub("\\.txt","",iFile),sep=""),read.table(file.path(txDirTrain,iFile)))
}
tbl_train<-cbind(tbl_y_train,tbl_subject_train,tbl_X_train)

# Read TEST data files and bind columns ---------------------------------------
vFiles<-list.files(path=txDirTest,"*\\.txt$")
for (iFile in vFiles){
    assign(paste("tbl_",sub("\\.txt","",iFile),sep=""),read.table(file.path(txDirTest,iFile)))
}
tbl_test<-cbind(tbl_y_test,tbl_subject_test,tbl_X_test)


# Create combined DF ----------------------------------------------------------
library(dplyr)
dfAll<-rbind(tbl_train,tbl_test)

# Remove unneeded
rm(list=ls(pattern="^tbl"))          # Remove unneeded tables
rm(list=ls(pattern=".File*."))       # Remove unneeded filenames

# Create labeled DF -----------------------------------------------------------
tbl_features<-read.table(file.path(txDirMain,"features.txt"))
vNames<-c("y","subject",as.character(tbl_features[,2]))
names(dfAll)<-vNames

# Extract mean, std dev fields only -------------------------------------------
keep.columns=c(1:2,grep("\\-mean|std",vNames))
dfX<-dfAll[,keep.columns]

# Meaningful Activity code ----------------------------------------------------
tbl_activity<-read.table(file.path(txDirMain,"activity_labels.txt"))
vActivity<-data.frame(tbl_activity[dfX$y,2])
names(vActivity)<-"activity"
DF1<-cbind(vActivity,dfX[,2:dim(dfX)[2]])   # First required output

# Remove unneeded
rm(list=ls(pattern="^tbl"))              # Remove unneeded tables
rm(list=c("vActivity","dfAll","dfX"))    # Remove unneeded DF and names
rm(list=c("keep.columns","vNames"))

# Form means by <activity subject variable> ...
library(reshape2)
dfM<-melt(DF1,id.vars=1:2)              # melt all 79 variables together
dfM.means<-with(dfM,tapply(value,list(Activity=activity,Subject=subject,Variable=variable),mean))
# ... And reshape into tidy DF
DF2<-melt(dfM.means,varnames=names(dimnames(dfM.means)))    # 2nd output
names(DF2)[4]<-"Average.Value"

# Remove unneeded
rm(list=ls(pattern="^df"))              # remove molten DF

# Write outputs as CSV
write.csv(DF2,file=file.path(txDirMerge,"DF2tidy_averages.csv"),row.names=FALSE)
write.csv(DF1,file=file.path(txDirMerge,"DF1mean+std.csv"),row.names=FALSE)
library(xlsx)
write.xlsx2(x=DF2,file=file.path(txDirMerge,"DF2tidy_averages.xlsx"),sheetName="DF2tidy_averages",row.names=FALSE)
# next line generates memory error :-(
# write.xlsx2(x=DF1,file=file.path(txDirMerge,"DF1mean+std.xlsx"),sheetName="DF1mean+std",row.names=FALSE)
