function [ sre ] = SRE( mat )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
  [h w]=size(mat);
    sre=0;
  for i=1:h
      for j=1:w
          sre=sre+(mat(i,j)/j.^2);
      end
  end
       sre=sre/(sum(sum(mat)));
end

