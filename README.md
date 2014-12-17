#README
##Course Project of Getting and Cleaning Data

This repository contains all the files for completing project assignment in Coursera
Please read the following description for each file in the repository

###+ CodeBook.md
this file contanis the code book of the resulting data from run_analysis.R script

###+ dataset
contains raw data, provided here to ease the reviewer (don't need to download again)
there is also output file 'result.txt' contains the tidy data

###+ README.md
this file

###+ run_analysis.R
the main script that do anything (read, clean, and write the output 'result.txt')
the script will read raw data from working directory
you need to un-comment the 3rd line to set directory that contains raw data

general flow of this script:

1. read 'features.txt' file that contains column names for the raw data
2. read activity labels from 'activity_labels.txt'
3. read 'test/X_test.txt' and assign the column names with titles read from 'features.txt'
4. read 'test/subject_test.txt' and assign to subject columns
5. read 'test/y_test.txt' as activity, but replace the id with labels read from 'activity_labels.txt'
6. repeat step 3 to 5 with 'train' data
7. merge test and train data
8. using aggregate function to create result data frame
9. write the result to output file
