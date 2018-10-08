%%%extractTestObjects%%%
input_directory = 'E:\CS\PR\project\Data set\Testing'; 
out_directory = 'E:\CS\PR\project\Data set\Testing\segmented'; 
 
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
%{
path='E:\CS\PR\project\Data set\Testing';
original=dir(fullfile(path, '*.jpg'));
segmented = dir(fullfile(path, '*.png'));
num_images = length(original);

%for i=1:num_images
    originalimgpath = fullfile(path, original(1).name);
    originalimg = imread(originalimgpath);
    segmentedimgpath = fullfile(path, segmented(1).name);
    segmentedimg = imread(segmentedimgpath);
    %extract background color
    %%get number of colors in img
    smallsegmented=imresize(segmentedimg,.3);
    imshow(smallsegmented);
    [R,C,~]=size(smallsegmented);
    backgroundcolor=zeros(1,3);
    othercolors=zeros(1,4);
    for r=1:R
        for c=1:C
            color=[smallsegmented(r,c,1),smallsegmented(r,c,2),smallsegmented(r,c,3),0];
            found=0; 
            [cR,~]=size(othercolors);
            for cr=1:cR  
                if r==1 && c==3
                end
                if color(1,1:3)==othercolors(cr,1:3)% && color(1,2)==othercolors(cr,2) && color(1,3)==othercolors(cr,3)
                    found=1;
                    othercolors(cr,4)=othercolors(cr,4)+1;
                    break;
                end                   
            end
            if found==0
                    othercolors=vertcat(othercolors,color);
            end
        end
    end
    
%end
%}