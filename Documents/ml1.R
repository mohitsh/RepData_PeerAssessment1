library(caret)
library(AppliedPredictiveModeling)
set.seed(3433)
data(AlzheimerDisease)
adData = data.frame(diagnosis,predictors)
inTrain = createDataPartition(adData$diagnosis, p = 3/4)[[1]]
training = adData[ inTrain,]
testing = adData[-inTrain,] 



#plotting
library(ISLR); library(caret); library(ggplot2);
data(Wage)
summary(Wage)

inTrain <- createDataPartition(y=Wage$wage, p=0.7, list = FALSE)
training <- Wage[inTrain,]
training <- Wage[-inTrain,]
qplot(age, wage, data=training)


library(AppliedPredictiveModeling)
data(concrete)
library(caret)
set.seed(975)
inTrain = createDataPartition(mixtures$CompressiveStrength, p = 3/4)[[1]]
training = mixtures[ inTrain,]
testing = mixtures[-inTrain,]
#plot(training$CompressiveStrength, ncol(training$CompressiveStrength))
qplot(seq_along(CompressiveStrength),CompressiveStrength,color=Age,data=training)







