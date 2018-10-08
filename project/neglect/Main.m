training_dir='F:\FCIS\Year 4\Second term\Neural Networks\Project\Training';
filenames = dir(fullfile(training_dir, '*.jpg'));
imagesMat1=extract_images(training_dir,filenames);
[R, C]=size(imagesMat1);
meanVec=sum(imagesMat1)/R;
adjustedMeanMat=zeros(R,C);
for i = 1:R
    for j = 1:C
    adjustedMeanMat(i,j)=imagesMat1(i,j)-meanVec(1,j);
    end
end
convMatrix=(transpose(adjustedMeanMat)*adjustedMeanMat)/R-1;
[V,D] = eig(convMatrix);
eigenValues=diag(D);
[sortedEigenValues,I]=sort(eigenValues,'descend');
eigenValsSum=sum(sortedEigenValues);
sortedEigenValues=sortedEigenValues/eigenValsSum;
cum=0;
stopCondition=1.0000;
for i=1:2500
    if cum>=0.9999
        eigenVictorsChoosed=extractEigenVictors(i-1,sortedEigenValues,I,V);
        break;
    else
        cum=cum+sortedEigenValues(i,1)
        comulativeMat(1,i)=cum;
    end
end
[rows, cols]=size(eigenVictorsChoosed);
sumMat=linspace(1,cols,cols);
plot(sumMat,comulativeMat(:,1:cols));
finalData=transpose(eigenVictorsChoosed)*transpose(adjustedMeanMat);
finalData=transpose(finalData)
