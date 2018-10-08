function [ res ] = GLCM( img , dx, dy)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
% semetry and normalize
max_size = max (max(img(:,:)));
res=zeros(max_size+1,max_size+1);
[a, b] = size (img);
for y=1:a-dy
    for x=1:b-dx
        res(img(y,x)+1,img(y+dy,x+dx)+1)=res(img(y,x)+1,img(y+dy,x+dx)+1)+1;
    end
end
sum2=sum(sum(res));
res = res + res';
res=res / sum2;
end

