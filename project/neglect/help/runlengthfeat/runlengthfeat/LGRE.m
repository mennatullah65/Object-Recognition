function [ lgre ] = LGRE( mat )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
 [h w]=size(mat);
    lgre=0;
  for i=1:h
      for j=1:w
          lgre=lgre+(mat(i,j)/i.^2);
      end
  end
       lgre=lgre/(sum(sum(mat)));

end

