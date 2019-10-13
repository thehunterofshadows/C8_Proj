#Clean enviroment
remove(list = ls())
trainDL<-read.csv("https://d396qusza40orc.cloudfront.net/predmachlearn/pml-training.csv")
testDL<-read.csv("https://d396qusza40orc.cloudfront.net/predmachlearn/pml-testing.csv")


library(data.table)
library(caret)
library(rpart)
library(rattle)

set.seed(12345)

#Remove near zero values
# if (length(nearZeroVar(trainDL)) > 0) {
#   trainDL <- trainDL[, -nearZeroVar(trainDL)]
# }
# removeNA<-sapply(trainDL, function(x) mean(is.na(x))) > 0.95
# 
# trainDL<-trainDL[, removeNA==FALSE]


keep <- names(trainDL[,colSums(is.na(trainDL)) == 0])[8:59]

# Only use features used in testing cases.
trainDL <- trainDL[,c(keep,"classe")]
testDL <- testDL[,c(keep,"problem_id")]


training<-createDataPartition(trainDL$classe, p=0.7, list=FALSE)
myTrain<-trainDL[training, ]
myTest<-trainDL[-training, ]



#Decision trees
modDT<-rpart(classe ~ ., data = myTrain, method = "class")
fancyRpartPlot(modDT)