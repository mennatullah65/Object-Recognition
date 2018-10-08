function [ hgre ] = HGRE( mat )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
   [h w]=size(mat);
    hgre=0;
  for i=1:h
      for j=1:w
          hgre=hgre+(mat(i,j)*(i.^2));
      end
  end
       hgre=hgre/(sum(sum(mat)));

end

