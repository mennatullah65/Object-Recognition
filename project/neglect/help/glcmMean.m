function [ res ] = glcmMean(vec)
[~,n] = size (vec);
s = sum(vec);
res = (s/n);
end

