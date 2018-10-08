function [ RL45 ] = calcRL45( Gimg )
RL45=zeros(6,6);
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
                RL45(d1(j,1)+1,count)=RL45(d1(j,1)+1,count)+1;
                count=1;
            end
        else
            RL45(d1(j,1)+1,count)=RL45(d1(j,1)+1,count)+1;
            count=1;
        end
    end
end
end

