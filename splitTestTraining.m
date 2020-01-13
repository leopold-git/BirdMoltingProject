function [testDay, trainingDay] = TestProportion(input, X)
%trainingDay = readtable(fileName,'HeaderLines', 1);
trainingDay = input;
elements = size(trainingDay,1);
testTotal = round(elements*X);

testRows = randperm(elements,testTotal);

testDay = trainingDay(testRows,:);
trainingDay(testRows,:)=[];
end

