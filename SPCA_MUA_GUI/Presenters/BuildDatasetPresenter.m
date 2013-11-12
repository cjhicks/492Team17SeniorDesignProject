classdef BuildDatasetPresenter < PresenterBase
    %Presenter class for Build Dataset View
    %   This class takes in user actions from the view, performs operations
    %   on the model, listens to changes in the model, and updates the view
    %   accordingly
    
    properties
    end
    
    methods
        %%%
        % Constructor
        %%%
        function obj = BuildDatasetPresenter(model)
            % call base constructor
            obj =  obj@PresenterBase(model);
            % create view
            obj.view = buildDataset('presenter',obj);
            % add listeners to model data
            addlistener(obj.model, 'inputDirName', 'PostSet', @(src,evnt)obj.RenderInputDirectoryText()); 
            addlistener(obj.model, 'electrodeFileName', 'PostSet', @(src,evnt)obj.RenderElectrodeFileText()); 
        end
        
        %%%
        % Called from View
        %%%
        
        function SelectInputDirectory(obj)
            [inputDirName, inputDirPath] = uigetfile('.txt', 'Select the Input Directory File');
            
            if(~isequal(inputDirName,0))
                obj.model.inputDirName = inputDirName;
                obj.model.inputDirPath = inputDirPath;
            end
        end
        
        function SetConditionNames(obj, ConditionNames)
            obj.model.ConditionNames = ConditionNames;
        end
        
        function SetNumberOfConditions(obj, numberOfConditions)
            obj.model.numberOfConditions = numberOfConditions;
        end
        
        function SetNumberOfSubjects(obj, numberOfSubjects)
            obj.model.numberOfSubjects = numberOfSubjects;
        end
        
        function SetSampleRate(obj, sampleRate)
            obj.model.sampleRate = sampleRate;
        end
        
        function SetBaseline(obj, baseline)
            obj.model.baseline = baseline;
        end
        
        function SelectElectrodeFile(obj)
            % get electrode file
            [electrodeFileName, electrodeFilePath] = uigetfile('.mat', 'Select the Electrode File');
            
            % update file name string
            if(~isequal(electrodeFileName,0))
                electrodeData = load(strcat(electrodeFilePath, electrodeFileName));
                obj.model.electrodeData = electrodeData.chanlocs;
                obj.model.electrodeFileName = electrodeFileName;
            end
        end
        
        function BuildDataset(obj)
            [successfulValidation] = obj.validateTextInput();
            if(successfulValidation == 1)
                [count] = obj.model.doBuildDataset();
    
                % if number of subjects/conditions doesn't coordinate with dataset,
                % throw error message
                if(count ~= (obj.model.numberOfSubjects*obj.model.numberOfConditions)) 
                    errordlg('Number of Subjects and Conditions does not match total files in dataset!');
        
                % if number of conditions don't match, throw error message
                elseif(numel(obj.model.ConditionNames) ~= obj.model.numberOfConditions)
                    errordlg('Number of Conditions doesn''t match the total number of Condition Names!');
        
                % else, save it all
                else
                    obj.model.Save();
                end
            end
        end
        
        % validation method for building a dataset
        function [success] = validateTextInput(obj)
            if(isnan(obj.model.numberOfSubjects) || obj.model.numberOfSubjects < 1)
                errordlg('Number of Subjects is not valid');
                success = 0;
            elseif(isnan(obj.model.numberOfConditions) || obj.model.numberOfConditions < 1)
                errordlg('Number of Conditions is not valid');
                success = 0;
            elseif(isnan(obj.model.sampleRate) || obj.model.sampleRate < 1)
                errordlg('Sample Rate is not valid');
                success = 0;
            elseif(isinf(obj.model.baseline) || isnan(obj.model.baseline))
                errordlg('Baseline is not valid');
                success = 0;
            elseif(isequal(obj.model.electrodeFileName,0))
                errordlg('Please select an Electrode File');
                success = 0;
            else
                success = 1; 
            end
        end
        
        
        %%%
        % Render to View
        %%%
        function RenderInputDirectoryText(obj)
            handles = guidata(obj.view);
            set(handles.inputDirectoryText, 'String', obj.model.inputDirName);
        end
        
        function RenderElectrodeFileText(obj)
            handles = guidata(obj.view);
            set(handles.ElectrodeFileText, 'String', obj.model.electrodeFileName);
        end
    end
    
end

