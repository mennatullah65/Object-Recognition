function [ classifiedTo] = SVMClassification( featuresMat,groupMat, testImage)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

% divide features matrix to compare between each class ( MULTICLASS SVM) (pair wise method)
%between class 1 and class 2
[cs1_2,gr1_2]=getFeatureMatrix(featuresMat(1:5,:),featuresMat(6:10,:),groupMat(1:5,:),groupMat(6:10,:));
svmStruct1 = svmtrain(cs1_2,gr1_2,'kernel_function', 'rbf', 'showplot', true);

%between class 1 and class 3
[cs1_3,gr1_3]=getFeatureMatrix(featuresMat(1:5,:),featuresMat(11:15,:),groupMat(1:5,:),groupMat(11:15,:));
svmStruct2 = svmtrain(cs1_3,gr1_3,'kernel_function', 'rbf', 'ShowPlot',true);

%between class 1 and class 4
[cs1_4,gr1_4]=getFeatureMatrix(featuresMat(1:5,:),featuresMat(16:20,:),groupMat(1:5,:),groupMat(16:20,:));
svmStruct3 = svmtrain(cs1_4,gr1_4,'kernel_function', 'rbf', 'ShowPlot',true);

%between class 1 and class 5
[cs1_5,gr1_5]=getFeatureMatrix(featuresMat(1:5,:),featuresMat(21:25,:),groupMat(1:5,:),groupMat(21:25,:));
svmStruct4 = svmtrain(cs1_5,gr1_5,'kernel_function', 'rbf', 'ShowPlot',true);

%between class 2 and class 3
[cs2_3,gr2_3]=getFeatureMatrix(featuresMat(6:10,:),featuresMat(11:15,:),groupMat(6:10,:),groupMat(11:15,:));
svmStruct5 = svmtrain(cs2_3,gr2_3,'kernel_function', 'rbf', 'ShowPlot',true);

%between class 2 and class 4
[cs2_4,gr2_4]=getFeatureMatrix(featuresMat(6:10,:),featuresMat(16:20,:),groupMat(6:10,:),groupMat(16:20,:));
svmStruct6 = svmtrain(cs2_4,gr2_4,'kernel_function', 'rbf', 'ShowPlot',true);

%between class 2 and class 5
[cs2_5,gr2_5]=getFeatureMatrix(featuresMat(6:10,:),featuresMat(21:25,:),groupMat(6:10,:),groupMat(21:25,:));
svmStruct7 = svmtrain(cs2_5,gr2_5,'kernel_function', 'rbf', 'ShowPlot',true);

%between class 3 and class 4
[cs3_4,gr3_4]=getFeatureMatrix(featuresMat(11:15,:),featuresMat(16:20,:),groupMat(11:15,:),groupMat(16:20,:));
svmStruct8 = svmtrain(cs3_4,gr3_4,'kernel_function', 'rbf', 'ShowPlot',true);

%between class 3 and class 5
[cs3_5,gr3_5]=getFeatureMatrix(featuresMat(11:15,:),featuresMat(21:25,:),groupMat(11:15,:),groupMat(21:25,:));
svmStruct9 = svmtrain(cs3_5,gr3_5,'kernel_function', 'rbf', 'ShowPlot',true);

%between class 4 and class 5
[cs4_5,gr4_5]=getFeatureMatrix(featuresMat(16:20,:),featuresMat(21:25,:),groupMat(16:20,:),groupMat(21:25,:));
svmStruct10 = svmtrain(cs4_5,gr4_5,'kernel_function', 'rbf', 'ShowPlot',true);

outClassify1= svmclassify(svmStruct1,testImage,'ShowPlot',true);
outClassify2= svmclassify(svmStruct2,testImage,'ShowPlot',true);
outClassify3= svmclassify(svmStruct3,testImage,'ShowPlot',true);
outClassify4= svmclassify(svmStruct4,testImage,'ShowPlot',true);
outClassify5= svmclassify(svmStruct5,testImage,'ShowPlot',true);
outClassify6= svmclassify(svmStruct6,testImage,'ShowPlot',true);
outClassify7= svmclassify(svmStruct7,testImage,'ShowPlot',true);
outClassify8= svmclassify(svmStruct8,testImage,'ShowPlot',true);
outClassify9= svmclassify(svmStruct9,testImage,'ShowPlot',true);
outClassify10= svmclassify(svmStruct10,testImage,'ShowPlot',true);
tempVec=[outClassify1,outClassify2,outClassify3,outClassify4,outClassify5,outClassify6,outClassify7,outClassify8,outClassify9,outClassify10];
y = accumarray(tempVec(:),1);
[~,classifiedTo]=max(y);


end

