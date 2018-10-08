function [ res ] = glcmHomogeneity( glcm )
[h,w]=size(glcm);
%R= log(GLCM);
%R=sum(sum(GLCM .* GLCM));
res=0;
for y=1:h
    for x=1:w
        res=res + (glcm (y,x) / (1+ abs(y-x)));       
    end
end
end

