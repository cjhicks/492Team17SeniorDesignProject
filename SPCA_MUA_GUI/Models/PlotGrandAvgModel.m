classdef PlotGrandAvgModel < ModelBase
    %PLOTGRANDAVGMODEL Summary of this class goes here
    %   Detailed explanation goes here
    
    properties(SetObservable)
        DatasetDirPath
        DatasetDirName
    end
    
    methods
        % constructor
        function obj = PlotGrandAvgModel()
            obj.Clear();
        end

        %clears data
        function Clear(obj)
            obj.DatasetDirPath = 0;
            obj.DatasetDirName = 0;
        end
        
        % Imports dataset, then plots grand averages
        function doPlotGrandAverages(obj)
            if( ~isequal(obj.DatasetDirPath, 0) && ~isequal(obj.DatasetDirName, 0) )
                fullFilePath = strcat(obj.DatasetDirPath, obj.DatasetDirName); % create full file path
                dataset = load(fullFilePath); % load the dataset
                
                % Call EEGLab plot function
                obj.doPlotting(dataset.dataset, dataset.electrodeData);
            else
                errordlg('Please check the Dataset file path'); % print error message
            end
        end
        
        % Plots Grand-Averaged Data in a 2D orientation
        function doPlotting(obj, dataset, electrodeData)
                % Call EEGLab plot function
                figure
                plottopo(dataset(:, 1:length(electrodeData))', 'chanlocs', electrodeData);
                set(gcf,'numbertitle','off','name','Grand-Averages');
        end
        
    end
    
end

