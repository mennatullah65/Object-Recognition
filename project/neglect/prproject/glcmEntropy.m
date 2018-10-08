function [ res ] = glcmEntropy( glcm )
[h,w]=size(glcm);
res=0;
for y=1:h
    for x=1:w
        if(glcm(y,x) ~= 0)
            res=res+(glcm(y,x)*log(glcm(y,x)));
        end        
    end
end
res=res*-1;
end

