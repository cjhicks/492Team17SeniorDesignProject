classdef PlotGrandAvgPresenter < PresenterBase
    %PLOTGRANDAVGPRESENTER Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
    end
    
    methods
        %%%
        % Constructor
        %%%
        function obj = PlotGrandAvgPresenter(model)
            % call base constructor
            obj =  obj@PresenterBase(model);
            % create view
            obj.view = PlotGrandAverages('presenter',obj);
            % add listeners to model data
            addlistener(obj.model, 'DatasetDirName', 'PostSet', @(src,evnt)obj.RenderDatasetText()); 
        end
        
        %%%
        % Methods called from the view
        %%%
        
        % Prompts file browser to select dataset after button press
        function SelectDataset(obj)
            [inputDirName, inputDirPath] = uigetfile('.MAT', 'Select the Dataset File');
            
            if(~isequal(inputDirName,0))
                obj.model.DatasetDirName = inputDirName;
                obj.model.DatasetDirPath = inputDirPath;
            end
        end
        
        % after plot button pressed, calls the model to plot
        function doPlotGrandAverages(obj)
            obj.model.doPlotGrandAverages();
        end
        
        %%%
        % Methods that render data to the view
        %%%
        
        function RenderDatasetText(obj)
            handles = guidata(obj.view);
            set(handles.DatasetText, 'String', obj.model.DatasetDirName);
        end
        
    end
    
end

