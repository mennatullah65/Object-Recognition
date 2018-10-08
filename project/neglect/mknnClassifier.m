function confusionMat = mknnClassifier(K,dist,actualTestClass,actualTrainClass,sizeclassTest,sizeclassTrain)
confusionMat=zeros(sizeclassTest,sizeclassTrain);
[R,C]=size(dist);%dist is a 26 * 25 matrix
for i=1:R  
relevants=zeros(1);
minKdist=zeros(1);   
for kInd=1:K
    minDist=realmax; 
    for j=1:C
        if dist(i,j)<minDist
            minDist=dist(i,j);
            minInd=j;
        end
    end
    dist(i,minInd)=realmax;
    minKdist=vertcat(minKdist,minDist);
    %Find the output min is from which category(or class)
    relevants=vertcat(relevants,actualTrainClass(minInd));
end
% minKdist / relevants
d1=min(minKdist(2:K+1,:));
dk=max(minKdist(2:K+1,:));
[r,~]=size(minKdist);
r=r-1;
wightnMat=zeros(sizeclassTrain);
%calc weight
for classInd=1:sizeclassTrain
    for distInd=1:r
        if relevants(distInd+1)==classInd
            w=(dk-minKdist(distInd+1)) /(dk-d1);
            wightnMat(classInd)=wightnMat(classInd)+w;
        end
    end
end
[~,relevantClass]=max(wightnMat);%ignore value and get ony distance
confusionMat(actualTestClass(i),relevantClass)=confusionMat(actualTestClass(i),relevantClass)+1;
end



