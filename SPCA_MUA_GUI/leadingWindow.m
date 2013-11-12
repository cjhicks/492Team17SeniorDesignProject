function varargout = leadingWindow(varargin)
% LEADINGWINDOW MATLAB code for leadingWindow.fig
%      LEADINGWINDOW, by itself, creates a new LEADINGWINDOW or raises the existing
%      singleton*.
%
%      H = LEADINGWINDOW returns the handle to a new LEADINGWINDOW or the handle to
%      the existing singleton*.
%
%      LEADINGWINDOW('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in LEADINGWINDOW.M with the given input arguments.
%
%      LEADINGWINDOW('Property','Value',...) creates a new LEADINGWINDOW or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before leadingWindow_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to leadingWindow_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help leadingWindow

% Last Modified by GUIDE v2.5 07-May-2013 16:24:14

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @leadingWindow_OpeningFcn, ...
                   'gui_OutputFcn',  @leadingWindow_OutputFcn, ...
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


% --- Executes just before leadingWindow is made visible.
function leadingWindow_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to leadingWindow (see VARARGIN)

% Choose default command line output for leadingWindow
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes leadingWindow wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = leadingWindow_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in buildDatasetButton.
function buildDatasetButton_Callback(hObject, eventdata, handles)
% hObject    handle to buildDatasetButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Go to Build Dataset Window
BDSModel = BuildDatasetModel();
BDSPresenter = BuildDatasetPresenter(BDSModel);


% --- Executes on button press in identifyComponentsButton.
function identifyComponentsButton_Callback(hObject, eventdata, handles)
% hObject    handle to identifyComponentsButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Go to Identify Components Window
icModel = SPCAModel();
icPres = SPCAPresenter(icModel);


% --- Executes on button press in plotGrandAverageAllElectrodesButton.
function plotGrandAverageAllElectrodesButton_Callback(hObject, eventdata, handles)
% hObject    handle to plotGrandAverageAllElectrodesButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Go to Plot Grand-Averages Window
PGAModel = PlotGrandAvgModel();
PGAPresenter = PlotGrandAvgPresenter(PGAModel);


% --- Executes on button press in plotSpcaResultsButton.
function plotSpcaResultsButton_Callback(hObject, eventdata, handles)
% hObject    handle to plotSpcaResultsButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Go to Plot SPCA Results Window
PlotSCPAModel = PlotSPCAModel();
PlotSCPAPresenter = PlotSPCAPresenter(PlotSCPAModel);


% --- Executes on button press in runMuaButton.
function runMuaButton_Callback(hObject, eventdata, handles)
% hObject    handle to runMuaButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Go to Run MUA Window
runMua;


% --- Executes on button press in PlotMuResults.
function PlotMuResults_Callback(hObject, eventdata, handles)
% hObject    handle to PlotMuResults (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Go to Plot MU Results Window
plotMuResults;
