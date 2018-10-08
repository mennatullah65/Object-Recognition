%%%extractTestObjects%%%
input_directory = 'E:\CS\NN\project\Testing'; 
out_directory = 'E:\CS\NN\project\Testing\segmented'; 
 
originalImages = dir(fullfile(input_directory, '*.jpg'));
segmentedImages= dir(fullfile(input_directory, '*.png'));
num_images = length(originalImages);
for j = 1:num_images
%2) Convert loaded image to grayscale image
image = imread(fullfile(input_directory, segmentedImages(j).name));
originalImage=imread(fullfile(input_directory, originalImages(j).name));
grayimage = rgb2gray(image);
%3) Edge Detection
BW = edge(grayimage,'Canny');
%4) Dilate Image
BW = imdilate(BW,ones(5,5));
BW=bwareaopen(BW,100);
%subplot(2,3,4); imshow(BW); title('After Dilation');
BW = ~BW;
%figure,imshow(BW);
[Labels, no_objects] = bwlabel(BW); %Integer labels starting from 0
% Display objects
[h, w] = size(image);
smallRatio = h*w*0.0001;
mkdir (out_directory,num2str(j));
ind=1;
for i=1:no_objects
    x = uint8(Labels==i);
    f = sum(sum(x==1));
     if(f < smallRatio) % to neglect small regions
         continue;
     end
    measurements = regionprops(x, 'BoundingBox');
    boundingBox = measurements(1).BoundingBox;
    outImage=imcrop(originalImage,[boundingBox(1) ,boundingBox(2),boundingBox(3),boundingBox(4)] );
    imwrite(outImage,fullfile(strcat(out_directory,'\',num2str(j)),strcat(num2str(ind),'_',segmentedImages(j).name,'.jpg')));
    ind=ind+1;
    %imwrite(outImage,fullfile(strcat(out_directory,'\',num2str(j)),strcat(num2str(i),segmentedImages(j).name)));
end
end