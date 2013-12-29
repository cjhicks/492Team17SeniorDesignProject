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
                obj.doPlotting(dataset.dataset, dataset.electrodeData, dataset.numberOfSubjects, dataset.numberOfConditions, dataset.baseline, dataset.sampleRate, dataset.ConditionNames);
            else
                errordlg('Please check the Dataset file path'); % print error message
            end
        end
        
        % Plots Grand-Averaged Data in a 2D orientation
        function doPlotting(obj, dataset, electrodeData, numSubjects, numConditions, baseline, sampleRate, condNames)
                % Filter dataset by each condition, averaged
                epoch = length(dataset(:,1))/(numSubjects*numConditions);
                otherTemp = reshape(dataset', length(electrodeData), epoch, numSubjects*numConditions);
                thirdTemp = zeros(length(electrodeData), epoch, numConditions);
                for i=1:numConditions
                    for j=i:numConditions:(numConditions*numSubjects-numConditions)+i
                        thirdTemp(:,:,i) = thirdTemp(:,:,i) + otherTemp(:,:, j);
                    end
                    thirdTemp(:,:,i) = thirdTemp(:,:,i)/numSubjects;
                end
      
                figure 
                %Call EEGLab plot function
                plottopo(thirdTemp, 'chanlocs', electrodeData, 'legend', condNames, 'frames', epoch, 'limits', [baseline (epoch*1000/sampleRate)+baseline-(1000/sampleRate) -0 0]);
                %plottopo(dataset(:, 1:length(electrodeData))', 'chanlocs', electrodeData);
                set(gcf,'numbertitle','off','name','Grand-Averages');
                %set(gcf,
        end
        
    end
    
end

