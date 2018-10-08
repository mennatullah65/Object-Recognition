function [testingOut,trainingOut]=normalization(testing,training)
[R1,C1]=size(testing);
[R2,C2]=size(training);
testingOut=zeros(R1,C1);
for j=1:C1
    minv=min(testing(1:R1,j));
    maxv=max(testing(1:R1,j));
    subval= maxv-minv;
    testingOut(1:R1,j)=(testing(1:R1,j)-minv)/subval;
%     meanval=mean(testing(1:R1,j));
%     testingOut(1:R1,j)=testing(1:R1,j)/meanval;
end

trainingOut=zeros(R2,C2);
for j=1:C2
    minv=min(training(1:R2,j));
    maxv=max(training(1:R2,j));
    subval= maxv-minv;
    trainingOut(1:R2,j)=(training(1:R2,j)-minv)/subval;
%     meanval=mean(training(1:R2,j));
%     trainingOut(1:R2,j)=training(1:R2,j)/meanval;
end

end