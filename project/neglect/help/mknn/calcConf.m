function output=calcConf(confusionMat)
[R ,C]=size(confusionMat);
sumDiags=0;
for i=1:R
    sumDiags=sumDiags+confusionMat(i,i);
    sumR=0;
    for j=1:C
        sumR=sumR+confusionMat(i,j);
    end 
end
output=(sumDiags/26)*100;
end