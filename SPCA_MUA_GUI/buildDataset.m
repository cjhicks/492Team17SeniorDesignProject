function varargout = buildDataset(varargin)
% BUILDDATASET MATLAB code for buildDataset.fig
%      BUILDDATASET, by itself, creates a new BUILDDATASET or raises the existing
%      singleton*.
%
%      H = BUILDDATASET returns the handle to a new BUILDDATASET or the handle to
%      the existing singleton*.
%
%      BUILDDATASET('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BUILDDATASET.M with the given input arguments.
%
%      BUILDDATASET('Property','Value',...) creates a new BUILDDATASET or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before buildDataset_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to buildDataset_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help buildDataset

% Last Modified by GUIDE v2.5 08-Sep-2013 12:20:09

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @buildDataset_OpeningFcn, ...
                   'gui_OutputFcn',  @buildDataset_OutputFcn, ...
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


% --- Executes just before buildDataset is made visible.
function buildDataset_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to buildDataset (see VARARGIN)

% Choose default command line output for buildDataset
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes buildDataset wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = buildDataset_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in inputFileListBox.
function inputFileListBox_Callback(hObject, eventdata, handles)
% hObject    handle to inputFileListBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns inputFileListBox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from inputFileListBox


% --- Executes during object creation, after setting all properties.
function inputFileListBox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to inputFileListBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in selectInputFilesBtn.
function selectInputFilesBtn_Callback(hObject, eventdata, handles)
% hObject    handle to selectInputFilesBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function numberOfConditionsText_Callback(hObject, eventdata, handles)
% hObject    handle to numberOfConditionsText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of numberOfConditionsText as text
%        str2double(get(hObject,'String')) returns contents of numberOfConditionsText as a double


% --- Executes during object creation, after setting all properties.
function numberOfConditionsText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to numberOfConditionsText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function numberOfSubjectsText_Callback(hObject, eventdata, handles)
% hObject    handle to numberOfSubjectsText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of numberOfSubjectsText as text
%        str2double(get(hObject,'String')) returns contents of numberOfSubjectsText as a double


% --- Executes during object creation, after setting all properties.
function numberOfSubjectsText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to numberOfSubjectsText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function sampleRateText_Callback(hObject, eventdata, handles)
% hObject    handle to sampleRateText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sampleRateText as text
%        str2double(get(hObject,'String')) returns contents of sampleRateText as a double


% --- Executes during object creation, after setting all properties.
function sampleRateText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sampleRateText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function baselineText_Callback(hObject, eventdata, handles)
% hObject    handle to baselineText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of baselineText as text
%        str2double(get(hObject,'String')) returns contents of baselineText as a double


% --- Executes during object creation, after setting all properties.
function baselineText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to baselineText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in selectElectrodeFileButton.
function selectElectrodeFileButton_Callback(hObject, eventdata, handles)
% hObject    handle to selectElectrodeFileButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in selectOutputFileButton.
function selectOutputFileButton_Callback(hObject, eventdata, handles)
% hObject    handle to selectOutputFileButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function outputFileText_Callback(hObject, eventdata, handles)
% hObject    handle to outputFileText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of outputFileText as text
%        str2double(get(hObject,'String')) returns contents of outputFileText as a double


% --- Executes during object creation, after setting all properties.
function outputFileText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to outputFileText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ElectrodeFileText_Callback(hObject, eventdata, handles)
% hObject    handle to ElectrodeFileText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ElectrodeFileText as text
%        str2double(get(hObject,'String')) returns contents of ElectrodeFileText as a double


% --- Executes during object creation, after setting all properties.
function ElectrodeFileText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ElectrodeFileText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in BuildButton.
function BuildButton_Callback(hObject, eventdata, handles)
% hObject    handle to BuildButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
