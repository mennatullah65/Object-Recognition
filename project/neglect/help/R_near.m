function confusionMat = R_near( r,dist,actualClass,classTrain)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
confusionMat=zeros(5,5);
[R,C]=size(dist);
sizeClass=5;
size_r_dist = 0;
for i=1:R
    relevants=zeros(1);
    equal_r_dist=zeros(1);
    for j=1:C
        if dist(i,j) == r
            dist_equal_near=dist(i,j);
            equal_r_dist=cat(1,equal_r_dist,dist_equal_near);
            size_r_dist = size_r_dist + 1;
            distInd=j;
            for classInd=1:sizeClass
                %check distInd lay between the start and end Indices of each class
                if distInd>=classTrain(classInd,2) && distInd<=classTrain(classInd,3)
                    relevants=cat(1,relevants,classTrain(classInd,1));
                    break;
                end
            end
        end
    end
    
    %Get the majority class of minimums
    relevantClass=calcMajor(equal_r_dist(2:size_r_dist+1,:),relevants(2:size_r_dist+1,:));
    confusionMat(actualClass(i),relevantClass)=confusionMat(actualClass(i),relevantClass)+1;
end
