function [ actualTrainClass ] = mknnExtractactualTrainClass( trainNum,sizeclassTrain ,classTrain)
actualTrainClass=zeros(1);
for i=1:trainNum
    for classInd=1:sizeclassTrain
        %check minInd lay between the start and end Indices of each class
        if i>=classTrain(classInd,1) && i<=classTrain(classInd,2)
           actualTrainClass=vertcat(actualTrainClass,classInd);
           break;
        end
    end
end
actualTrainClass=actualTrainClass(2:trainNum+1,:);
end

