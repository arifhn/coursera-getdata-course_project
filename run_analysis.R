tmp_wd = getwd() # save current working dir
# set working directory to dataset (uncomment and change working dir to datasets dir, if needed)
# setwd("~/bigdata/coursera-getdata-course_project/dataset")

# read column names
titles <- read.csv("features.txt", sep=" ", col.names=c("id","name"), stringsAsFactors=FALSE, header=FALSE)
# clean the feature names (strip all non alphabet character to '.')
titles$name <- lapply(titles$name, FUN=function(x) {t = gsub("[^a-zA-Z0-9]{1,}", ".", x);gsub("^\\.|\\.$","",t)})

# read activity labels
activities <- read.csv("activity_labels.txt", sep=" ", col.names=c("id","label"), stringsAsFactors=FALSE, header=FALSE)

# -------------------------------------
# test set (merge + clean test set data)
# -------------------------------------
# read test set
test <- read.fwf("test/X_test.txt", widths=rep(16,561), header=FALSE, col.names=titles$name, buffersize=1)

# clean features (extract only feature that contains 'mean' or 'std')
test <- test[,grep(".*mean.*|.*std.*", colnames(test))]

# read subject
test_subject <- read.fwf("test/subject_test.txt", widths=c(2), header=FALSE, col.names=c("subject"))
# add subject to test data
test$subject <- test_subject$subject

# read test label assign it to test_actnum
test_actnum <- read.fwf("test/y_test.txt", widths=c(1), header=FALSE, col.names=c("actnum"))
# add test$activity from test_actnum but replace the value with its label (activities$label)
test$activity <- sapply(test_actnum$actnum, FUN=function(x) activities$label[x[1]])


# -------------------------------------
# train set (merge + clean train set data)
# -------------------------------------
# read train set
train <- read.fwf("train/X_train.txt", widths=rep(16,561), header=FALSE, col.names=titles$name, buffersize=1)

# clean features (extract only feature that contains 'mean' or 'std')
train <- train[,grep(".*mean.*|.*std.*", colnames(train))]

# read subject
train_subject <- read.fwf("train/subject_train.txt", widths=c(2), header=FALSE, col.names=c("subject"))
# add subject to train data
train$subject <- train_subject$subject

# read train label assign it to train_actnum
train_actnum <- read.fwf("train/y_train.txt", widths=c(1), header=FALSE, col.names=c("actnum"))
# add train$activity from train_actnum but replace the value with its label (activities$label)
train$activity <- sapply(train_actnum$actnum, FUN=function(x) activities$label[x[1]])

# merge test and training dataset
merged <- rbind(test,train)
# calculate average of each variable for each (activity + subject) 
result <- aggregate(. ~ activity + subject, data=merged, mean)
# order result by activity + subject
result <- result[order(result[,1],result[,2]),]

# write the result to file 'result.txt'
write.table(result, file="result.txt", row.names=FALSE)

setwd(tmp_wd) # restore last working dir