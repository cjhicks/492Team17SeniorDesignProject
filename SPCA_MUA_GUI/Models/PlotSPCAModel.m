classdef PlotSPCAModel < ModelBase
    %PLOTSPCAMODEL Summary of this class goes here
    %   Detailed explanation goes here
    
    properties(SetObservable)
        SPCAFilePath
        SPCAFileName
    end
    
    methods
        % constructor
        function obj = PlotSPCAModel()
            obj.Clear();
        end

        %clears data
        function Clear(obj)
            obj.SPCAFilePath = 0;
            obj.SPCAFileName = 0;
        end
        
        % Imports SPCA Results, then plots the results. 
        % Possible rotations: Raw, Varimax, and Promax
        function doPlotSPCAResults(obj, rotation)
            if( ~isequal(obj.SPCAFilePath, 0) && ~isequal(obj.SPCAFileName, 0) )
                fullFilePath = strcat(obj.SPCAFilePath, obj.SPCAFileName); % create full file path
                spcaResults = load(fullFilePath); % load the SPCA results
                
                % Call appropriate plotting function
                if( strcmp(rotation, 'Promax') )
                    obj.doPlotPromax(spcaResults.STPCAresults);
                elseif( strcmp(rotation, 'Varimax'))
                    obj.doPlotVarimax(spcaResults.STPCAresults);
                else % defaults to raw
                    obj.doPlotRaw(spcaResults.STPCAresults);
                end
            else
                errordlg('Please check the SPCA Results file path'); % print error message
            end
        end
        
        % Plot Promax rotation for the retained spatial components
        function doPlotPromax(obj, spcaResults)
            for channelNum=1:spcaResults.numberOfSpatialComponents
                PlotSPCAResultsGenerator.PlotPromaxSPCAResultsByChannel( spcaResults, spcaResults.numberOfSubjects, spcaResults.numberOfConditions, spcaResults.ConditionNames, spcaResults.epochTotal, spcaResults.chanlocs, channelNum );
            end
        end

        % Plot Varimax rotation for the retained spatial components
        function doPlotVarimax(obj, spcaResults)
            for channelNum=1:spcaResults.numberOfSpatialComponents
                PlotSPCAResultsGenerator.PlotVarimaxSPCAResultsByChannel( spcaResults, spcaResults.numberOfSubjects, spcaResults.numberOfConditions, spcaResults.ConditionNames, spcaResults.epochTotal, spcaResults.chanlocs, channelNum );
            end
        end
        
        % Plot Promax rotation for the retained spatial components
        function doPlotRaw(obj, spcaResults)
            for channelNum=1:spcaResults.numberOfSpatialComponents
                PlotSPCAResultsGenerator.PlotRawSPCAResultsByChannel( spcaResults, spcaResults.numberOfSubjects, spcaResults.numberOfConditions, spcaResults.ConditionNames, spcaResults.epochTotal, spcaResults.chanlocs, channelNum );
            end
        end
        
    end
    
end

