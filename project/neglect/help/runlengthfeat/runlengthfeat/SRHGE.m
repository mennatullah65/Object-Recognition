function [ srhge ] = SRHGE( mat )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
    [h w]=size(mat);
    srhge=0;
  for i=1:h
      for j=1:w
          srhge=srhge+((mat(i,j)*(i.^2))/(j.^2));
      end
  end
       srhge=srhge/(sum(sum(mat)));

end

