classdef BuildDatasetModel < ModelBase
    %UNTITLED5 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties (SetObservable)
        inputDirName
        inputDirPath
        numberOfSubjects
        numberOfConditions
        sampleRate
        baseline
        electrodeFileName
        ConditionNames
        electrodeData
        dataset
    end
    
    methods
        % constructor
        function obj = BuildDatasetModel()
            obj.Clear();
        end

        %clears data
        function Clear(obj)
            obj.inputDirName = 0;
            obj.inputDirPath = 0;
            obj.numberOfSubjects = -1;
            obj.numberOfConditions = -1;
            obj.sampleRate = -1;
            obj.baseline = 1/0;
            obj.electrodeFileName = 0;
            obj.ConditionNames = '';
            obj.electrodeData = 0;
            obj.dataset = [];
        end
        
        % builds dataset
        function [count] = doBuildDataset(obj)
            fullFilePath = strcat(obj.inputDirPath, obj.inputDirName); % create full file path
            fileID = fopen(fullFilePath); % Open file
            thisLine = fgets(fileID); % Get first line
            obj.dataset = []; % init dataset

            % init waitbar
            wBar = waitbar(0,'Please wait, Building Dataset...');
            Nrows = numel(textread(fullFilePath,'%1c%*[^\n]'));
            count = 0;
            
            %   While this line is valid
            while ischar(thisLine) 
                thisSubjectConditionData = load(strcat(obj.inputDirPath, thisLine));
                obj.dataset = cat(1, obj.dataset, thisSubjectConditionData);
                thisLine = fgets(fileID);   % get next line
    
                % update wait bar
                count = count + 1;
                waitbar(count/Nrows);
            end
            
            close(wBar);
            fclose(fileID); % close file
        end
        
        function Save(obj)
            dataset = obj.dataset;
            numberOfSubjects = obj.numberOfSubjects;
            numberOfConditions = obj.numberOfConditions;
            sampleRate = obj.sampleRate;
            baseline = obj.baseline;
            electrodeData = obj.electrodeData;
            ConditionNames = obj.ConditionNames;
            
            uisave({'dataset', 'numberOfSubjects', 'numberOfConditions', 'sampleRate', 'baseline', 'electrodeData', 'ConditionNames'});
            %[filename, pathname] = uiputfile('*.mat','Save Dataset As');
            %newfilename = fullfile(pathname, filename);
            %save(newfilename, {'dataset', 'numberOfSubjects', 'numberOfConditions', 'sampleRate', 'baseline', 'electrodeData', 'ConditionNames'});
        
            % Plot Grand-Averages 
            plotGrandModel = PlotGrandAvgModel();
            plotGrandModel.doPlotting(dataset, electrodeData);
        
        end
    end 
end

