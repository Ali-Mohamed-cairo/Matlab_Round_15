function varargout = imageandaudio2(varargin)
% IMAGEANDAUDIO2 MATLAB code for imageandaudio2.fig
%      IMAGEANDAUDIO2, by itself, creates a new IMAGEANDAUDIO2 or raises the existing
%      singleton*.
%
%      H = IMAGEANDAUDIO2 returns the handle to a new IMAGEANDAUDIO2 or the handle to
%      the existing singleton*.
%
%      IMAGEANDAUDIO2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in IMAGEANDAUDIO2.M with the given input arguments.
%
%      IMAGEANDAUDIO2('Property','Value',...) creates a new IMAGEANDAUDIO2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before imageandaudio2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to imageandaudio2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help imageandaudio2

% Last Modified by GUIDE v2.5 10-Aug-2023 08:51:19

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @imageandaudio2_OpeningFcn, ...
                   'gui_OutputFcn',  @imageandaudio2_OutputFcn, ...
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

function startscreen(handles)
global img_org;
set(handles.imagepanel, 'visible', 'off');
set(handles.audiopanel, 'visible', 'off');
set(handles.backtomain, 'visible', 'off');
audio_begin(handles);
img_org = 0;


function audio_begin(handles)
global audio;
set(handles.poporg, 'enable', 'off');
set(handles.popenc, 'enable', 'off');
set(handles.radiorg, 'value', 0);
set(handles.radioenc, 'value', 0);
audio = audioplayer(0, 80);
stop(audio);

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



function filename = File_Opener(handles, image)
[filename, pathname] = uigetfile();
if image
    set(handles.imagename, 'string', filename);
else
    set(handles.audioname, 'string', filename);
end
filename = strcat(pathname, filename);

% --- Executes just before imageandaudio2 is made visible.
function imageandaudio2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to imageandaudio2 (see VARARGIN)

% Choose default command line output for imageandaudio2
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
ad = axes('unit','normalized','position',[0 0 1 1]);
image1 = imread('spacex.jpg');
imagesc(image1);
startscreen(handles);
% UIWAIT makes imageandaudio2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = imageandaudio2_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



% --- Executes on button press in Imagestart.
function Imagestart_Callback(hObject, eventdata, handles)
% hObject    handle to Imagestart (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.imagepanel, 'visible', 'on');
set(handles.backtomain, 'visible', 'on');
set(handles.axes1, 'visible', 'off');
set(handles.axes2, 'visible', 'off');
set(handles.axes3, 'visible', 'off');
set(handles.axes4, 'visible', 'off');

% --- Executes on button press in Audiostart.
function Audiostart_Callback(hObject, eventdata, handles)
% hObject    handle to Audiostart (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.audiopanel, 'visible', 'on');
set(handles.backtomain, 'visible', 'on');



% --- Executes during object creation, after setting all properties.
function MainText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MainText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function imagepanel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to imagepanel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in pushimage.
function pushimage_Callback(hObject, eventdata, handles)
% hObject    handle to pushimage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global img_org;
image_filename = File_Opener(handles, 1);
img_org = imread(image_filename);

% --- Executes on button press in pushoriginalimg.
function pushoriginalimg_Callback(hObject, eventdata, handles)
% hObject    handle to pushoriginalimg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global img_org;
set(handles.axes1text, 'visible', 'off');
set(handles.axes1, 'visible', 'on');
axes(handles.axes1)
imshow(img_org);

% --- Executes on button press in pushgray.
function pushgray_Callback(hObject, eventdata, handles)
% hObject    handle to pushgray (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global img_org;
set(handles.axes2text, 'visible', 'off');
set(handles.axes2, 'visible', 'on');
img_gray = rgb2gray(img_org);
axes(handles.axes2)
imshow(img_gray);

% --- Executes on button press in pushencimg.
function pushencimg_Callback(hObject, eventdata, handles)
% hObject    handle to pushencimg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global img_org;
set(handles.axes3text, 'visible', 'off');
set(handles.axes3, 'visible', 'on');
img_enc = imnoise(img_org, 'gaussian', 0.1, 0.5);
axes(handles.axes3)
imshow(img_enc);

% --- Executes on button press in pushhist.
function pushhist_Callback(hObject, eventdata, handles)
% hObject    handle to pushhist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global img_org;
set(handles.axes4text, 'visible', 'off');
set(handles.axes4, 'visible', 'on');
img_gray = rgb2gray(img_org);
axes(handles.axes4)
imhist(img_gray);

% --- Executes on button press in backtomain.
function backtomain_Callback(hObject, eventdata, handles)
% hObject    handle to backtomain (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
startscreen(handles);



function imagename_Callback(hObject, eventdata, handles)
% hObject    handle to imagename (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of imagename as text
%        str2double(get(hObject,'String')) returns contents of imagename as a double


% --- Executes during object creation, after setting all properties.
function imagename_CreateFcn(hObject, eventdata, handles)
% hObject    handle to imagename (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function audiopanel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to audiopanel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% --- Executes on button press in pushaudio.
function pushaudio_Callback(hObject, eventdata, handles)
% hObject    handle to pushaudio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global y_org fs;
audio_begin(handles);
audio_filename = File_Opener(handles, 0);
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
% Hints: contents = cellstr(get(hObject,'String')) returns poporg contents as cell array
%        contents{get(hObject,'Value')} returns selected item from poporg


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

% Hints: contents = cellstr(get(hObject,'String')) returns popenc contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popenc


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
