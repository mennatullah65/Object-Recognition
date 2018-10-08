function [ class ] = classifyImg( img,methodFeature,methodClassify )
%%Extract Feauture Matrices
if methodFeature ==1 
    %GLCM
    sizeFeatures=4;
    testingMat=glcm(img);
elseif methodFeature==2
    %RunLength
    sizeFeatures=11;
    testingMat=runlength(img);
else
    %Both
    sizeFeatures=15;
    featureMat1=glcm(img);
    featureMat2=runlength(img);
    testingMat=horzcat(featureMat1,featureMat2);
end
%row=zeros(1,sizeFeatures);
%testingMat=vertcat(row,testingMat);

%% Get TrainFeatures
training_dir='E:\CS\PR\project\finalTrain';
sizeclassTrain=5;
[ trainingMat,classTrain ] = mknnExtractTrainingFeatures( training_dir,sizeclassTrain ,sizeFeatures,methodFeature);

%% Get distance : the result is a matrix 26 img test * 25 img train

testingOut=testingMat;
[R2,C2]=size(trainingMat);
trainingMat=trainingMat(2:R2,:);
[R2,C2]=size(trainingMat);

trainingOut=trainingMat;

% trainingOut=zeros(R2-1,C2);
% for j=1:C2
%     meanval=mean(trainingMat(2:R2,j));
%     trainingOut(1:R2-1,j)=trainingOut(1:R2-1,j)/meanval;
% end

% trainingOut=zeros(R2,C2);
% for j=1:C2
%     minv=min(trainingMat(1:R2,j));
%     maxv=max(trainingMat(1:R2,j));
%     subval= maxv-minv;
%     trainingOut(1:R2,j)=(trainingMat(1:R2,j)-minv)/subval;
% end

dist=mknnCalcdist(testingOut,trainingOut,sizeFeatures);
[~,trainNum]=size(dist);
%actual class of Train images
[ actualTrainClass ] = mknnExtractactualTrainClass( trainNum,sizeclassTrain ,classTrain);

%% Classify
%___________%

%% MKNN
if methodClassify==1
    if methodFeature==1
        class=mknnImgClassifier(6,dist,actualTrainClass,sizeclassTrain);
    elseif methodFeature==2
        class=mknnImgClassifier(6,dist,actualTrainClass,sizeclassTrain);
    else
        class=mknnImgClassifier(3,dist,actualTrainClass,sizeclassTrain);
    end

%% RKN
elseif methodClassify==2
    dist=mknnCalcdist(testingMat,trainingMat,sizeFeatures);
    if methodFeature==1
        class=rnnImgClassifier(4,dist,actualTrainClass,sizeclassTrain);
    elseif methodFeature==2
        class=rnnImgClassifier(27,dist,actualTrainClass,sizeclassTrain);
    else
        class=rnnImgClassifier(4,dist,actualTrainClass,sizeclassTrain);
    end
%% SVM
elseif methodClassify==3

[ class] = svmClassification( trainingOut,actualTrainClass, testingMat);

end

end

