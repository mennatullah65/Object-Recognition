function [ R ] = glcmContrast( glcm )
[h, w] = size (glcm);
for y=1:h
    for x=1:w
        glcm(y,x)=glcm(y,x)*((y-x)^2);
    end
end
R = sum(sum(glcm));
end

