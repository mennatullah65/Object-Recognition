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
% --- Executes just before guiRun is made visible.
function guiRun_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
% Update handles structure
guidata(hObject, handles);
end
% --- Outputs from this function are returned to the command line.
function varargout = guiRun_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;
end

%%%code%%
% --- Executes on button press in openImage.
function openImage_Callback(hObject, eventdata, handles)
[handles.filename,user_canceled] = imgetfile;
if user_canceled==false
handles.Image1 = imread(handles.filename);
guidata(hObject, handles);
axes(handles.axes1);
imshow(handles.Image1);
end
end

% --- Executes on button press in btnRecognizeObjects.
function btnRecognizeObjects_Callback(hObject, eventdata, handles)
handles.methodFeatures=get(handles.popupmenu1,'Value');
handles.methodFClassify=get(handles.popupmenu2,'Value');
axes(handles.axes2);
imshow(handles.Image1);
classifyObjects( handles.Image1,handles.filename,handles.methodFeatures,handles.methodFClassify);
guidata(hObject, handles);
end
