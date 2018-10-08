function [ classResult ] = singleingMLP( img,w_intput,w_hidden,eigenVictorsChoosed ,BiasOrNot,numHiddenLayers,numNeurons,numOfClasses,AF,SC)
Glmg=double(rgb2gray(img));
resizedImage=imresize(Glmg,[50,50]);
reshapedImage=reshape(resizedImage,1,2500);
reshapedImage=reshapedImage/mean(reshapedImage);
features=(eigenVictorsChoosed.')*(reshapedImage.');
bias=1;
    % mlp algo
    if(BiasOrNot==1)
        features=vertcat(bias,features);
    end
    x=features;   
    w=w_intput; 
    y_h=zeros(numNeurons,numHiddenLayers);
    y_o=zeros(numOfClasses,1); 
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %calculate output
    %y for hidden layers
    for h=1:numHiddenLayers
        for j=1:numNeurons 
            if h==1
                net=transpose(w(j,:).N)*x;
            else
                resW=zeros(numNeurons,1);
                counter=numNeurons;
                if(BiasOrNot==1)
                    counter=counter+1;
                    resW=vertcat(0,resW);
                end
                for n=1:counter
                    resW(n,1)=w(1,n).N(j);
                end
                net=transpose(resW)*x;
            end
            if (AF==1)
                y_h(j,h)=logsig(net);
            else
                y_h(j,h)=tanh(net);
            end
        end
        x=y_h(:,h);
        if(BiasOrNot==1)
           x=vertcat(bias,x);
        end
        w=w_hidden(h,:);    
    end 
    %y for output layer
    max_o=realmin;
    max_ind=1;
    for o=1:numOfClasses
        resW=zeros(numNeurons,1);
        counter=numNeurons;
        if(BiasOrNot==1)
            counter=counter+1;
            resW=vertcat(0,resW);
        end
        for n=1:counter
            resW(n,1)=w(1,n).N(o);
        end
        net=transpose(resW)*x;
        if (AF==1)
            y_o(o,1)=logsig(net);
        else
            y_o(o,1)=tanh(net);
        end
        if (y_o(o,1)>max_o)
            max_o=y_o(o,1);
            max_ind=o;
        end
    end
    classResult=max_ind;  
end