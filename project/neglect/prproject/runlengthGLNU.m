function [ glnu ] = runlengthGLNU( mat )
[h,w]=size(mat);
glnu=0;
for i=1:h
   row=0;
   for j=1:w
       row=row+mat(i,j);
   end
   glnu=glnu+row.^2;
end
glnu=glnu/sum(sum(mat));
end

