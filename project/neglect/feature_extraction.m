function [ featuresVar  ] = feature_extraction( input_directory,filenames,method,sizeFeatures)
num_images = length(filenames); %number of images found in selected folder
featuresVar=zeros(num_images,sizeFeatures);
for i = 1:num_images
    %Build File Name
    filename = fullfile(input_directory, filenames(i).name);
    img = imread(filename);
    if method==1 %glcm
        mat=glcm(img);
    elseif method==2%runlength
        mat=runlength(img);
    else%both
        featureMat1=glcm(img);
        featureMat2=runlength(img);
        mat=horzcat(featureMat1,featureMat2);
    end
    featuresVar(i,:)=mat;    
end
end

