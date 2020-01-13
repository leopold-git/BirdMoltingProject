function [result] = bootstrapTestSet(currencyTestSet, trainedModel)




% take n samples from TestSet (repeat entire process m times) with n = 10,
% and m= 10

% test model

% calculate/collect the statistics needed 

% once statistics from all samples collected, find mean of statistics and
% return this mean


bootResults =[];

for m = 1:10
    bootSample= [];
    for n=1:10
       
         % build the bootstrap sample
         row = currencyTestSet(randi(size(currencyTestSet,1)),:);
         bootSample = [bootSampleKNN; row];
       
    end
         
         testLabels = bootSample(:, end);
         currencyTestSet1 = bootSample(:, 6); % isolate the important feat for DT
         currencyTestSet1 = [currencyTestSet1, testLabels];
         positive = 0;
         currencyTestSet1
         for k = 1: size(currencyTestSet1,1)
              label = predict(mdl, currencyTestSet1(k , 1:end-1));
              if label == currencyTestSet1(k, end)
                  positive = positive +1;
              end
         end
         bootAccuracy = positive/size(currencyTestSet1,1);
         bootResults =[bootResults, bootAccuracy];
       
end



end