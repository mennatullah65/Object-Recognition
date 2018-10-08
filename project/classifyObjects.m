function  classifyObjects(handles, image,filename,methodClassify,AF,SC,bias,learnRate,numOfEpochs ,numOfHiddenLayers,numOfNeurons,mse,rbf_epochs,rbf_eta,rbf_hiddenneurons,rbf_msethreshold)
[filepath,name,~] = fileparts(filename);
imgsegpath=strcat(filepath,'\',name,'.png');
imgseg=imread(imgsegpath);
%figure,imshow(imgseg);
grayimage=rgb2gray(imgseg);
BW = edge(grayimage,'Canny');
BW = imdilate(BW,ones(5,5));
%BW=bwareaopen(BW,400);
BW = ~BW;
[Labels, no_objects] = bwlabel(BW); %Integer labels starting from 0
[h, w] = size(imgseg);
smallRatio = h*w*0.0001;
numOfClasses=5;
[ w_intput,w_hidden,eigenVictorsChoosed ]=classifyImg(methodClassify,AF,SC,bias,learnRate,numOfEpochs,numOfHiddenLayers,numOfNeurons,mse,rbf_epochs,rbf_eta,rbf_hiddenneurons,rbf_msethreshold);
for i=1:no_objects
    x = uint8(Labels==i);
    f = sum(sum(x==1));
     if(f < smallRatio) % to neglect small regions
         continue;
     end    
    measurements = regionprops(x, 'BoundingBox');
    boundingBox = measurements(1).BoundingBox;
    x=boundingBox(1);
    y=boundingBox(2);
    wid=boundingBox(3);
    hig=boundingBox(4);

    pos=[x y wid hig];
    img=imcrop(image,pos );
    [r,c]=size(img);
    if (r==h) && (c==w)
       continue;
    end
    %%start classify
    class=0;
    if (methodClassify==1)
    [ class ] = singleingMLP( img,w_intput,w_hidden,eigenVictorsChoosed,bias ,numOfHiddenLayers,numOfNeurons,numOfClasses,AF,SC);
    end
    axes(handles.axes1);

    if class==1
        obj='cat';
        rectangle('Position',pos,'EdgeColor','r');
        t=text(x ,y,obj);
        t.Color=[1 1 1];
        t.FontSize = 18;
    elseif class==2
        obj='laptop';
        rectangle('Position',pos,'EdgeColor','r');
        t=text(x ,y,obj);
        t.Color=[1 1 1];
        t.FontSize = 18;
    elseif class==3
        obj='apple';
        rectangle('Position',pos,'EdgeColor','r');
        t=text(x ,y,obj);
        t.Color=[1 1 1];
        t.FontSize = 18;
    elseif class==4
        obj='car';
        rectangle('Position',pos,'EdgeColor','r');
        t=text(x ,y,obj);
        t.Color=[1 1 1];
        t.FontSize = 18;
    elseif class==5
        obj='helicopter';
        rectangle('Position',pos,'EdgeColor','r');
        t=text(x ,y,obj);
        t.Color=[1 1 1];
        t.FontSize = 18;
    end    
    %figure,imshow(img);
end
end

