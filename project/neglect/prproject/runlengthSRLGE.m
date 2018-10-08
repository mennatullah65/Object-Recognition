function [ srlge ] = runlengthSRLGE( mat )
[h,w]=size(mat);
srlge=0;
for i=1:h
  for j=1:w
      srlge=srlge+(mat(i,j)/((j.^2)*(i.^2)));
  end
end
srlge=srlge/(sum(sum(mat)));
end

