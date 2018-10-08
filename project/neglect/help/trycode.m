%{%
Gimg=[
0 0 0 0 0 2
1 1 1 1 1 4
2 2 2 1 0 3
3 3 2 1 5 3
5 5 3 4 2 2
5 5 4 4 4 4
]
%}
feature1=mean([15,2,7,10])

%{

%35
RL35=zeros(6,6);
[R,C]=size(Gimg);
diagnum=R+C-1;
diagstart=floor(diagnum/2);
count=1;
for i=-diagstart:diagstart
    d1=diag(Gimg,i);
    [all,~]=size(d1);
    for j=1:all
        if j+1<=all
            if d1(j,1)==d1(j+1,1)
                count=count+1;
            else
                RL35(d1(j,1)+1,count)=RL35(d1(j,1)+1,count)+1;
                count=1;
            end
        else
            RL35(d1(j,1)+1,count)=RL35(d1(j,1)+1,count)+1;
            count=1;
        end
    end
end

RL35


%}
%{
RL0=zeros(6,6);
count=1;
for i=1:R
    for j=1:C
        if i+1<=R && j+1 <= C      
            if Gimg(i,j)==Gimg(i+1,j+1)
                count=count+1;
            else
                RL0(Gimg(i,j)+1,count)=RL0(Gimg(i,j)+1,count)+1;
                count=1;
            end
        else
            RL0(Gimg(i,j)+1,count)=RL0(Gimg(i,j)+1,count)+1;
            count=1;
        end
    end
end

RL0
%}