function [class]=rnnImgClassifier(r,dist,actualTrainClass,sizeclassTrain)
[~,C]=size(dist);%dist is a 1 * 25 matrix
equal_r_dist=zeros(1);
relevants=zeros(1);
size_r_dist = 0;
for j=1:C
    if dist(1,j) <= r
        size_r_dist = size_r_dist + 1;
        equal_r_dist=vertcat(equal_r_dist,dist(1,j));   
        relevants=vertcat(relevants,actualTrainClass(j));
    end
end    
%Get the majority class of minimums
[class]=rnnCalcMajor(equal_r_dist(2:size_r_dist+1,:),relevants(2:size_r_dist+1,:),sizeclassTrain);
end