function varargout = guiRun(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @guiRun_OpeningFcn, ...
                   'gui_OutputFcn',  @guiRun_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
end
function guiRun_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
% Update handles structure
guidata(hObject, handles);
end
function varargout = guiRun_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;
end

%%%code%%
function openImage_Callback(hObject, eventdata, handles)
[handles.filename,user_canceled] = imgetfile;
if user_canceled==false
handles.Image1 = imread(handles.filename);
guidata(hObject, handles);
axes(handles.axes1);
imshow(handles.Image1);
end
end

function btnRecognizeObjects_Callback(hObject, eventdata, handles)
axes(handles.axes1);
cla reset
imshow(handles.Image1);
if (isequal(get(handles.rdbtn1, 'Value'),1 ))
    handles.methodFClassify=1;%%MLP
elseif (isequal(get(handles.rdbtn2, 'Value'),1 ))
    handles.methodFClassify=2;%%RBF
end
AF=get(handles.pum_AF,'Value');
SC=get(handles.pum_SC,'Value');
bias = handles.checkbox1.Value;
learnRate = str2num(handles.eta.String);
numOfEpochs = str2num(handles.numEpochs.String);
numOfHiddenLayers = str2num(handles.numHiddenLayers.String);
numOfNeurons = str2num(handles.numNeurons.String);
mse = str2num(handles.mseThreshold.String);
%AF,SC,bias,learnRate,numOfEpochs ,numOfHiddenLayers,numOfNeurons,mse 
rbf_epochs=str2num(handles.rbf_epochs.String);
rbf_eta=str2num(handles.rbf_eta.String);
rbf_hiddenneurons=str2num(handles.rbf_hiddenneurons.String);
rbf_msethreshold=str2num(handles.rbf_msethreshold.String);
%rbf_epochs,rbf_eta,rbf_hiddenneurons,rbf_msethreshold
classifyObjects( handles,handles.Image1,handles.filename,handles.methodFClassify,AF,SC,bias,learnRate,numOfEpochs ,numOfHiddenLayers,numOfNeurons,mse,rbf_epochs,rbf_eta,rbf_hiddenneurons,rbf_msethreshold);
guidata(hObject, handles);
end

function rdbtn1_Callback(hObject, eventdata, handles)
set(handles.rdbtn2, 'Value', 0);
end
function rdbtn2_Callback(hObject, eventdata, handles)
set(handles.rdbtn1, 'Value', 0);
end
