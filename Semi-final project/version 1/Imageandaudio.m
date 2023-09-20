function varargout = Imageandaudio(varargin)
% IMAGEANDAUDIO MATLAB code for Imageandaudio.fig
%      IMAGEANDAUDIO, by itself, creates a new IMAGEANDAUDIO or raises the existing
%      singleton*.
%
%      H = IMAGEANDAUDIO returns the handle to a new IMAGEANDAUDIO or the handle to
%      the existing singleton*.
%
%      IMAGEANDAUDIO('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in IMAGEANDAUDIO.M with the given input arguments.
%
%      IMAGEANDAUDIO('Property','Value',...) creates a new IMAGEANDAUDIO or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Imageandaudio_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Imageandaudio_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Imageandaudio

% Last Modified by GUIDE v2.5 05-Aug-2023 12:17:39

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Imageandaudio_OpeningFcn, ...
                   'gui_OutputFcn',  @Imageandaudio_OutputFcn, ...
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

function audio_begin(handles)
set(handles.poporg, 'enable', 'off');
set(handles.popenc, 'enable', 'off');
set(handles.radiorg, 'value', 0);
set(handles.radioenc, 'value', 0);

function radio_enc(handles)
set(handles.poporg, 'enable', 'off');
set(handles.radiorg, 'value', 0);
set(handles.popenc, 'enable', 'on');
set(handles.radioenc, 'value', 1);


function radi_org(handles)
set(handles.poporg, 'enable', 'on');
set(handles.radiorg, 'value', 1);
set(handles.popenc, 'enable', 'off');
set(handles.radioenc, 'value', 0);



function filename = File_Opener(handles, audio)
[filename, pathname] = uigetfile();
if audio
    set(handles.audioname, 'string', filename);
end
filename = strcat(pathname, filename);





% --- Executes just before Imageandaudio is made visible.
function Imageandaudio_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Imageandaudio (see VARARGIN)

% Choose default command line output for Imageandaudio
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Imageandaudio wait for user response (see UIRESUME)
% uiwait(handles.figure1);
audio_begin(handles);


% --- Outputs from this function are returned to the command line.
function varargout = Imageandaudio_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushaudio.
function pushaudio_Callback(hObject, eventdata, handles)
% hObject    handle to pushaudio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global y_org fs audio;
stop(audio);
audio_begin(handles);
audio_filename = File_Opener(handles, 1);
[y_org, fs] = audioread(audio_filename);


% --- Executes on button press in radiorg.
function radiorg_Callback(hObject, eventdata, handles)
% hObject    handle to radiorg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiorg
global y_org  fs audio;
radi_org(handles);
audio = audioplayer(y_org, fs);


% --- Executes on button press in radioenc.
function radioenc_Callback(hObject, eventdata, handles)
% hObject    handle to radioenc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radioenc
global y_org fs audio;
radio_enc(handles);
y_enc = y_org(:,1) + y_org(:,2);
y_enc = 0.5 * y_enc + randn(length(y_enc), 1);
audio = audioplayer(y_enc, fs);


% --- Executes on selection change in poporg.
function poporg_Callback(hObject, eventdata, handles)
% hObject    handle to poporg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns poporg contents as cell array
%        contents{get(hObject,'Value')} returns selected item from poporg
global audio;
choise = get(hObject, 'Value');
switch choise
    case 2
        play(audio);
    case 3
        pause(audio);
    case 4
        resume(audio);
    case 5
        stop(audio);
    otherwise
end

% --- Executes during object creation, after setting all properties.
function poporg_CreateFcn(hObject, eventdata, handles)
% hObject    handle to poporg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popenc.
function popenc_Callback(hObject, eventdata, handles)
% hObject    handle to popenc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popenc contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popenc
global audio;
choise = get(hObject, 'Value');
switch choise
    case 2
        play(audio);
    case 3
        pause(audio);
    case 4
        resume(audio);
    case 5
        stop(audio);
    otherwise
end

% --- Executes during object creation, after setting all properties.
function popenc_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popenc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushimage.
function pushimage_Callback(hObject, eventdata, handles)
% hObject    handle to pushimage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global img_org;
image_filename = File_Opener(handles, 0);
img_org = imread(image_filename);


% --- Executes on button press in pushorg.
function pushorg_Callback(hObject, eventdata, handles)
% hObject    handle to pushorg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global img_org;
axes(handles.axes4)
imshow(img_org);    

% --- Executes on button press in pushgrayscale.
function pushgrayscale_Callback(hObject, eventdata, handles)
% hObject    handle to pushgrayscale (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global img_org;
img_gray = rgb2gray(img_org);
axes(handles.axes5)
imshow(img_gray);

% --- Executes on button press in pushencrypted.
function pushencrypted_Callback(hObject, eventdata, handles)
% hObject    handle to pushencrypted (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global img_org;
img_enc = imnoise(img_org, 'gaussian', 0.1, 0.5);
axes(handles.axes6)
imshow(img_enc);


% --- Executes on button press in pushist.
function pushist_Callback(hObject, eventdata, handles)
% hObject    handle to pushist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global img_org;
img_gray = rgb2gray(img_org);
axes(handles.axes7)
imhist(img_gray);



function audioname_Callback(hObject, eventdata, handles)
% hObject    handle to audioname (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of audioname as text
%        str2double(get(hObject,'String')) returns contents of audioname as a double


% --- Executes during object creation, after setting all properties.
function audioname_CreateFcn(hObject, eventdata, handles)
% hObject    handle to audioname (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
