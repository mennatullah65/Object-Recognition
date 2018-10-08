function [features]=getFeatures(filename)
fid = fopen(filename);
tline = fgetl(fid);
tline = fgetl(fid);
C=strsplit(tline,'\t');
[~,c]=size(C);
features=zeros(1,c);
count=1;
while ischar(tline)
    arr=0;
    for i=1:c 
       arr=horzcat(arr, str2double(C(i)));
    end
    arr=arr(1,2:c+1);
    features=vertcat(features,arr);
    tline = fgetl(fid);
    if ~ischar(tline),break;
    end
    C=strsplit(tline,'\t');
    count=count+1;
    [~,c]=size(C);
end
fclose(fid);
features=features(2:count,:);
end