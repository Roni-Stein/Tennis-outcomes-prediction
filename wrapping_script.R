## require the packages needed for the function
if (!require(dplyr)) {install.packages("dplyr")}; require(dplyr)
if (!require(glmnet)) { install.packages("glmnet") }; library(glmnet) 
if (!require(doParallel)) {install.packages("doParallel")}; library(doParallel)

####### fill the path of the folder #######
setwd("*******")

# source your functions
source("my_functions.R")

# load the full ATP dataset
training_data = read.csv("training_data.csv")

# load the left-out ATP dataset
test_data = read.csv("test_data.csv")


################################################################################
# fit model
model_output = my_model(training_data)

# use model to predict outcomes of training data
training_predictions = my_prediction(training_data[,-1],model_output)

# compare predictions to actual outcomes
mean((training_predictions[,1]>0.5)==training_data$Outcome)
# My model predicted the actual outcome in 69.88% of the cases

# use model to predict outcomes of test data
test_predictions = my_prediction(test_data[,-1],model_output)

# compare predictions to actual outcomes
mean((test_predictions[,1]>0.5)==test_data$Outcome)

# My model predicted the actual outcome in 75.6% of the cases

# calculate the loglikelihood (the probability of the data given the model)
fulfilled_predictions = cbind(test_predictions[,1]*test_data$Outcome,
                              test_predictions[,2]*abs(test_data$Outcome-1))
logliklihood = log(prod(apply(fulfilled_predictions,1,sum)))
# -62.3
################################################################################

