function [finalWeights, finalBias] = svmtraining(feats, labels, lambda)
    
    % loop thru folds in cross val    
    % this is data for validation (1/10 folds)
      
    
            % initialize weights and bias to 0 
            w0 = 0;  % intercept
            w1 = 0;  % feat 1 : season
            w2 = 0;  % feat 2 : species
            w3 = 0;  % feat 3 : location
            w4 = 0;  % feat 4 : wing
            weights = [w1,w2,w3, w4];
            bias  = 0;
            
            % learning rate
            L = 0.01;
            
            
                
                   % loop thru iterations
                   for i = 1:10000
                     
                        % initialize gradient of weights and gradient of bias
                     gradbias = 0;
                     gradw1 = 0;
                     gradw2 = 0;
                     gradw3 = 0;
                     gradw4 = 0;
                     derivativeWeights = [gradw1, gradw2, gradw3, gradw4];
                     derivativeBias = 0;
            
                        % inner loop (loop thru data)
                        for j=1:size(feats,1)
                            act = sum(times(weights,feats(j,:)), 2) +bias;
                            if labels(j)*act < 1
                                 derivativeWeights = derivativeWeights + (feats(j,:).*labels(j)); % update weight gradient
                                  derivativeBias = derivativeBias + labels(j);  % update bias derivative
                            end
                        end
         
                        derivativeWeights = derivativeWeights - (lambda)*2*sum(weights); % add regularizer
                        weights = weights + L*derivativeWeights;
                        bias = bias + L*derivativeBias;
                   end
                 
             finalWeights = weights;
             finalBias = bias;

end
