function [predAccuracy, prederror] = svmPredict(testSet, finalWeights, finalBias) 


signArray = [];
                for l=1:size(testSet, 1)
                    
                    
                    xrow = testSet(l, 1:end-1);  
                    labels = testSet(l, end);
                    labels;
                 
                  activation = sum(times(finalWeights,xrow)) + finalBias;
                    % compare sign of predicttion to actual label
                    if labels*activation >= 1
                        slack = 0;
                    else 
                        slack = 1 - activation;
                    end
                    result = activation  + slack;
                    signArray = [signArray, sign(result)];
                    
                end
                    numerator = 0;
                    wrong = 0;
                   signArray;
                    % compare signarray to the actual labels 
                     for i=1:size(signArray,1)
                        labels2 = testSet(i, end);
                        % both cases below show correct prediction
                        if signArray(i) == labels2
                            numerator = numerator + 1;
                        elseif  signArray(i) ~= labels2
                            wrong = wrong +1;
                        end
            
                   accuracy = numerator/size(signArray,1);
                   prederror = wrong/size(signArray,1);
                   predAccuracy = accuracy;
end