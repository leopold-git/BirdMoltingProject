
% takes dataset as input and uses R value to determine association b/w
% features, returns new dataset minus the feat that is most strongly
% associated in pair 
function [trainingDayUpd] = correlation(trainingDay)  

R = corrcoef(trainingDay(:,1:end-1),'Rows','pairwise');

    temp = trainingDay;
    done = 0; % use this boolean to make sure not both corr feats get eliminated
    for i = 1 : size(R,1)
        for j = 1 : size(R,2)
          
            if R(i,j) > 0.7 && i ~= j    % feats are correlated and are not the same feature
                R(i,j)
                % update our table and our data
                % between the 2 feats in the correlated pair, throw out the
                % one that is less associated to others. 
                oneSum = 0;
                twoSum = 0;
                for k = 1:size(R,1)
                   oneSum = sum(abs(R(k, i)));
                   twoSum = sum(abs(R(k, j)));
                end
                if oneSum >= twoSum
                  % temp(:,i) = [];
                   done = 1;
                elseif oneSum < twoSum 
                    %temp(:,j) = [];
                    done = 1;
                end
            done = 0;
            end 
        end
    end
    % output new dataset without the eliminated feature(s)
    disp('Eliminated any correlated features.')
    trainingDayUpd = temp;
end