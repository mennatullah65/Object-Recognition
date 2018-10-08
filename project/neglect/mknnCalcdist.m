function [ distmat ] = mknnCalcdist( testingMat, trainingMat,sizeFeatures )
[R1 , ~]=size(testingMat);
[R2 , ~]=size(trainingMat);
distmat=zeros(R1,R2);
for i=1:R1
    for j=1:R2
        x=0;
        for k=1:sizeFeatures            
            x=x+((testingMat(i,k)-trainingMat(j,k)).^2);
        end 
        distmat(i,j)=sqrt(x);
    end
end 
end
