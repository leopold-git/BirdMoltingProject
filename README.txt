READ ME

Leopold Ringmayr


Simply run mainScript.mlx to run the project with all comparisons, training, testing, etc.



Correlation.m looks for and eliminates correlated features
Svmtraining.m is used to implement the sum algorithm via hinge loss and gradient descent, this finds the weights and bias for our model, input argument abloom includes value for lambda 

svmPredict.m is used to make a prediction given weights, bias, and test data

splitTestTraining.m splits data into test and training sets

validationSplit.m splits data into smaller partitions used for k-fold cross validation 