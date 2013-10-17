function varargout = runMua(varargin)
% RUNMUA MATLAB code for runMua.fig
%      RUNMUA, by itself, creates a new RUNMUA or raises the existing
%      singleton*.
%
%      H = RUNMUA returns the handle to a new RUNMUA or the handle to
%      the existing singleton*.
%
%      RUNMUA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RUNMUA.M with the given input arguments.
%
%      RUNMUA('Property','Value',...) creates a new RUNMUA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before runMua_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to runMua_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help runMua

% Last Modified by GUIDE v2.5 17-Oct-2013 11:20:50

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @runMua_OpeningFcn, ...
                   'gui_OutputFcn',  @runMua_OutputFcn, ...
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


% --- Executes just before runMua is made visible.
function runMua_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to runMua (see VARARGIN)

% Choose default command line output for runMua
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes runMua wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = runMua_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in InputFile_ListBox.
function InputFile_ListBox_Callback(hObject, eventdata, handles)
% hObject    handle to InputFile_ListBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns InputFile_ListBox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from InputFile_ListBox


% --- Executes during object creation, after setting all properties.
function InputFile_ListBox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to InputFile_ListBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in selectFile_Button.
function selectFile_Button_Callback(hObject, eventdata, handles)
% hObject    handle to selectFile_Button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function NumSubjectIV_Input_Callback(hObject, eventdata, handles)
% hObject    handle to NumSubjectIV_Input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of NumSubjectIV_Input as text
%        str2double(get(hObject,'String')) returns contents of NumSubjectIV_Input as a double


% --- Executes during object creation, after setting all properties.
function NumSubjectIV_Input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NumSubjectIV_Input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function IV1Label_Input_Callback(hObject, eventdata, handles)
% hObject    handle to IV1Label_Input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of IV1Label_Input as text
%        str2double(get(hObject,'String')) returns contents of IV1Label_Input as a double


% --- Executes during object creation, after setting all properties.
function IV1Label_Input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to IV1Label_Input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function IV1Level_Input_Callback(hObject, eventdata, handles)
% hObject    handle to IV1Level_Input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of IV1Level_Input as text
%        str2double(get(hObject,'String')) returns contents of IV1Level_Input as a double


% --- Executes during object creation, after setting all properties.
function IV1Level_Input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to IV1Level_Input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function IV2Label_Input_Callback(hObject, eventdata, handles)
% hObject    handle to IV2Label_Input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of IV2Label_Input as text
%        str2double(get(hObject,'String')) returns contents of IV2Label_Input as a double


% --- Executes during object creation, after setting all properties.
function IV2Label_Input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to IV2Label_Input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function IV2Level_Input_Callback(hObject, eventdata, handles)
% hObject    handle to IV2Level_Input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of IV2Level_Input as text
%        str2double(get(hObject,'String')) returns contents of IV2Level_Input as a double


% --- Executes during object creation, after setting all properties.
function IV2Level_Input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to IV2Level_Input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function FDR_Input_Callback(hObject, eventdata, handles)
% hObject    handle to FDR_Input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of FDR_Input as text
%        str2double(get(hObject,'String')) returns contents of FDR_Input as a double


% --- Executes during object creation, after setting all properties.
function FDR_Input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FDR_Input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Threshold_Input_Callback(hObject, eventdata, handles)
% hObject    handle to Threshold_Input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Threshold_Input as text
%        str2double(get(hObject,'String')) returns contents of Threshold_Input as a double


% --- Executes during object creation, after setting all properties.
function Threshold_Input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Threshold_Input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Run_button.
function Run_button_Callback(hObject, eventdata, handles)
% hObject    handle to Run_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
