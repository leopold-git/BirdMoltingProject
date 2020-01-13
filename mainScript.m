% load data and feature selection

fulltable = readtable('birds .csv');
% 2nd column (dteday) can be removed, this column gives us 
% a date that increments by one, we can use the instant column
% as an indicator of days passed. the dteday column is not needed.
% instant gives us # of days since program inception
fulltable(1, :) = [];

fulltable(:, "photo_id") = [];
fulltable(:, "location") = [];
fulltable(:, "species") = [];

trainingBird1 = table2array(fulltable);
for int=1:size(trainingBird1,1)
    if trainingBird1(int, end) == 0
        trainingBird1(int, end) = -1;
    end
end

randomized = trainingBird1(randperm(size(trainingBird1, 1)), :);
disp("look for correlation between feature: ");

trainingBird1 = correlation(trainingBird1); % look for correlation -> finding: no correlation
disp("Use lasso reg to find irrelevant features: ")
% look for irrelevant feats
 [B2,FitInfo2] = lasso(trainingBird1(:,1:end-1), trainingBird1(:,end));
B2

% split into test/training sets
[testBirds, trainingBirds] = splitTestTraining(trainingBird1,0.2); 

% split the 80% training set for 10-fold crossval
[validationTrainSets, validationTestSets] = validationSplit(trainingBirds); 

% feats used: season, species  number, location number, and wing linearity.

fields = fieldnames(validationTestSets);
fields2 = fieldnames(validationTrainSets);

% This array hold our findings best parameters
% for each of the 10 folds
arrayofBestCs = [];
bestC = 0;
BestCAccuracy = 0;
AccuracyForCurrentC = 0;
bestCAcc = 0;
bestWeights = [];
bestBias = 0;

for K=1:5
    % try out a new C and use cross val folds to get avg accuracy for that
    % C (lambda = 1/C)
    C =[0.01, 0.002, 1.7, 0.2, 0.5, 1000];
    foldAccuracies = [];
    for i = 1:numel(fields)
       % within one fold: find irrelevant feats by training with/out certain
       % features and seeign accuracy, record the accuracy. 
      currentVal = validationTestSets.(fields{i});
      currentTrain = validationTrainSets.(fields2{i}); 
    
      % train model using current C on currentTrain se
       [finalWeights, finalBias] = svmtraining(currentTrain(:,1:end-1), currentTrain(:,1:end) , K );

      
      % predict model just trained on currentVal set, record accuracy in
      % array for all 10 folds
       sizeVal = size(currentVal, 1);
       accuracy = svmPredict(currentVal, finalWeights, finalBias); 

       foldAccuracies  = [foldAccuracies, accuracy];
       
    end
    % find avg accuracy for the 10 folds in given C, was it higher than for
    % previous C? if so, update our best C
    C;
    avgCAccuracy = sum(foldAccuracies) / numel(fields);
    if avgCAccuracy > BestCAccuracy
        BestCAccuracy = avgCAccuracy;
        bestC = C;
        bestWeights = [bestWeights, finalWeights];
        bestBias = finalBias;
    end
end
arrayofBestCs;




%%% TRAIN BEST SVM MODEL using best C (lambda), AND PREDICT
% best lambda was 1.7
disp("Training best SVM model, best lambda was 1.7 ");
[bestFinalWeights, bestFinalBias] = svmtraining(trainingBirds(:,1:end-1), trainingBirds(:,end), 1.7);
[testAcc,testError] = svmPredict(testBirds, bestFinalWeights, bestFinalBias)


% record error (= wrong predictions/totalpredictions) and plot against
% iterations -- show convergence 





%%% BUILD AND TRAIN NAIVE BAYES
disp("Training Naive Bayes model");

Mdl = fitcnb(trainingBirds(:,1:end-1), trainingBirds(:,end));


Predictions = predict(Mdl, testBirds(:, 1:end-1))

correctlyLabeled = 0;

for i=1:size(testBirds, 1)
    if Predictions(i) == testBirds(i)
        correctlyLabeled = correctlyLabeled +1;
    end
end

BayesAccuracy = correctlyLabeled / size(testBirds, 1);


%%% BOOTSTRAP TESTSET, EVALUATE 2 MODELS
% FOR NAIVE BAYES
bootResultsNB =[];

for m = 1:10
    bootSampleNB = [];
    for n=1:10
       
         % build the bootstrap sample
         row =testBirds(randi(size(testBirds,1)),:);
         bootSampleNB = [bootSampleNB; row];
       
    end
    
        testLabelsNB = bootSampleNB(:, end);
         TestSetNB = bootSampleNB(:, :);
   
         positive = 0;
         TestSetNB;
         for k = 1: size(TestSetNB,1)
                  label = predict(Mdl, bootSampleNB(k, 1:end-1));


               if label == testLabelsNB(k)
                  positive = positive +1;
                end
             
         end
         bootAccuracyNB = positive/size(TestSetNB,1);
         bootResultsNB =[bootResultsNB, bootAccuracyNB]
       
end


%   BOOTSTRAP FOR SVM

bootResultsSVM =[];

for m = 1:10
    bootSampleSVM = [];
    for n=1:10
       
         % build the bootstrap sample
         row =testBirds(randi(size(testBirds,1)),:);
         bootSampleSVM = [bootSampleSVM; row];
       
    end
    
        testLabelsSVM = bootSampleSVM(:, end);
         TestSetSVM = bootSampleSVM(:, :);
   
         positive = 0;
         TestSetSVM;
         for k = 1: size(TestSetSVM,1)
                  label = svmPredict(TestSetSVM, bestFinalWeights, bestFinalBias);

               if label == 1
                  positive = positive +1;
                end
             
         end
         bootAccuracySVM = positive/size(TestSetSVM,1);
         bootResultsSVM =[bootResultsSVM, bootAccuracySVM];
       
end


% COMPARE MODELS 
disp("bootstrap results: ");
[h,p] = ttest(bootResultsNB, bootResultsSVM)