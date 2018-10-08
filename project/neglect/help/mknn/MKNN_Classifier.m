function confusionMat = MKNN_Classifier(K,dist,actualClass,classTrain )
confusionMat=zeros(5,5);
[R,C]=size(dist);%dist is a 26 * 25 matrix
sizeClass=5;
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
        minKdist=cat(1,minKdist,minDist);
        %Find the output min is from which category(or class)
        for classInd=1:sizeClass
            %check minInd lay between the start and end Indices of each class
            if minInd>=classTrain(classInd,2) && minInd<=classTrain(classInd,3)
               %relevants(kInd)=classTrain(classInd,1);
               relevants=cat(1,relevants,classTrain(classInd,1));
               break;
            end
        end
        %%%
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    % minKdist / relevants 
    d1=min(minKdist);
    dk=max(minKdist);
    [r,c]=size(minKdist);
    wightnMat=zeros(r,c);
    %calc wight
    for j=1:c
        if(d1==dk)
            w=1;
        else
           w=(dk-minKdist(j))/(dk-d1); 
        end
        wightnMat(j)=w;
    end
    
    %numofclass=relevants(1,1);
    sum=0;
    takenclass=zeros(r,c);
    classwight=zeros(r,c);
    for n=1:c
        numofclass=relevants(1,n);
       for m=1:c
            if(relevants(1,m)==numofclass&&checkexistance(numofclass,takenclass)==0)
                        sum=sum+minKdist(1,m);
            else
                break;
            end%endif
       end
       classwight(n)=sum;
       takenclass(n)=numofclass;
    end
  maxwight=max(classwight);
  
  for z=1:size(classwight) 
      if(maxwight==classwight(z))
          w_index=z;
          break;
      end
  end
  relevantClass=takenclass(w_index);
  confusionMat(actualClass(i),relevantClass)=confusionMat(actualClass(i),relevantClass)+1;
end



