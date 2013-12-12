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

% Last Modified by GUIDE v2.5 12-Dec-2013 15:33:56

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


% --- Executes on selection change in InputFile_EditText.
function InputFile_EditText_Callback(hObject, eventdata, handles)
% hObject    handle to InputFile_EditText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns InputFile_EditText contents as cell array
%        contents{get(hObject,'Value')} returns selected item from InputFile_EditText




% --- Executes during object creation, after setting all properties.
function InputFile_EditText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to InputFile_EditText (see GCBO)
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

global inputDirName;
global inputDirPath;
global spcaResults;

% get input directory file
[inputDirName, inputDirPath] = uigetfile('.txt', 'Select the Input Directory File');
spcaResults = load(strcat(inputDirPath,inputDirName));

% update file name string
if(~isequal(inputDirName,0)) 
    handles = guidata(runMua);
    set(handles.InputFile_EditText, 'String', inputDirName);
   % dataset = doBuildDataset(inputDirPath, inputDirName);
end


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



function IV1Label_Edit_Callback(hObject, eventdata, handles)
% hObject    handle to IV1Label_Edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of IV1Label_Edit as text
%        str2double(get(hObject,'String')) returns contents of IV1Label_Edit as a double

global IV1Label;

IV1Label = get(hObject,'String');


% --- Executes during object creation, after setting all properties.
function IV1Label_Edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to IV1Label_Edit (see GCBO)
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



function IV2Label_Edit_Callback(hObject, eventdata, handles)
% hObject    handle to IV2Label_Edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of IV2Label_Edit as text
%        str2double(get(hObject,'String')) returns contents of IV2Label_Edit as a double

global IV2Label;

IV2Label = get(hObject,'String');

% --- Executes during object creation, after setting all properties.
function IV2Label_Edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to IV2Label_Edit (see GCBO)
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

global Threshold_Input;
Threshold_Input = str2double(get(hObject,'String'));


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

global pValueEditTextVar;
global spcaResults;
global Threshold_Input;

global IV_1_Level_1;
global IV_1_Level_2;
global IV_1_Level_3;

global IV_2_Level_1;
global IV_2_Level_2;

global IV1Label;
global IV2Label;

RunMUA3x2(spcaResults.STPCAresults,IV1Label,[IV_1_Level_1,IV_1_Level_2,IV_1_Level_3],IV2Label,[IV_2_Level_1,IV_2_Level_2],spcaResults.STPCAresults.chanlocs, 0, 0, spcaResults.STPCAresults.epochTotal - 1, spcaResults.STPCAresults.numberOfSpatialComponents,pValueEditTextVar, Threshold_Input);


function IV_1_Level_1_Label_Edit_Text_Callback(hObject, eventdata, handles)
% hObject    handle to IV_1_Level_1_Label_Edit_Text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of IV_1_Level_1_Label_Edit_Text as text
%        str2double(get(hObject,'String')) returns contents of IV_1_Level_1_Label_Edit_Text as a double

global IV_1_Level_1;

IV_1_Level_1 = get(hObject, 'String');


% --- Executes during object creation, after setting all properties.
function IV_1_Level_1_Label_Edit_Text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to IV_1_Level_1_Label_Edit_Text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function IV_1_Level_2_Label_Edit_Text_Callback(hObject, eventdata, handles)
% hObject    handle to IV_1_Level_2_Label_Edit_Text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of IV_1_Level_2_Label_Edit_Text as text
%        str2double(get(hObject,'String')) returns contents of IV_1_Level_2_Label_Edit_Text as a double


global IV_1_Level_2;

IV_1_Level_2 = get(hObject, 'String');


% --- Executes during object creation, after setting all properties.
function IV_1_Level_2_Label_Edit_Text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to IV_1_Level_2_Label_Edit_Text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function IV_1_Level_3_Label_Edit_Text_Callback(hObject, eventdata, handles)
% hObject    handle to IV_1_Level_3_Label_Edit_Text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of IV_1_Level_3_Label_Edit_Text as text
%        str2double(get(hObject,'String')) returns contents of IV_1_Level_3_Label_Edit_Text as a double


global IV_1_Level_3;

IV_1_Level_3 = get(hObject, 'String');

% --- Executes during object creation, after setting all properties.
function IV_1_Level_3_Label_Edit_Text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to IV_1_Level_3_Label_Edit_Text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function IV_2_Level_1_Label_Edit_Text_Callback(hObject, eventdata, handles)
% hObject    handle to IV_2_Level_1_Label_Edit_Text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of IV_2_Level_1_Label_Edit_Text as text
%        str2double(get(hObject,'String')) returns contents of IV_2_Level_1_Label_Edit_Text as a double

global IV_2_Level_1;

IV_2_Level_1 = get(hObject, 'String');


% --- Executes during object creation, after setting all properties.
function IV_2_Level_1_Label_Edit_Text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to IV_2_Level_1_Label_Edit_Text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function IV_2_Level_2_Label_Edit_Text_Callback(hObject, eventdata, handles)
% hObject    handle to IV_2_Level_2_Label_Edit_Text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of IV_2_Level_2_Label_Edit_Text as text
%        str2double(get(hObject,'String')) returns contents of IV_2_Level_2_Label_Edit_Text as a double

global IV_2_Level_2;

IV_2_Level_2 = get(hObject, 'String');

% --- Executes during object creation, after setting all properties.
function IV_2_Level_2_Label_Edit_Text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to IV_2_Level_2_Label_Edit_Text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function pValueEditText_Callback(hObject, eventdata, handles)
% hObject    handle to pValueEditText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of pValueEditText as text
%        str2double(get(hObject,'String')) returns contents of pValueEditText as a double

global pValueEditTextVar;

pValueEditTextVar = str2double(get(hObject, 'String'));

% --- Executes during object creation, after setting all properties.
function pValueEditText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pValueEditText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
