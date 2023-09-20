function varargout = cosine(varargin)
% COSINE MATLAB code for cosine.fig
%      COSINE, by itself, creates a new COSINE or raises the existing
%      singleton*.
%
%      H = COSINE returns the handle to a new COSINE or the handle to
%      the existing singleton*.
%
%      COSINE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in COSINE.M with the given input arguments.
%
%      COSINE('Property','Value',...) creates a new COSINE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before cosine_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to cosine_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help cosine

% Last Modified by GUIDE v2.5 02-Aug-2023 07:55:47

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @cosine_OpeningFcn, ...
                   'gui_OutputFcn',  @cosine_OutputFcn, ...
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


% --- Executes just before cosine is made visible.
function cosine_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to cosine (see VARARGIN)

% Choose default command line output for cosine
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes cosine wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = cosine_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function freq_Callback(hObject, eventdata, handles)
% hObject    handle to freq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of freq as text
%        str2double(get(hObject,'String')) returns contents of freq as a double


% --- Executes during object creation, after setting all properties.
function freq_CreateFcn(hObject, eventdata, handles)
% hObject    handle to freq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in plotcosine.
function plotcosine_Callback(hObject, eventdata, handles)
% hObject    handle to plotcosine (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
f = get(handles.freq, 'string');
f = str2double(f);
t = t_from_f_getter(f);
x = cos(2 * pi * f * t);
axes(handles.axes1);
hold on
plot(t,x, 'r');





% --- Executes on button press in plotsine.
function plotsine_Callback(hObject, eventdata, handles)
% hObject    handle to plotsine (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
f = get(handles.freq, 'string');
f = str2double(f);
t = t_from_f_getter(f);
y = sin(2 * pi * f * t);
plot(t,y, 'b');
legend('cos','sin')
