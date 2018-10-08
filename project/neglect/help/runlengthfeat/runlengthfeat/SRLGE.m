function [ srlge ] = SRLGE( mat )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
    [h w]=size(mat);
    srlge=0;
  for i=1:h
      for j=1:w
          srlge=srlge+(mat(i,j)/((j.^2)*(i.^2)));
      end
  end
       srlge=srlge/(sum(sum(mat)));

end

