# README

### gettingandcleaningdata repository

## list of files contained in this repository
<b>README.md</b>          This file. Contains the list of files that are part of this project. Describes each step of the process of getting and cleaning the data.

<b>CodeBook.md</b>        It describes the variables, the data, and the transformations that were performed to clean up the data.

<b>run_analysis.R</b>     This is the R script that reads the data and generates the tidy data. Comments are provided within the script. 
Explanation of the steps in run_analysis.R

###Assumptions
It is assumed that the original data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip is uncompressed and available on the local machine from where the script is run.
The uncompressed data contains two folders /test and /train from which data is extracted.
Set the working directory to the parent of /test and /train

###Step 1
The first main step is to read the data.
X_test data is read into a dataframe "dfXtest".
Similarly, y_test.txt and subject data is ready into their own dataframes "dfytest" and "dfsubject_test" respectively.
One dataframe called <b>dftest</b> is created that combined by columns dfXtest, dfytest and dfsubject_test. 

Similar steps are performed on the training data.
The data is read from the respective X_train.txt, y_train.txt and subject_train.txt files and stored into individual dataframes.
These are then combined by columns to form one dataframe called <b>dftrain</b>.

### Step 2
Eventually, both dftest and dftrain are concatanated by rows to form dfall dataframe.

### Step 3
Next, read the features, which form the column names of dfall.
Read in the featues from "features.txt" with stringsAsFactors=FALSE (this is important).

The feature names are in the second column and store them in the variable df_feature_names.
Then create a vector that combines the first two column names (subject and activity) and the df_feature_names. 

### Step 4
Assign the column names to the dfall dataframe
Create a brand new dataframe dfstdmean that is a subset of dfall and only contains the subject, activity and all columns that contain "mean" and "std" in their names.

### Step 5
Now replace the numeric value of the activity with a descriptive text.

### Step 6
Use the group_by function to group by subject and activity and call this dataframe dfstdmeangroup.

### Step 7
Then use the summarise_each function on the dfstdmeangroup and summarise using function mean and call this dataframe <b>dfstdmeangroupsm</b>.

### Step 8
Finally, write this dataframe into the file tidydatastdmean.txt.

In order to verify the data is written correctly, read the file back into R Studio and display the contents with View(df).
