%%%MKNN%%%
function [best,accuracyVal,confusinMatOfbest,dist]=TestClassifier(methodFeature,methodClassify)
%%
best=0;accuracyVal=0;confusinMatOfbest=0;
%%system inputs
training_dir='E:\CS\PR\project\finalTrain';
testing_dir='E:\CS\PR\project\finalTest';
sizeclassTest=5;
sizeclassTrain=5;
%%Extract Feauture Matrices
if methodFeature ==1 
    %GLCM
    sizeFeatures=4;
elseif methodFeature==2
    %RunLength
    sizeFeatures=11;
else
    %Both
    sizeFeatures=15;
end

%% Get TestFeatures
testingMat=zeros(1,sizeFeatures);
classTest=zeros(sizeclassTest,2);
startInd=1;
for i=1:sizeclassTest
    path=sprintf('%s/%d',testing_dir,i);
    filenames = dir(fullfile(path, '*.jpg'));
    testingfeatures=feature_extraction( path,filenames,methodFeature,sizeFeatures);
    %To get each class first img ind and last img ind
    [endInd,~]=size(testingfeatures);
    classTest(i,:)=[startInd,startInd+endInd-1];
    startInd=startInd+endInd;
    testingMat=vertcat(testingMat,testingfeatures);
end

%% Get TrainFeatures
[ trainingMat,classTrain ] = mknnExtractTrainingFeatures( training_dir,sizeclassTrain ,sizeFeatures,methodFeature);

%% Get distance : the result is a matrix 26 img test * 25 img train
[R1,~]=size(testingMat);
[R2,~]=size(trainingMat);
testingMat=testingMat(2:R1,:);
trainingMat=trainingMat(2:R2,:);
testingOut=testingMat;
trainingOut=trainingMat;
% [testingOut,trainingOut]=normalization(testingMat,trainingMat);
dist=mknnCalcdist(testingOut,trainingOut,sizeFeatures);
[testNum,trainNum]=size(dist);

%% actual class of Test images
actualTestClass=zeros(1);
for i=1:testNum
    for classInd=1:sizeclassTest
        %check minInd lay between the start and end Indices of each class
        if i>=classTest(classInd,1) && i<=classTest(classInd,2)
           actualTestClass=vertcat(actualTestClass,classInd);
           break;
        end
    end
end
actualTestClass=actualTestClass(2:testNum+1,:);
%% actual class of Train images
[ actualTrainClass ] = mknnExtractactualTrainClass( trainNum,sizeclassTrain ,classTrain);

%% Classify
%% MKNN
if methodClassify==1
kLength=25;
accuracy=zeros(1);
K=zeros(1);
for currentK=1:kLength
    confusionMat=mknnClassifier(currentK,dist,actualTestClass,actualTrainClass,sizeclassTest,sizeclassTrain);
    accuracy=vertcat(accuracy,mknnCalcAccuracy(confusionMat,testNum));
    K=vertcat(K,currentK);
end
%plot K and accuracy
[accuracyVal,best]=max(accuracy);
confusinMatOfbest=mknnClassifier(best,dist,actualTestClass,actualTrainClass,sizeclassTest,sizeclassTrain);
plot(K,accuracy);

%% RKN
elseif methodClassify==2
accuracy=zeros(1);
R=zeros(1);
dist=mknnCalcdist(testingMat,trainingMat,sizeFeatures);

endR=max(max(dist));
startR=min(min(dist));
for currentR=startR:0.5:endR
    confusionMat=rnnClassifier(currentR,dist,actualTestClass,actualTrainClass,sizeclassTest,sizeclassTrain);
    accuracy=vertcat(accuracy,mknnCalcAccuracy(confusionMat,testNum));
    R=vertcat(R,currentR);
end
%plot K and accuracy
[accuracyVal,best]=max(accuracy);
confusinMatOfbest=rnnClassifier(best,dist,actualTestClass,actualTrainClass,sizeclassTest,sizeclassTrain);
plot(R,accuracy);
%% SVM
elseif methodClassify==3
confusinMatVar=zeros(sizeclassTest,sizeclassTrain);
for i = 1:testNum
[ classifiedTo] = svmClassification( trainingOut,actualTrainClass, testingOut(i,:));
if(classifiedTo==actualTestClass(i,:))
    confusinMatVar(classifiedTo,classifiedTo)=confusinMatVar(classifiedTo,classifiedTo)+1;
end
end
accuracyVal=mknnCalcAccuracy(confusinMatVar,testNum);
confusinMatOfbest=confusinMatVar;

end

end