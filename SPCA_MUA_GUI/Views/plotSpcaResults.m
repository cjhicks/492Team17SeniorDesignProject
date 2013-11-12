function varargout = plotSpcaResults(varargin)
% PLOTSPCARESULTS MATLAB code for plotSpcaResults.fig
%      PLOTSPCARESULTS, by itself, creates a new PLOTSPCARESULTS or raises the existing
%      singleton*.
%
%      H = PLOTSPCARESULTS returns the handle to a new PLOTSPCARESULTS or the handle to
%      the existing singleton*.
%
%      PLOTSPCARESULTS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PLOTSPCARESULTS.M with the given input arguments.
%
%      PLOTSPCARESULTS('Property','Value',...) creates a new PLOTSPCARESULTS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before plotSpcaResults_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to plotSpcaResults_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help plotSpcaResults

% Last Modified by GUIDE v2.5 02-Nov-2013 13:28:25

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @plotSpcaResults_OpeningFcn, ...
                   'gui_OutputFcn',  @plotSpcaResults_OutputFcn, ...
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


% --- Executes just before plotSpcaResults is made visible.
function plotSpcaResults_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to plotSpcaResults (see VARARGIN)

% Choose default command line output for plotSpcaResults
handles.output = hObject;

%get handle to the presenter
for i = 1:2:length(varargin)
    switch varargin{i}
        case 'presenter'
            handles.presenter = varargin{i+1};
        otherwise
            error('unknown input')
    end
end

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes plotSpcaResults wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = plotSpcaResults_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in RawResults_Button.
function RawResults_Button_Callback(hObject, eventdata, handles)
% hObject    handle to RawResults_Button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.presenter.doPlotSPCAResults('Raw');


% --- Executes on button press in PromaxRotation_Button.
function PromaxRotation_Button_Callback(hObject, eventdata, handles)
% hObject    handle to PromaxRotation_Button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.presenter.doPlotSPCAResults('Promax');


% --- Executes on button press in VarimaxRotation_Button.
function VarimaxRotation_Button_Callback(hObject, eventdata, handles)
% hObject    handle to VarimaxRotation_Button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.presenter.doPlotSPCAResults('Varimax');


% --- Executes on selection change in InputFile_Text.
function InputFile_Text_Callback(hObject, eventdata, handles)
% hObject    handle to InputFile_Text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns InputFile_Text contents as cell array
%        contents{get(hObject,'Value')} returns selected item from InputFile_Text


% --- Executes during object creation, after setting all properties.
function InputFile_Text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to InputFile_Text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Select_Button.
function Select_Button_Callback(hObject, eventdata, handles)
% hObject    handle to Select_Button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.presenter.SelectSPCAResults();

