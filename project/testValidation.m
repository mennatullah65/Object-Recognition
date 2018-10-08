function [ mse ] = testValidation( validation,xlength,indices,w_intput,w_hidden,actualTrain,BiasOrNot,numNeurons,numHiddenLayers,numOfClasses,AF )
testingLen=xlength;
testing_features=validation;
sumErrors=0;
bias=1;
for i=1:testingLen
    features=testing_features(i,:).';
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
    end
    desired=zeros(numOfClasses,1);
    for classInd=1:numOfClasses
        if(indices(i)>=actualTrain(classInd,1)&&indices(i)<=actualTrain(classInd,2))
            desired(classInd,1)=1;
            break;
        end
    end
    sumErrors=sumErrors+(sum((desired-y_o).^2)/numOfClasses);
end
mse=sumErrors/(2*xlength);
end

