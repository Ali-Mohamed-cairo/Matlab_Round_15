function varargout = audiogui(varargin)
% AUDIOGUI MATLAB code for audiogui.fig
%      AUDIOGUI, by itself, creates a new AUDIOGUI or raises the existing
%      singleton*.
%
%      H = AUDIOGUI returns the handle to a new AUDIOGUI or the handle to
%      the existing singleton*.
%
%      AUDIOGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in AUDIOGUI.M with the given input arguments.
%
%      AUDIOGUI('Property','Value',...) creates a new AUDIOGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before audiogui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to audiogui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help audiogui

% Last Modified by GUIDE v2.5 02-Aug-2023 13:17:45

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @audiogui_OpeningFcn, ...
                   'gui_OutputFcn',  @audiogui_OutputFcn, ...
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
% End initialization code - DO NOT EDIT

function disable(handles)
set(handles.orgaud, 'enable', 'off');
set(handles.enc, 'enable', 'off');
function stopr(handles)
set(handles.orgradio, 'value', 0);
set(handles.encradio, 'value', 0);


% --- Executes just before audiogui is made visible.
function audiogui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to audiogui (see VARARGIN)

% Choose default command line output for audiogui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes audiogui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = audiogui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in orgaud.
function orgaud_Callback(hObject, eventdata, handles)
% hObject    handle to orgaud (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global k;
h = get(hObject,'Value');
switch h
    case 2
        play(k);
    case 3
        pause(k);
    case 4
        resume(k);
    case 5
        stop(k);
    otherwise
end
% Hints: contents = cellstr(get(hObject,'String')) returns orgaud contents as cell array
%        contents{get(hObject,'Value')} returns selected item from orgaud


% --- Executes during object creation, after setting all properties.
function orgaud_CreateFcn(hObject, eventdata, handles)
% hObject    handle to orgaud (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton.
function pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global k en;
[filename, pathname] = uigetfile();
filename = strcat(pathname, filename);
[y, fs]=audioread(filename);
k = audioplayer(y, fs);
en = audioplayer(y, 2*fs);

% --- Executes on selection change in enc.
function enc_Callback(hObject, eventdata, handles)
% hObject    handle to enc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global en;
h = get(hObject,'Value');
switch h
    case 2
        play(en);
    case 3
        pause(en);
    case 4
        resume(en);
    case 5
        stop(en);
    otherwise
end

% Hints: contents = cellstr(get(hObject,'String')) returns enc contents as cell array
%        contents{get(hObject,'Value')} returns selected item from enc


% --- Executes during object creation, after setting all properties.
function enc_CreateFcn(hObject, eventdata, handles)
% hObject    handle to enc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in orgradio.
function orgradio_Callback(hObject, eventdata, handles)
% hObject    handle to orgradio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
disable(handles);
stopr(handles);
set(handles.orgradio, 'value', 1);
set(handles.orgaud, 'enable', 'on');
% Hint: get(hObject,'Value') returns toggle state of orgradio


% --- Executes on button press in encradio.
function encradio_Callback(hObject, eventdata, handles)
% hObject    handle to encradio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
disable(handles);
stopr(handles);
set(handles.encradio, 'value', 1);
set(handles.enc, 'enable', 'on');
% Hint: get(hObject,'Value') returns toggle state of encradio
