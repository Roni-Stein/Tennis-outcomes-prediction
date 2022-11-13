my_model = function( dataset ) {
  
  # Technical preparations for regularization
  set.seed(20220510)
  num=detectCores() 
  cl = makeCluster(num-2)
  registerDoParallel(cl)
  lambda_candidates = 10^seq(-4.5,0,.1)
  
  # Compute interactions
  f <- as.formula(Outcome ~ .*.)
  x <- model.matrix(f, dataset)[, -1]
  
  # regularization fitting
  cv0.out = cv.glmnet(x = x, y = dataset$Outcome, alpha = 1, intercept = FALSE,
                      family = "binomial", parallel = TRUE, lambda = lambda_candidates)
  
  # run the Lasso model with minimal lambda
  model_object = glmnet(x = x, y = dataset$Outcome, alpha= 1,intercept = FALSE,
                   family="binomial", lambda = cv0.out$lambda.min, parallel = TRUE)
  
  return( model_object )
}


my_prediction = function( data , model_object = NULL) {
  
  # Compute interactions
  f <- as.formula( ~ .*.)
  x <- model.matrix(f, data)
  x=x[,-1]
  
  # make predictions and transform coefficients to odds ratio
  Odds_ratio=data.frame(matrix(nrow=0, ncol=2))
  mat=as.matrix(model_object[["beta"]])
  for (i in 1:nrow(x)){
    tmp = sum(mat*x[i,])
    Odds_ratio[i,1]= 1 / (1 + exp(-tmp))
    Odds_ratio[i,2]= 1-(1 / (1 + exp(-tmp)))}
    
  # colnames arrange
  colnames(Odds_ratio) = c("player1","player2")
  return( Odds_ratio )
}
