function [ RL0 ] = calcRL0( Gimg )

[R,C]=size(Gimg);
RL0=zeros(6,6);
count=1;
for i=1:R
    for j=1:C
        if j+1 <= C      
            if Gimg(i,j)==Gimg(i,j+1)
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

end

