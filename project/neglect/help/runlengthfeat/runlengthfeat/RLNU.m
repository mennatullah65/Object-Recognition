function [ rlnu ] = RLNU( mat )
%UNTITLED9 Summary of this function goes here
%   Detailed explanation goes here
 [h w]=size(mat);
   rlnu=0;
   for j=1:w
       col=0;
       for i=1:h
           col=col+mat(i,j);
       end
       rlnu=rlnu+col.^2;
   end
   rlnu=rlnu/sum(sum(mat));
end

