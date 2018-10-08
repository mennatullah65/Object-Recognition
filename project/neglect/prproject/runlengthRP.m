function [ rp ] = runlengthRP( mat)
[r,c]=size(mat);
n=0;
for j=1:c
    count=0;
    for i=1:r
        count=count+mat(i,j);
    end
    count=count*j;
    n=n+count;
end
rp=sum(sum(mat))/n;
end

