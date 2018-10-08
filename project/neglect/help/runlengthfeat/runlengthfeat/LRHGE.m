function [ lrhge ] = LRHGE( mat )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
    [h w]=size(mat);
    lrhge=0;
  for i=1:h
      for j=1:w
          lrhge=lrhge+(mat(i,j)*(i.^2)*(j.^2));
      end
  end
       lrhge=lrhge/(sum(sum(mat)));

end

