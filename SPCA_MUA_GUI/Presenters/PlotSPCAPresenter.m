classdef PlotSPCAPresenter < PresenterBase
    %PLOTSPCAPRESENTER Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
    end
    
    methods
        %%%
        % Constructor
        %%%
        function obj = PlotSPCAPresenter(model)
            % call base constructor
            obj =  obj@PresenterBase(model);
            % create view
            obj.view = plotSpcaResults('presenter',obj);
            % add listeners to model data
            addlistener(obj.model, 'SPCAFileName', 'PostSet', @(src,evnt)obj.RenderSPCANameText()); 
        end
        
        %%%
        % Methods called from the view
        %%%
        
        % Prompts file browser to select dataset after button press
        function SelectSPCAResults(obj)
            [inputDirName, inputDirPath] = uigetfile('.MAT', 'Select the SPCA Results File');
            
            if(~isequal(inputDirName,0))
                obj.model.SPCAFileName = inputDirName;
                obj.model.SPCAFilePath = inputDirPath;
            end
        end
        
        function QuickSelectSPCAResults(obj, inputDirPath, inputDirName )
            if(~isequal(inputDirName,0))
                obj.model.SPCAFileName = inputDirName;
                obj.model.SPCAFilePath = inputDirPath;
            end
        end
        
        % after plot button pressed, calls the model to plot
        function doPlotSPCAResults(obj, rotation)
            obj.model.doPlotSPCAResults(rotation);
        end
        
        %%%
        % Methods that render data to the view
        %%%
        
        function RenderSPCANameText(obj)
            handles = guidata(obj.view);
            set(handles.InputFile_Text, 'String', obj.model.SPCAFileName);
        end
    end
    
end

