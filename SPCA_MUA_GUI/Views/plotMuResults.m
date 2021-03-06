function varargout = plotMuResults(varargin)
% PLOTMURESULTS MATLAB code for plotMuResults.fig
%      PLOTMURESULTS, by itself, creates a new PLOTMURESULTS or raises the existing
%      singleton*.
%
%      H = PLOTMURESULTS returns the handle to a new PLOTMURESULTS or the handle to
%      the existing singleton*.
%
%      PLOTMURESULTS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PLOTMURESULTS.M with the given input arguments.
%
%      PLOTMURESULTS('Property','Value',...) creates a new PLOTMURESULTS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before plotMuResults_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to plotMuResults_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help plotMuResults

% Last Modified by GUIDE v2.5 24-Oct-2013 10:40:03

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @plotMuResults_OpeningFcn, ...
                   'gui_OutputFcn',  @plotMuResults_OutputFcn, ...
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


% --- Executes just before plotMuResults is made visible.
function plotMuResults_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to plotMuResults (see VARARGIN)

% Choose default command line output for plotMuResults
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes plotMuResults wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = plotMuResults_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in InputFile_List.
function InputFile_List_Callback(hObject, eventdata, handles)
% hObject    handle to InputFile_List (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns InputFile_List contents as cell array
%        contents{get(hObject,'Value')} returns selected item from InputFile_List


% --- Executes during object creation, after setting all properties.
function InputFile_List_CreateFcn(hObject, eventdata, handles)
% hObject    handle to InputFile_List (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in SelectFile_Button.
function SelectFile_Button_Callback(hObject, eventdata, handles)
% hObject    handle to SelectFile_Button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in PlotVERP_Button.
function PlotVERP_Button_Callback(hObject, eventdata, handles)
% hObject    handle to PlotVERP_Button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in PlotConVERPS_Button.
function PlotConVERPS_Button_Callback(hObject, eventdata, handles)
% hObject    handle to PlotConVERPS_Button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
