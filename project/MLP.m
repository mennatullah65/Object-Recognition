function [w_intput,w_hidden]=MLP(numOfClasses,training_features,testing_features,numHiddenLayers,numNeurons,eta,numEpochs,AF,SC,mseThreshold,BiasOrNot,actualTrain,actualTest)
[trainingLen,numOfFeatures]=size(training_features);
[testingLen,~]=size(testing_features);
bias=1;
%(b-a).*rand(1000,1) + a; range -1 to 1
a=-1;b=1;
if(BiasOrNot==1)
    for i=1:numNeurons
        w_intput(i,1).N=(b-a).*rand(numOfFeatures+1,1)+a;
    end
    for i=1:numHiddenLayers-1
        for j=1:numNeurons+1
            w_hidden(i,j).N=(b-a).*rand(numNeurons,1)+a;
        end
    end
    for j=1:numNeurons+1
        w_hidden(numHiddenLayers,j).N=(b-a).*rand(numOfClasses,1)+a;
    end
else
    for i=1:numNeurons
        w_intput(i,1).N=(b-a).*rand(numOfFeatures,1)+a;
    end
    for i=1:numHiddenLayers-1
        for j=1:numNeurons
            w_hidden(i,j).N=(b-a).*rand(numNeurons,1)+a;
        end
    end
    for j=1:numNeurons
        w_hidden(numHiddenLayers,j).N=(b-a).*rand(numOfClasses,1)+a;
    end
end
%% train
i_epoch=1;
epochs=zeros(numEpochs,1);
mseOutput=zeros(numEpochs,1);
[ training_features ] = MeanNormalization( training_features );
[ testing_features ] = MeanNormalization( testing_features );
if SC==3
    xlength=0.20*trainingLen;
    [r,c]=size(training_features);
   % msize = numel(training_features);
    idx = randperm(r);
    validation=training_features(idx(1:xlength),:);
    t=zeros(1,c);
    for i=1:r
        if ~ismember(i,idx(1:xlength))
            t=vertcat(t,training_features(i,:));
        end
    end
    trainingLen=trainingLen-xlength;
    training_features=t(2:trainingLen+1,:);
    final_winput=1;
    final_whidden=1;
    testeach=50;
    epochCounter=fix ( numEpochs/50);  
    crossValidationEpochs=zeros(epochCounter,1);
    mseArr=zeros(epochCounter+1,1);
    mseArr(1,1)=realmax;
end
%{
    'w_intput'
    for i=1:numNeurons
        w_intput(i,1).N
    end
    'w_hidden'
    for i=1:numHiddenLayers-1
        for j=1:numNeurons+BiasOrNot
            w_hidden(i,j).N
        end
    end
    'w_output'
    for j=1:numNeurons+BiasOrNot
        w_hidden(numHiddenLayers,j).N
    end
%}
while (numEpochs~=0)
mse_sum=0;
for i=1:trainingLen
    features=training_features(i,:).';
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
        if(i>=actualTrain(classInd,1)&&i<=actualTrain(classInd,2))
            desired(classInd,1)=1;
            break;
        end
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %calculate error
    %output error
    if AF==1  %sigmoid
        sigma_o=(desired-y_o).*y_o.*(1-y_o);
    else      %hyper_tangent
        sigma_o=(desired-y_o).*(1+y_o).*(1-y_o);
    end
    %hidden error
    e=sigma_o;
    neuronsCounter=numNeurons;
    if (BiasOrNot==1)
        neuronsCounter=neuronsCounter+1;
    end
    sigma_h=zeros(neuronsCounter,numHiddenLayers);
    for h=numHiddenLayers:-1:1 
        if BiasOrNot==1,y=vertcat(bias,y_h(:,h));else y=y_h(:,h);end
        if AF==1  %sigmoid
           sigma_h(:,h)=y.*(1-y);
        else      %hyper_tangent
           sigma_h(:,h)= (1+y).*(1-y);
        end
        for n=1:neuronsCounter
             sigma_h(n,h)=sigma_h(n,h)*sum( (w_hidden(h,n).N) .*e);
        end
        if(BiasOrNot==1),e=sigma_h(2:numNeurons+1,h);else e=sigma_h(:,h); end
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %update weights input to hidden
    x=features;
    featuresCounter=numOfFeatures;
    neuronsCounter=numNeurons;
    start_ind=0;
    if(BiasOrNot==1)
        featuresCounter=featuresCounter+1;
        start_ind=1;
    end
    %%fee hna moshkl
    %from input to hidden 
    for n=1:neuronsCounter
        w_intput(n,1).N=w_intput(n,1).N+( eta*x*sigma_h(n+start_ind,1) );         
    end
    %from hidden to hidden
    neuronsCounter=numNeurons;
    start_ind=0;
    if(BiasOrNot==1)
        neuronsCounter=neuronsCounter+1;
        start_ind=1;
    end
    for h=1:numHiddenLayers-1
        y=vertcat(bias,y_h(:,h));
        for n=1:neuronsCounter            
            for to_n=1:numNeurons
                w_hidden(h,n).N(to_n)=w_hidden(h,n).N(to_n)+ ( eta*y(n,1)*sigma_h(n,h+1) );
            end
        end
    end
    %update weights hidden to output
    y=vertcat(bias,y_h(:,numHiddenLayers));
    for n=1:neuronsCounter
        for ol=1:numOfClasses
            w_hidden(numHiddenLayers,n).N(ol)=w_hidden(numHiddenLayers,n).N(ol)+ (eta*y(n,1)*sigma_o(ol,1));
        end
    end
    mse_sum=mse_sum+(sum(sigma_o.^2)/numOfClasses);
end

if (SC==3&&rem(i_epoch,testeach)==0)
    %test the validation
    i_epoch
    currind=i_epoch/testeach;
    crossValidationEpochs(currind,1)=i_epoch;
    [ mseArr(currind+1,1) ] = testValidation( validation,xlength,idx(1:xlength),w_intput,w_hidden,actualTrain,BiasOrNot,numNeurons,numHiddenLayers,numOfClasses,AF );
    if mseArr(currind+1,1)<mseArr(currind,1)
        final_winput=w_intput;
        final_whidden=w_hidden;
    else
        break;
    end
end
numEpochs=numEpochs-1;
MSE=(1/(2*trainingLen))*mse_sum;
epochs(i_epoch,1)=i_epoch;
mseOutput(i_epoch,1)=MSE;
i_epoch=i_epoch+1;

if(SC==2)
    %stop by mse
    if(MSE <= mseThreshold)
        break;
    end
end
end
%{
    'w_intput'
    for i=1:numNeurons
        w_intput(i,1).N
    end
    'w_hidden'
    for i=1:numHiddenLayers-1
        for j=1:numNeurons+BiasOrNot
            w_hidden(i,j).N
        end
    end
    'w_output'
    for j=1:numNeurons+BiasOrNot
        w_hidden(numHiddenLayers,j).N
    end
%}
if SC==3
    w_intput=final_winput;
    w_hidden=final_whidden;
    epochs=crossValidationEpochs;
    mseOutput=mseArr(2:epochCounter+1,:);
end
figure('Name','learningcurve'),plot(epochs,mseOutput);

%% testing
confmat=zeros(numOfClasses,numOfClasses);
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
    %dbstop if error
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
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    for classInd=1:5
        if (i>=actualTest(classInd,1) && i<=actualTest(classInd,2) )
            confmat(classInd,max_ind)=confmat(classInd,max_ind)+1;
            break;
        end
    end
end
confmat
accuracy=(sum(diag(confmat))/testingLen)*100
end




