function [ trainingMat,classTrain ] = mknnExtractTrainingFeatures( training_dir,sizeclassTrain ,sizeFeatures,methodFeature)
startInd=1;
trainingMat=zeros(1,sizeFeatures);
classTrain=zeros(sizeclassTrain,2);
for i=1:sizeclassTrain
    path=sprintf('%s/%d',training_dir,i);
    filenames = dir(fullfile(path, '*.jpg'));
    trainingfeatures=feature_extraction( path,filenames,methodFeature,sizeFeatures);
    %To get each class first img ind and last img ind
    [endInd,~]=size(trainingfeatures);
    classTrain(i,:)=[startInd,startInd+endInd-1];
    startInd=startInd+endInd;
    trainingMat=vertcat(trainingMat,trainingfeatures);
end
end

