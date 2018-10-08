function Result = extract_images( input_directory,filenames )
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
end