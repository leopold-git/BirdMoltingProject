fulltable = readtable('birds .csv');
% 2nd column (dteday) can be removed, this column gives us 
% a date that increments by one, we can use the instant column
% as an indicator of days passed. the dteday column is not needed.
% instant gives us # of days since program inception
fulltable(1, :) = [];

fulltable(:, "photo_id") = [];
fulltable(:, "location") = [];
fulltable(:, "species") = [];

newSet = table2array(fulltable);


% feats used: season, species  number, location number, and wing linearity.




trainingBird1Upd = correlation(newSet) % look for correlation -> finding: no correlation

% look for irrelevant feats
 [B2,FitInfo2] = lasso(newSet(:,1:end-1), newSet(:,end));
