
% returns split datasets for 10-fold crossVal--- returns a struct holding
% the 10% validation set and another struct holding the respective training
% set (the other 90%) for that fold 
function [validationTrainSets, validationTestSets] = validationSplit(currencyTrainSet)
    foldSize = round(size(currencyTrainSet, 1)/10);    
    sets= struct();
    for i = 1: size(currencyTrainSet,1)
       sets.v1 = currencyTrainSet(1:foldSize,:);
       sets.v2 = currencyTrainSet(foldSize+1:round(2*(foldSize)),:);
       sets.v3 = currencyTrainSet(round(2*(foldSize)+1:round(3*(foldSize))),:);
       sets.v4 = currencyTrainSet(round(3*(foldSize)+1:round(4*(foldSize))),:);
       sets.v5 = currencyTrainSet(round(4*(foldSize)+1:round(5*(foldSize))),:);
       sets.v6 = currencyTrainSet(round(5*(foldSize)+1:round(6*(foldSize))),:);
       sets.v7 = currencyTrainSet(round(6*(foldSize)+1:round(7*(foldSize))),:);
       sets.v8 = currencyTrainSet(round(7*(foldSize)+1:round(8*(foldSize))),:);
       sets.v9 = currencyTrainSet(round(8*(foldSize)+1:round(9*(foldSize))),:);
       sets.v10 = currencyTrainSet(round(9*(foldSize)+1: size(currencyTrainSet,1)),:);
    end
     validationTestSets = sets;
     sets2 = [];
    
    for  i =1: size(currencyTrainSet,1)
       sets2.t1 = [sets.v2; sets.v3; sets.v4; sets.v5; sets.v6; sets.v7; sets.v8; sets.v9; sets.v10];
       sets2.t2 = [sets.v1; sets.v3; sets.v4; sets.v5; sets.v6; sets.v7; sets.v8; sets.v9; sets.v10];
       sets2.t3 = [sets.v1; sets.v2; sets.v4; sets.v5; sets.v6; sets.v7; sets.v8; sets.v9; sets.v10];
       sets2.t4 = [sets.v1; sets.v2; sets.v3; sets.v5; sets.v6; sets.v7; sets.v8; sets.v9; sets.v10];
       sets2.t5 = [sets.v1; sets.v2; sets.v3; sets.v4; sets.v6; sets.v7; sets.v8; sets.v9; sets.v10];
       sets2.t6 = [sets.v1; sets.v2; sets.v3; sets.v4; sets.v5; sets.v7; sets.v8; sets.v9; sets.v10];
       sets2.t7 = [sets.v1; sets.v2; sets.v3; sets.v4; sets.v5; sets.v6; sets.v8; sets.v9; sets.v10];
       sets2.t8 = [sets.v1; sets.v2; sets.v3; sets.v4; sets.v5; sets.v6; sets.v7; sets.v9; sets.v10];
       sets2.t9 = [sets.v1; sets.v2; sets.v3; sets.v4; sets.v5; sets.v6; sets.v7; sets.v8 ; sets.v10];
       sets2.t10 = [sets.v1; sets.v2; sets.v3; sets.v4; sets.v5; sets.v6; sets.v7; sets.v8 ; sets.v9];
    end
   validationTrainSets = sets2;
    
end