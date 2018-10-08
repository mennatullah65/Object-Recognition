function [finalData]=PCA_test(Result,eigenVictorsChoosed)
imagesMat1=Result;%the extracted images
[R, C]=size(imagesMat1);
meanVec=sum(imagesMat1)/R;
adjustedMeanMat=zeros(R,C);
for i = 1:R
    for j = 1:C
    adjustedMeanMat(i,j)=imagesMat1(i,j)-meanVec(1,j);
    end
end
finalData=transpose(eigenVictorsChoosed)*transpose(adjustedMeanMat);
finalData=transpose(finalData);
end