%%%MKNN%%%
function [bestk,accuracy]=MKNN(method)
training_dir='E:\CS\PR\project\Data set\Training';
testing_dir='E:\CS\PR\project\Data set\Testing\segmented';

%Extract Feauture Matrices
if method ==1 
    sizeFeatures=13;
elseif method==2
    sizeFeatures=11;
else
    sizeFeatures=24;
end
testingMat=zeros(1,sizeFeatures);
trainingMat=zeros(1,sizeFeatures);
classTest=zeros(28,3);
classTrain=zeros(5,2);
startInd=1;
ind=1;
for i=1:5   %28
    path=sprintf('%s/%d',testing_dir,i);
    filenames = dir(fullfile(path, '*.jpg'));
    testingfeatures=feature_extraction(path,filenames);
    %%%
    %To get each class first img ind and last img ind
    [endInd,~]=size(testingfeatures);
    classTest(ind,:)=[i,startInd,startInd+endInd-1];
    ind=ind+1;
    startInd=startInd+endInd;
    %%%
    new=vertcat(testingMat,testingfeatures);
    testingMat=new;
end
startInd=1;
ind=1;
for i=1:5 %28
    path=sprintf('%s/%d',training_dir,i);
    filenames = dir(fullfile(path, '*.jpg'));
    trainingfeatures=feature_extraction(path,filenames);
    %%%
    %To get each class first img ind and last img ind
    [endInd,~]=size(trainingfeatures);
    classTrain(ind,:)=[i,startInd,startInd+endInd-1];
    ind=ind+1;
    startInd=startInd+endInd;
    %%%
    new=vertcat(trainingMat,trainingfeatures);
    trainingMat=new;
end

%Get distance 
dist=calcdist(testingMat,trainingMat);%the result is a matrix 26 * 25

%relevant in Testing classes
actualClass=zeros(1);
for i=1:26
    for classInd=1:5
        %check minInd lay between the start and end Indices of each class
        if i>=classTest(classInd,2) && i<=classTest(classInd,3)
           actualClass=cat(1,actualClass,classTest(classInd,1));
           break;
        end
    end
end

%Classify
kLength=100;
K=zeros(1);
output=zeros(1);
for currentK=1:kLength
    confusionMat=MKNN_Classifier(currentK,dist,actualClass(2:27,:),classTrain);
    K=cat(1,K,currentK);
    output=cat(1,output,calcConf(confusionMat));
end
%plot(K(2:kLength+1,:),output(2:kLength+1,:));
end