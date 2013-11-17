classdef SPCAPresenter < PresenterBase
    %SPCAPRESENTER Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        numSpatialCompListener
    end
    
    methods
        %%%
        % Constructor
        %%%
        function obj = SPCAPresenter(model)
            % call base constructor
            obj =  obj@PresenterBase(model);
            % create view
            obj.view = identifyComponents('presenter',obj);
            % add listeners to model data
            addlistener(obj.model, 'datasetFileName', 'PostSet', @(src,evnt)obj.RenderDatasetNameText()); 
            addlistener(obj.model, 'datasetData', 'PostSet', @(src,evnt)obj.RenderAllElectrodesListText());
            addlistener(obj.model, 'addedElectrodeList', 'PostSet', @(src,evnt)obj.RenderAddedElectrodesListText());
            obj.numSpatialCompListener = addlistener(obj.model, 'numberOfSpatialComponents', 'PostSet', @(src,evnt)obj.RenderNumSpatialComponents());
        end
        
        %%%
        % Methods called from the view
        %%%
        
        % selects dataset file to input
        function SelectDatasetFile(obj)
            [datasetFileName, datasetFilePath] = uigetfile('.mat', 'Select the Dataset File');
            
            if(~isempty(datasetFileName)) % if not empty, load dataset data to the model
                obj.model.datasetFilePath = datasetFilePath;
                obj.model.datasetFileName = datasetFileName;
                obj.model.datasetData  = load(strcat(datasetFilePath, datasetFileName));
            end
        end
        
        function SetEpochStart(obj, epochStart)
            obj.model.epochStart = epochStart;
        end
        
        function SetEpochEnd(obj, epochEnd)
            obj.model.epochEnd = epochEnd;
        end
        
        function SetNumberSpatialComponents(obj, numComponents)
            delete(obj.numSpatialCompListener);
            obj.model.numberOfSpatialComponents = numComponents;
            obj.numSpatialCompListener = addlistener(obj.model, 'numberOfSpatialComponents', 'PostSet', @(src,evnt)obj.RenderNumSpatialComponents());
        end
        
        % called after pressing add button
        function AddElectrode(obj, selected)
            if (isequal(obj.model.addedElectrodeList,{''}) || length(obj.model.addedElectrodeList)==0) % empty list, add first
                obj.model.addedElectrodeList = selected;
            else % concatentate list
                obj.model.addedElectrodeList = cat(1, obj.model.addedElectrodeList, selected);
            end
        end
        
        % called after pressing remove button
        function RemoveElectrode(obj, selected)
            if(length(obj.model.addedElectrodeList) > 0)
                obj.model.addedElectrodeList(selected) = [];
            end
        end
        
        function AddAllElectrodes(obj)
            obj.model.addedElectrodeList = {''};
            for i=1:length(obj.model.datasetData.electrodeData)
                obj.AddElectrode(cellstr(obj.model.datasetData.electrodeData(i).labels));
            end
        end
        
        function RunParallelAnalysis(obj)
            obj.model.RunParallelAnalysis();
        end
        
        function RunSPCA(obj)
            obj.model.doRunSPCA();
        end
        
        function RunScreePlot(obj)
            obj.model.doScreePlot();
        end
        
        %%%
        % Methods that render data to the view
        %%%
        function RenderDatasetNameText(obj)
            handles = guidata(obj.view);
            set(handles.InputDatasetText, 'String', obj.model.datasetFileName);
        end
        
        function RenderAllElectrodesListText(obj)
            handles = guidata(obj.view);
            for i=1:length(obj.model.datasetData.electrodeData)
                str(i) = cellstr(obj.model.datasetData.electrodeData(i).labels);
            end
            set(handles.AllElectrodesList, 'String', str);
        end
        
        function RenderAddedElectrodesListText(obj)
            handles = guidata(obj.view);
            set(handles.AddedElectrodesList, 'Value', 1);
            set(handles.AddedElectrodesList, 'String', obj.model.addedElectrodeList);
        end
        
        function RenderNumSpatialComponents(obj)
            handles = guidata(obj.view);
            set(handles.NumberSpatialComponentsText, 'String', obj.model.numberOfSpatialComponents);
        end
    
    end
end

