function [ featuresVar ] = runlength( inputimg )
%i. The four directions (0, 45, 90, 135).
%ii. Scale each image to gray level integer values between 0 and 5.
%iii. The final value per feature is the average of the four values obtained from the four directions.


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

%0
RL0=calcRL0(Gimg);
%90
RL90=calcRL0(Gimg.');
%45
RL45=calcRL45(Gimg);
%135
RL135=calcRL45(Gimg.');

%% calculate features %%

%%%1%%%
SRE0=runlengthSRE(RL0);
SRE90=runlengthSRE(RL90);
SRE45=runlengthSRE(RL45);
SRE135=runlengthSRE(RL135);
feature1=mean([SRE0,SRE90,SRE45,SRE135]);

%%%2%%%
LRE0=runlengthLRE(RL0);
LRE90=runlengthLRE(RL90);
LRE45=runlengthLRE(RL45);
LRE135=runlengthLRE(RL135);
feature2=mean([LRE0,LRE90,LRE45,LRE135]);

%%%3%%%
HGRE0=runlengthHGRE(RL0);
HGRE90=runlengthHGRE(RL90);
HGRE45=runlengthHGRE(RL45);
HGRE135=runlengthHGRE(RL135);
feature3=mean([HGRE0,HGRE90,HGRE45,HGRE135]);

%%%4%%%
LGRE0=runlengthLGRE(RL0);
LGRE90=runlengthLGRE(RL90);
LGRE45=runlengthLGRE(RL45);
LGRE135=runlengthLGRE(RL135);
feature4=mean([LGRE0,LGRE90,LGRE45,LGRE135]);

%%%5%%%
RLNU0=runlengthRLNU(RL0);
RLNU90=runlengthRLNU(RL90);
RLNU45=runlengthRLNU(RL45);
RLNU135=runlengthRLNU(RL135);
feature5=mean([RLNU0,RLNU90,RLNU45,RLNU135]);

%%%6%%%
GLNU0=runlengthGLNU(RL0);
GLNU90=runlengthGLNU(RL90);
GLNU45=runlengthGLNU(RL45);
GLNU135=runlengthGLNU(RL135);
feature6=mean([GLNU0,GLNU90,GLNU45,GLNU135]);

%%%7%%%
RP0=runlengthRP(RL0);
RP90=runlengthRP(RL90);
RP45=runlengthRP(RL45);
RP135=runlengthRP(RL135);
feature7=mean([RP0,RP90,RP45,RP135]);

%%%8%%%
SRLGE0=runlengthSRLGE(RL0);
SRLGE90=runlengthSRLGE(RL90);
SRLGE45=runlengthSRLGE(RL45);
SRLGE135=runlengthSRLGE(RL135);
feature8=mean([SRLGE0,SRLGE90,SRLGE45,SRLGE135]);

%%%9%%%
SRHGE0=runlengthSRHGE(RL0);
SRHGE90=runlengthSRHGE(RL90);
SRHGE45=runlengthSRHGE(RL45);
SRHGE135=runlengthSRHGE(RL135);
feature9=mean([SRHGE0,SRHGE90,SRHGE45,SRHGE135]);

%%%10%%%
LRHGE0=runlengthLRHGE(RL0);
LRHGE90=runlengthLRHGE(RL90);
LRHGE45=runlengthLRHGE(RL45);
LRHGE135=runlengthLRHGE(RL135);
feature10=mean([LRHGE0,LRHGE90,LRHGE45,LRHGE135]);

%%%11%%%
LRLGE0=runlengthLRLGE(RL0);
LRLGE90=runlengthLRLGE(RL90);
LRLGE45=runlengthLRLGE(RL45);
LRLGE135=runlengthLRLGE(RL135);
feature11=mean([LRLGE0,LRLGE90,LRLGE45,LRLGE135]);

featuresVar=[feature1,feature2,feature3,feature4,feature5,feature6,feature7,feature8,feature9,feature10,feature11];
end

