function [ R ] = glcmEnergy( glcm )
glcm = glcm .* glcm;
R = sum(sum(glcm));
end

