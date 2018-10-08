function [ featuresVar ,eigenVictorsChoosed ] = feature_extraction( input_directory,filenames,trainOrtest,eigentemp)
num_images = length(filenames); %number of images found in selected folder
Result=zeros(num_images,2500);
for i= 1:num_images
    fileName=fullfile(input_directory,filenames(i).name);
    image=imread(fileName);
    Glmg=rgb2gray(image);
    resizedImage=imresize(Glmg,[50,50]);
    reshapedImage=reshape(resizedImage,1,2500);
    Result(i,:)=reshapedImage;
end
if trainOrtest==1
    [featuresVar,eigenVictorsChoosed]=PCA(Result);
else
    [featuresVar]=PCA_test(Result,eigentemp);
    eigenVictorsChoosed=0;
end
end

