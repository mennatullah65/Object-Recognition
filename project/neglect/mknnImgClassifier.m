function [class]=mknnImgClassifier(K,dist,actualTrainClass,sizeclassTrain)
[~,C]=size(dist);%dist is a 1 * 25 matrix
relevants=zeros(1);
minKdist=zeros(1);   
for kInd=1:K
    minDist=realmax; 
    for j=1:C
        if dist(j)<minDist
            minDist=dist(j);
            minInd=j;
        end
    end
    dist(1,minInd)=realmax;
    minKdist=vertcat(minKdist,minDist);
    %Find the output min is from which category(or class)
    relevants=vertcat(relevants,actualTrainClass(minInd));
end
% minKdist / relevants
minKdist=minKdist(2:K+1,:);
relevants=relevants(2:K+1,:);
d1=min(minKdist);
dk=max(minKdist);
[r,~]=size(minKdist);
wightnMat=zeros(sizeclassTrain,1);
%calc weight
for classInd=1:sizeclassTrain
    for distInd=1:r
        if relevants(distInd)==classInd
            if dk==d1
                w=1;
            else
                w=(dk-minKdist(distInd)) /(dk-d1);
            end
            wightnMat(classInd,1)=wightnMat(classInd,1)+w;
        end
    end
end
[~,class]=max(wightnMat);%get the class number
end