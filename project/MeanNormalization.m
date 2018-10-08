function [ datadash ] = MeanNormalization( data )

[~,c]=size(data);
for i=1:c
data(:,i)=(data(:,i)-mean(data(:,i)))/(max(data(:,i))-min(data(:,i)));
end
datadash=data;
end

