function [ lgre ] = runlengthLGRE( mat )
[h,w]=size(mat);
lgre=0;
for i=1:h
  for j=1:w
      lgre=lgre+(mat(i,j)/i.^2);
  end
end
lgre=lgre/(sum(sum(mat)));
end

