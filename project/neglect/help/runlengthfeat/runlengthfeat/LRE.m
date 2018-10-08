function [ lre ] = LRE( mat )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    [h w]=size(mat);
    lre=0;
  for i=1:h
      for j=1:w
          lre=lre+(mat(i,j)*(j.^2));
      end
  end
       lre=lre/(sum(sum(mat)));
end

