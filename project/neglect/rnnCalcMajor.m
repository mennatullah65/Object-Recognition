function majorityClass=rnnCalcMajor(equal_r_dist,relevants,sizeclassTrain)
howmany=zeros(sizeclassTrain);
[len,~]=size(relevants);
for i=1:len
    howmany(relevants(i))=howmany(relevants(i))+1;
end
[val,ind]=max(howmany);
valrepeated=0;

for i=1:sizeclassTrain
    if howmany(i)==val
        valrepeated=valrepeated+1;
    end
    if valrepeated>1
        break;
    end
end

if valrepeated==1
    majorityClass=ind;
else
%in case no value is most frequent ; the majority is the nearest class
    [~,ind]=min(equal_r_dist);
    majorityClass=relevants(ind);
end