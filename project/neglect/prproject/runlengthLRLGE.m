function [ lrlge ] = runlengthLRLGE( mat )
[h,w]=size(mat);
lrlge=0;
for i=1:h
  for j=1:w
      lrlge=lrlge+((mat(i,j)*(j.^2))/(i.^2));
  end
end
lrlge=lrlge/(sum(sum(mat)));
end

