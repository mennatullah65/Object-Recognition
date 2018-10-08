function [ w_intput,w_hidden,eigenVictorsChoosed ] = classifyImg(methodClassify,AF,SC,bias,learnRate,numOfEpochs,numOfHiddenLayers,numOfNeurons,mse,rbf_epochs,rbf_eta,rbf_hiddenneurons,rbf_msethreshold)
%% Classes
%class:1 'cat';
%class:2 'laptop';
%class:3 'apple';
%class:4 'car';
%class:5 'helicopter';
numOfClasses=5;
%% Extract Feauture Matrices
training_dir='E:\CS\NN\project\Training';
filenames = dir(fullfile(training_dir, '*.jpg'));
[training_features,eigenVictorsChoosed]= feature_extraction( training_dir,filenames,1,0);
actualTrain=[1,5;6,10;11,15;16,20;21,25];
[~,numOfFeatures]=size(training_features);
testing_dir='E:\CS\NN\project\finalTest';
numClasses=5;
startInd=1;
testing_features=zeros(1,numOfFeatures);
actualTest=zeros(5,2);
for i=1:numClasses
    path=sprintf('%s/%d',testing_dir,i);
    filenames = dir(fullfile(path, '*.jpg'));
    [temp,~]=feature_extraction( path,filenames,2,eigenVictorsChoosed);
    testing_features=vertcat(testing_features,temp);
    [endInd,~]=size(temp);
    actualTest(i,:)=[startInd,startInd+endInd-1];
    startInd=startInd+endInd;
end
testing_features=testing_features(2:numOfFeatures+1,:);

% filename='trainfeatures.txt';
% [training_features]=getFeatures(filename);

%% Classify
%___________%
if ( methodClassify==1)
%% MLP
[w_intput,w_hidden]= MLP(numOfClasses,training_features,testing_features,numOfHiddenLayers,numOfNeurons,learnRate,numOfEpochs,AF,SC,mse,bias,actualTrain,actualTest);


elseif ( methodClassify==2)
%% RBF


end

