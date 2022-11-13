# Tennis-scores-prediction
R project of logistic regression with regularization model that predicts winning or losing in tennis matches using raw ATP data.

Given a dataset where each row is a tennis match, containing data of the ranking of each player, points gained so far this season and gambling ratios, the model written in the project predicts which player is most likely to win each match.
The project has training_data to train on and test_data to test the model performance on new data.

wrapping_script - has all the setup necessery for the model to run. the wrapping_script run the functions of the model and evaluate the model performance by using success percentage and loglikelihood.

my_functions - contains the my_model function which trains the model on the training_data. The model is a logistic regression with lasso regularization.
the my_prediction function generate prediction of the winning odds of the players.
