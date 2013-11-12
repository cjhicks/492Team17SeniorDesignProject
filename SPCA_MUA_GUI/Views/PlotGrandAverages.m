function varargout = PlotGrandAverages(varargin)
% PLOTGRANDAVERAGES MATLAB code for PlotGrandAverages.fig
%      PLOTGRANDAVERAGES, by itself, creates a new PLOTGRANDAVERAGES or raises the existing
%      singleton*.
%
%      H = PLOTGRANDAVERAGES returns the handle to a new PLOTGRANDAVERAGES or the handle to
%      the existing singleton*.
%
%      PLOTGRANDAVERAGES('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PLOTGRANDAVERAGES.M with the given input arguments.
%
%      PLOTGRANDAVERAGES('Property','Value',...) creates a new PLOTGRANDAVERAGES or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before PlotGrandAverages_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to PlotGrandAverages_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help PlotGrandAverages

% Last Modified by GUIDE v2.5 02-Nov-2013 11:17:46

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @PlotGrandAverages_OpeningFcn, ...
                   'gui_OutputFcn',  @PlotGrandAverages_OutputFcn, ...
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


% --- Executes just before PlotGrandAverages is made visible.
function PlotGrandAverages_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to PlotGrandAverages (see VARARGIN)

% Choose default command line output for PlotGrandAverages
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

% UIWAIT makes PlotGrandAverages wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = PlotGrandAverages_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in selectDatasetBtn.
function selectDatasetBtn_Callback(hObject, eventdata, handles)
% hObject    handle to selectDatasetBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% delegate selecting dataset to the Presenter
handles.presenter.SelectDataset();



function DatasetText_Callback(hObject, eventdata, handles)
% hObject    handle to DatasetText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DatasetText as text
%        str2double(get(hObject,'String')) returns contents of DatasetText as a double


% --- Executes during object creation, after setting all properties.
function DatasetText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DatasetText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in PlotGrandAvgBtn.
function PlotGrandAvgBtn_Callback(hObject, eventdata, handles)
% hObject    handle to PlotGrandAvgBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% delegate call to the presenter
handles.presenter.doPlotGrandAverages();
