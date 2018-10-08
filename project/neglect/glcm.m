function [ featuresVar ] = glcm( inputimg)

% i. The spatial relations are (1,0), (0,1) and (1,1).
% ii. The size of matrix is 6*6 (i.e. scale each image to gray level integer values between 0 and 5).
% iii. The matrix should be normalized and symmetric.
% iv. The final value per feature is the average of the three values obtained from the three spatial relations.

%%Normalize to graylevel between 0 - 5
%[OldMin, OldMax] ? [NewMin, NewMax]
%NewVal = [(OldVal – OldMin)/(OldMax – OldMin)] × (NewMax – NewMin) + NewMin
GImg=rgb2gray(inputimg);
oldMin=min(min(GImg(:,:)));
oldMax=max(max(GImg(:,:)));
newMin=0;
newMax=5;
[R,C]=size(GImg);
for i=1:R
    for j=1:C
        GImg(i,j)= ((GImg(i,j)- oldMin)/(oldMax- oldMin)) * (newMax - newMin) + newMin;
    end
end
Gimg=imresize(GImg,[6,6]);
[a, b] = size (Gimg);

%% 1-0 horizontal
glcm10=zeros(6,6);
for y=1:a
    for x=1:b
        if(x+1<=b)
            glcm10(Gimg(y,x)+1,Gimg(y,x+1)+1)=glcm10(Gimg(y,x)+1,Gimg(y,x+1)+1)+1;
        end
    end
end
sumMat=sum(sum(glcm10));
glcm10 = glcm10 + glcm10.';
glcm10=glcm10 / sumMat;

%% 0-1 vertical
glcm01=zeros(6,6);
for y=1:a
    for x=1:b
        if(y+1<=a)
            glcm01(Gimg(y,x)+1,Gimg(y+1,x)+1)=glcm01(Gimg(y,x)+1,Gimg(y+1,x)+1)+1;
        end
    end
end
sumMat=sum(sum(glcm01));
glcm01 = glcm01 + glcm01.';
glcm01=glcm01 / sumMat;

%% 1-1 diagonal
glcm11=zeros(6,6);
for y=1:a
    for x=1:b
        if(y+1<=a && x+1<=b)
            glcm11(Gimg(y,x)+1,Gimg(y+1,x+1)+1)=glcm11(Gimg(y,x)+1,Gimg(y+1,x+1)+1)+1;
        end
    end
end
sumMat=sum(sum(glcm11));
glcm11 = glcm11 + glcm11.';
glcm11=glcm11 / sumMat;

%% calculate features %%

%%%1%%%
contrast1=glcmContrast(glcm10);
contrast2=glcmContrast(glcm01);
contrast3=glcmContrast(glcm11);
feature1=mean([contrast1,contrast2,contrast3]);

%%%2%%%
energy1=glcmEnergy(glcm10);
energy2=glcmEnergy(glcm01);
energy3=glcmEnergy(glcm11);
feature2=mean([energy1,energy2,energy3]);

%%%3%%%
entropy1=glcmEntropy(glcm10);
entropy2=glcmEntropy(glcm01);
entropy3=glcmEntropy(glcm11);
feature3=mean([entropy1,entropy2,entropy3]);

%%%4%%%
homogeneity1=glcmHomogeneity(glcm10);
homogeneity2=glcmHomogeneity(glcm01);
homogeneity3=glcmHomogeneity(glcm11);
feature4=mean([homogeneity1,homogeneity2,homogeneity3]);

featuresVar=[feature1,feature2,feature3,feature4];
end



