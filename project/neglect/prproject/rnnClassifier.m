function confusionMat = rnnClassifier( r,dist,actualTestClass,actualTrainClass,sizeclassTest,sizeclassTrain)
confusionMat=zeros(sizeclassTest,sizeclassTrain);
[R,C]=size(dist);
for i=1:R
    relevants=zeros(1);
    equal_r_dist=zeros(1);
    size_r_dist = 0;
    for j=1:C
        if dist(i,j) <= r
            size_r_dist = size_r_dist + 1;
            equal_r_dist=vertcat(equal_r_dist,dist(i,j));   
            relevants=vertcat(relevants,actualTrainClass(j));
        end
    end    
    %Get the majority class of minimums
    relevantClass=rnnCalcMajor(equal_r_dist(2:size_r_dist+1,:),relevants(2:size_r_dist+1,:),sizeclassTrain);
    confusionMat(actualTestClass(i),relevantClass)=confusionMat(actualTestClass(i),relevantClass)+1;
end
