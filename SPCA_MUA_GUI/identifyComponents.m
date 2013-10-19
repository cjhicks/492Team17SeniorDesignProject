function varargout = identifyComponents(varargin)
% IDENTIFYCOMPONENTS MATLAB code for identifyComponents.fig
%      IDENTIFYCOMPONENTS, by itself, creates a new IDENTIFYCOMPONENTS or raises the existing
%      singleton*.
%
%      H = IDENTIFYCOMPONENTS returns the handle to a new IDENTIFYCOMPONENTS or the handle to
%      the existing singleton*.
%
%      IDENTIFYCOMPONENTS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in IDENTIFYCOMPONENTS.M with the given input arguments.
%
%      IDENTIFYCOMPONENTS('Property','Value',...) creates a new IDENTIFYCOMPONENTS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before identifyComponents_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to identifyComponents_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help identifyComponents

% Last Modified by GUIDE v2.5 09-Sep-2013 21:46:04

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @identifyComponents_OpeningFcn, ...
                   'gui_OutputFcn',  @identifyComponents_OutputFcn, ...
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


% --- Executes just before identifyComponents is made visible.
function identifyComponents_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to identifyComponents (see VARARGIN)

% Choose default command line output for identifyComponents
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes identifyComponents wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = identifyComponents_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
global datasetData;
global epochStart;
global epochEnd;
datasetData = -1;
epochStart = 1/0;
epochEnd = 1/0;


% --- Executes on button press in SelectDataSetButton.
function SelectDataSetButton_Callback(hObject, eventdata, handles)
% hObject    handle to SelectDataSetButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% declare global variables
global datasetFileName;
global datasetFilePath;
global datasetData;

% get electrode file
[datasetFileName, datasetFilePath] = uigetfile('.mat', 'Select the Electrode File');

% update file name string
if(~isempty(datasetFileName)) 
    set(handles.InputDatasetText, 'String', datasetFileName);
    
    datasetData  = load(strcat(datasetFilePath, datasetFileName));
    
    for i=1:length(datasetData.electrodeData)
        str(i) = cellstr(datasetData.electrodeData(i).labels);
    end
    set(handles.AllElectrodesList, 'String', str); %TODO, this needs fixed
end



function InputDatasetText_Callback(hObject, eventdata, handles)
% hObject    handle to InputDatasetText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of InputDatasetText as text
%        str2double(get(hObject,'String')) returns contents of InputDatasetText as a double


% --- Executes during object creation, after setting all properties.
function InputDatasetText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to InputDatasetText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function EpochStartText_Callback(hObject, eventdata, handles)
% hObject    handle to EpochStartText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EpochStartText as text
%        str2double(get(hObject,'String')) returns contents of EpochStartText as a double
global epochStart;
epochStart = str2double(get(hObject, 'String'));


% --- Executes during object creation, after setting all properties.
function EpochStartText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EpochStartText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function EpochEndText_Callback(hObject, eventdata, handles)
% hObject    handle to EpochEndText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EpochEndText as text
%        str2double(get(hObject,'String')) returns contents of EpochEndText as a double
global epochEnd;
epochEnd = str2double(get(hObject, 'String'));


% --- Executes during object creation, after setting all properties.
function EpochEndText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EpochEndText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in AllElectrodesList.
function AllElectrodesList_Callback(hObject, eventdata, handles)
% hObject    handle to AllElectrodesList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns AllElectrodesList contents as cell array
%        contents{get(hObject,'Value')} returns selected item from AllElectrodesList


% --- Executes during object creation, after setting all properties.
function AllElectrodesList_CreateFcn(hObject, eventdata, handles)
% hObject    handle to AllElectrodesList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in AddedElectrodesList.
function AddedElectrodesList_Callback(hObject, eventdata, handles)
% hObject    handle to AddedElectrodesList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns AddedElectrodesList contents as cell array
%        contents{get(hObject,'Value')} returns selected item from AddedElectrodesList


% --- Executes during object creation, after setting all properties.
function AddedElectrodesList_CreateFcn(hObject, eventdata, handles)
% hObject    handle to AddedElectrodesList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in AddButton.
function AddButton_Callback(hObject, eventdata, handles)
% hObject    handle to AddButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in RemoveButton.
function RemoveButton_Callback(hObject, eventdata, handles)
% hObject    handle to RemoveButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in RunParallelAnalysisButton.
function RunParallelAnalysisButton_Callback(hObject, eventdata, handles)
% hObject    handle to RunParallelAnalysisButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% TODO: temp code
global datasetData;

[numberOfSpatialComponents] = doParallelAnalysis(datasetData.dataset);
set(handles.NumberSpatialComponentsText, 'String', numberOfSpatialComponents);




% --- Executes on button press in RunScreePlotButton.
function RunScreePlotButton_Callback(hObject, eventdata, handles)
% hObject    handle to RunScreePlotButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function NumberSpatialComponentsText_Callback(hObject, eventdata, handles)
% hObject    handle to NumberSpatialComponentsText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of NumberSpatialComponentsText as text
%        str2double(get(hObject,'String')) returns contents of NumberSpatialComponentsText as a double


% --- Executes during object creation, after setting all properties.
function NumberSpatialComponentsText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NumberSpatialComponentsText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in RunSpatialPCAButton.
function RunSpatialPCAButton_Callback(hObject, eventdata, handles)
% hObject    handle to RunSpatialPCAButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global datasetData;
global epochStart;
global epochEnd;

pcadata = struct;
timeSpan = (epochEnd - epochStart)*datasetData.sampleRate;
pcadata.data = datasetData.dataset;
sections = datasetData.numberOfSubjects*datasetData.numberOfConditions;
rowsPerSection = size(pcadata.data, 1)/(sections);

% cut off beginning rows before baseline, do matrix stuff
if( datasetData.baseline < 0)
    
    % THIS LINE NEEDS TESTING
    offset = round((0-datasetData.baseline/1000)*datasetData.sampleRate); % gets x number of rows offset from baseline
    
    data=[];
    for i=1:sections
        startRow = ((i-1)*rowsPerSection) + offset + 1;
        endRow = (i*rowsPerSection);
        data=cat(1, data, pcadata.data(startRow:endRow,:));
    end
    
    pcadata.data = data;
    rowsPerSection = size(pcadata.data, 1)/(sections);
end

% remove all rows after epochEnd, do matrix stuff
if(rowsPerSection > timeSpan)
    data=[];
    for i=1:sections
        startRow = ((i-1)*rowsPerSection) + 1;
        endRow = (startRow + timeSpan);
        tempData = pcadata.data(startRow:endRow, :);
        data=cat(1, data, tempData);
    end
    
    pcadata.data = data;
end

% remove unused columns (channels), i guess do a for for each column to see
% if before channel is in after channel. If not, remove it, then at end
% truncate extra
len = length(datasetData.electrodeData); %TODO fix, for now just truncate extra
pcadata.data = pcadata.data(:,1:len);

pcadata.time =  epochStart:(1/datasetData.sampleRate):epochEnd;


[STPCAresults]=STPCA(pcadata,datasetData.numberOfSubjects,datasetData.numberOfConditions,0);
uisave('STPCAresults');

