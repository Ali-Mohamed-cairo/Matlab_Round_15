function varargout = Non_Return_To_Zero_GUI(varargin)
% NON_RETURN_TO_ZERO_GUI MATLAB code for Non_Return_To_Zero_GUI.fig
%      NON_RETURN_TO_ZERO_GUI, by itself, creates a new NON_RETURN_TO_ZERO_GUI or raises the existing
%      singleton*.
%
%      H = NON_RETURN_TO_ZERO_GUI returns the handle to a new NON_RETURN_TO_ZERO_GUI or the handle to
%      the existing singleton*.
%
%      NON_RETURN_TO_ZERO_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in NON_RETURN_TO_ZERO_GUI.M with the given input arguments.
%
%      NON_RETURN_TO_ZERO_GUI('Property','Value',...) creates a new NON_RETURN_TO_ZERO_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Non_Return_To_Zero_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Non_Return_To_Zero_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Import "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Non_Return_To_Zero_GUI

% Last Modified by GUIDE v2.5 23-Aug-2023 13:59:36

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Non_Return_To_Zero_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @Non_Return_To_Zero_GUI_OutputFcn, ...
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

function StartConditions(handles)
set(handles.Applycheck, 'value', 0);
set(handles.Applycheck, 'enable', 'off');
set(handles.Exportcheck, 'value', 0);
set(handles.Exportcheck, 'enable', 'off');

function filename = OpenFile(handles, state)
[filename, path] = uigetfile();
if state
    set(handles.InputFileName, 'string', filename);
else
   set(handles.OutputFileName, 'string', filename); 
end
filename = strcat(path, filename);

function Finishing()
global Stream;
while true
    if(mod(length(Stream), 32) ~= 0)
        Stream = [Stream; 0];
    else
        break;
    end
end



function Non_Return_To_Zero()
global Stream;
StartByte = [0; 0; 0; 0; 0; 0; 0; 1];
Stream = [StartByte; Stream];
Stream(length(StartByte) + 1) = xor(Stream(length(StartByte) + 1), 1);
OnesCounter = 1;
PacketDetector = 8;
for i =  length(StartByte) + 1 : length(Stream) - 1
    PacketDetector = PacketDetector + 1;
    if( Stream(i) == 0)
      Stream(i + 1) = xor(Stream(i + 1) , 1);
    end
    if( Stream(i) == 1)
        OnesCounter = OnesCounter + 1;
    else
        OnesCounter = 0;
    end
    if( OnesCounter == 5)
        Stream = [Stream(1:i); 0; Stream(i + 1 :end)];
        OnesCounter = 0; 
    end
    if(PacketDetector == 32)
         Stream = [Stream(1:i); 0; 0; 0; Stream(i + 1 :end)];
         PacketDetector = 0;
    end
end
Finishing();




% --- Executes just before Non_Return_To_Zero_GUI is made visible.
function Non_Return_To_Zero_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Non_Return_To_Zero_GUI (see VARARGIN)

% Import default command line output for Non_Return_To_Zero_GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);



Begin = axes('unit','normalized','position',[0 0 1 1]);
image1 = imread('MilkWay.jpeg');
imagesc(image1);

StartConditions(handles);


% UIWAIT makes Non_Return_To_Zero_GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Non_Return_To_Zero_GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Import.
function Import_Callback(hObject, eventdata, handles)
% hObject    handle to Import (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Stream;
StartConditions(handles);
filename = OpenFile(handles, 1);
fileID = fopen(filename);
Stream = fscanf(fileID, '%d');


function InputFileName_Callback(hObject, eventdata, handles)
% hObject    handle to InputFileName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of InputFileName as text
%        str2double(get(hObject,'String')) returns contents of InputFileName as a double


% --- Executes during object creation, after setting all properties.
function InputFileName_CreateFcn(hObject, eventdata, handles)
% hObject    handle to InputFileName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in ApplyProtocol.
function ApplyProtocol_Callback(hObject, eventdata, handles)
% hObject    handle to ApplyProtocol (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Non_Return_To_Zero();
set(handles.Applycheck, 'value', 1);
set(handles.Applycheck, 'enable', 'on');

% --- Executes on button press in Export.
function Export_Callback(hObject, eventdata, handles)
% hObject    handle to Export (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Stream;
filename = OpenFile(handles, 0);
fileID = fopen(filename, 'w');
fprintf(fileID, '%d', Stream);
set(handles.Exportcheck, 'value', 1);
set(handles.Exportcheck, 'enable', 'on');

function OutputFileName_Callback(hObject, eventdata, handles)
% hObject    handle to OutputFileName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of OutputFileName as text
%        str2double(get(hObject,'String')) returns contents of OutputFileName as a double


% --- Executes during object creation, after setting all properties.
function OutputFileName_CreateFcn(hObject, eventdata, handles)
% hObject    handle to OutputFileName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Applycheck.
function Applycheck_Callback(hObject, eventdata, handles)
% hObject    handle to Applycheck (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Applycheck


% --- Executes on button press in Exportcheck.
function Exportcheck_Callback(hObject, eventdata, handles)
% hObject    handle to Exportcheck (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Exportcheck
