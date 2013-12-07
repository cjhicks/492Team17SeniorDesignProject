classdef SPCAModel < ModelBase
    %SPCAMODEL Summary of this class goes here
    %   Detailed explanation goes here
    
    properties(SetObservable)
        datasetFilePath
        datasetFileName
        datasetData
        epochStart
        epochEnd
        addedElectrodeList
        numberOfSpatialComponents
    end
    
    methods
        % constructor
        function obj = SPCAModel()
            obj.Clear();
        end

        %clears data
        function Clear(obj)
            obj.datasetFilePath = 0;
            obj.datasetFileName = 0;
            obj.datasetData = -1;
            obj.epochStart = 1/0;
            obj.epochEnd = 1/0;
            obj.addedElectrodeList = {''};
            obj.numberOfSpatialComponents = -1;
        end
        
        function RunParallelAnalysis(obj)
            [includedChannels, electrodeIndices] = obj.getIncludedElectrodes();
            [obj.numberOfSpatialComponents] = SpcaAlgorithmGenerator.doParallelAnalysis(obj.datasetData.dataset(:, electrodeIndices));
        end
        
        function doScreePlot(obj)
            screedata = struct;
            [includedChannels, electrodeIndices] = obj.getIncludedElectrodes();
            screedata.data = obj.datasetData.dataset(:, electrodeIndices);
            screedata.time = length(obj.datasetData.dataset(:,1));
            [screeResults]=SpcaAlgorithmGenerator.STPCA(screedata,obj.datasetData.numberOfSubjects,obj.datasetData.numberOfConditions);
            figure
            plot(screeResults.Spatial.scree)
            set(gcf,'numbertitle','off','name','Scree Plot for Dataset');
        end
        
        function [validated] = ValidateEpoch(obj)
            if(isnan(obj.epochStart) || isinf(obj.epochStart))
                errordlg('Please select a correct Epoch Start');
                validated = 0;
            elseif(isnan(obj.epochEnd) || isinf(obj.epochEnd))
                errordlg('Please select a correct Epoch End');
                validated = 0;
            elseif(isnan(obj.numberOfSpatialComponents) || obj.numberOfSpatialComponents < 1)
                errordlg('Please determine the Number of Spatial Components. You may use Parallel Analysis and/or Scree Plot to help you determine this number.');
                validated = 0;
            elseif( (length(obj.datasetData.dataset(:,1)')/obj.datasetData.numberOfConditions/obj.datasetData.numberOfSubjects) < obj.epochEnd*obj.datasetData.sampleRate/1000)
                errordlg('Epoch is too large for this dataset! Please update epoch'); 
                validated = 0;
            else
                validated = 1;
            end
        end
        
        function doRunSPCA(obj)
            
            if(isnan(obj.epochStart) || isinf(obj.epochStart))
                errordlg('Please select a correct Epoch Start');
            elseif(isnan(obj.epochEnd) || isinf(obj.epochEnd))
                errordlg('Please select a correct Epoch End');
            elseif(isnan(obj.numberOfSpatialComponents) || obj.numberOfSpatialComponents < 1)
                errordlg('Please determine the Number of Spatial Components. You may use Parallel Analysis and/or Scree Plot to help you determine this number.');
            else
                pcadata = struct;
                timeSpan = obj.MillisecondsToSamples(obj.epochEnd - obj.epochStart)%(obj.epochEnd - obj.epochStart)*obj.datasetData.sampleRate;
                pcadata.data = obj.datasetData.dataset;
                sections = obj.datasetData.numberOfSubjects*obj.datasetData.numberOfConditions;
                rowsPerSection = size(pcadata.data, 1)/(sections);
                
                % cut off beginning rows before baseline, do matrix stuff, MIGHT REMOVE
                if( obj.datasetData.baseline < 0)
                    
                    % THIS LINE NEEDS TESTING
                    offset = round((0-obj.datasetData.baseline/1000)*obj.datasetData.sampleRate); % gets x number of rows offset from baseline
                    offset2 = obj.MillisecondsToSamples(0-obj.datasetData.baseline);
                    
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
                        startRow = ((i-1)*rowsPerSection) + obj.epochStart + 1;
                        endRow = (startRow + timeSpan);
                        tempData = pcadata.data(startRow:endRow, :);
                        data=cat(1, data, tempData);
                    end
                    
                    pcadata.data = data;
                end
                
                % remove unused columns (channels), i guess do a for for each column to see
                % if before channel is in after channel. If not, remove it, then at end
                % truncate extra
                len = length(obj.datasetData.electrodeData); %TODO fix, for now just truncate extra
                pcadata.data = pcadata.data(:,1:len);
                pcadata.time =  obj.epochStart:(1000/obj.datasetData.sampleRate):obj.epochEnd;
                
                % find channels to include in PCA analysis
                [includedChannels, electrodeIndices] = obj.getIncludedElectrodes();
                
                pcadata.data = pcadata.data(:, electrodeIndices);
                [STPCAresults]=SpcaAlgorithmGenerator.STPCA(pcadata,obj.datasetData.numberOfSubjects,obj.datasetData.numberOfConditions);
                STPCAresults.chanlocs = includedChannels;%datasetData.electrodeData;
                %STPCAresults.chanlocIndices = electrodeIndices;
                STPCAresults.numberOfSubjects = obj.datasetData.numberOfSubjects;
                STPCAresults.numberOfConditions = obj.datasetData.numberOfConditions;
                STPCAresults.ConditionNames = obj.datasetData.ConditionNames;
                STPCAresults.numberOfSpatialComponents = obj.numberOfSpatialComponents;
                
                STPCAresults.epochTotal = timeSpan+1;
                
                [filename, pathname] = uiputfile('*.mat','Save SPCA Results As');
                newfilename = fullfile(pathname, filename);
                save(newfilename, 'STPCAresults');
                
                % Go to Plot SPCA Results Window
                PlotSCPAModel = PlotSPCAModel();
                PlotSCPAPresenter = PlotSPCAPresenter(PlotSCPAModel);
                PlotSCPAPresenter.QuickSelectSPCAResults( pathname, filename )
            end
        end
        
        function [includedChannels, electrodeIndices] = getIncludedElectrodes(obj)
            % find channels to include in PCA analysis
            ind=0;
            for i=1:length(obj.datasetData.electrodeData)
                electrode = obj.datasetData.electrodeData(i);
                for j=1:length(obj.addedElectrodeList)
                    temp = cellstr(electrode.labels);
                    if(isequal(cellstr(electrode.labels), obj.addedElectrodeList(j)))
                        ind = ind + 1;
                        includedChannels(ind) = electrode;
                        electrodeIndices(ind) = i;
                        break;
                    end
                end
            end
        end
        
        function [samples] = MillisecondsToSamples(obj, ms)
            samples = (ms*obj.datasetData.sampleRate)/1000;
        end
        
        function [ms] = SamplesToMilliseconds(obj, samples)
            ms = (1000*samples)/obj.datasetData.sampleRate;
        end
    end
    
end

