function [ res ] = checkexistance( numofclass , takenclass )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

res=0;
for L=1:size(takenclass)
   if(numofclass==takenclass(L))
       res=-1;
       break;
   end
end

end

