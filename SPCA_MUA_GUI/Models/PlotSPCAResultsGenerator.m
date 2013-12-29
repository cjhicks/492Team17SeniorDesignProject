classdef PlotSPCAResultsGenerator
    % static class that generates SPCA Results. Called by the PlotSPCAModel
    % to generate its results
    
    properties
    end
    
    methods(Static)
        
        % Plots Promax results by channel
        function [ ] = PlotPromaxSPCAResultsByChannel( STPCAresults, subjects, conditions, conditionlabels, epochTotal, chanlocs, channelNum )

            channels = length(chanlocs);

            ConditionAvgsbySub=reshape(STPCAresults.Spatial.PmxScr',channels,epochTotal,subjects*conditions);
            ConditionAvgs=[];
            for i=1:conditions%length(conditions)
                ConditionAvgs=cat(3,ConditionAvgs,mean(ConditionAvgsbySub(:,:,i:conditions:size(ConditionAvgsbySub,3)),3));
            end
            
            figure
            subplot(1,2,1)
            topoplot(STPCAresults.Spatial.PmxPat(:,channelNum),chanlocs);
            subplot(1,2,2)
            plot(STPCAresults.time,squeeze(ConditionAvgs(channelNum,:,:)),'linewidth',3)
            axis tight
            legend(conditionlabels)
            %title(['Channel: ', chanlocs(channelNum).labels])
            set(gcf,'numbertitle','off','name',['Promax Rotation ', int2str(channelNum)])
        end
        
        % Plots Varimax Results By Channel
        function [ ] = PlotVarimaxSPCAResultsByChannel( STPCAresults, subjects, conditions, conditionlabels, epochTotal, chanlocs, channelNum )

            channels = length(chanlocs);

            ConditionAvgsbySub=reshape(STPCAresults.Spatial.VmxScr',channels,epochTotal,subjects*conditions);
            ConditionAvgs=[];
            for i=1:conditions
                ConditionAvgs=cat(3,ConditionAvgs,mean(ConditionAvgsbySub(:,:,i:conditions:size(ConditionAvgsbySub,3)),3));
            end
            
            figure
            subplot(1,2,1)
            topoplot(STPCAresults.Spatial.VmxPat(:,channelNum),chanlocs);
            subplot(1,2,2)
            plot(STPCAresults.time,squeeze(ConditionAvgs(channelNum,:,:)),'linewidth',3)
            axis tight
            legend(conditionlabels)
            %title(['Channel: ', chanlocs(channelNum).labels])
            set(gcf,'numbertitle','off','name',['Varimax Rotation ', int2str(channelNum)])
        end
        
        % Plots Raw resuts by channel
        function [ ] = PlotRawSPCAResultsByChannel( STPCAresults, subjects, conditions, conditionlabels, epochTotal, chanlocs, channelNum )
            
            channels = length(chanlocs);

            ConditionAvgsbySub=reshape(STPCAresults.Spatial.scores',channels,epochTotal,subjects*conditions);
            ConditionAvgs=[];
            for i=1:conditions
                ConditionAvgs=cat(3,ConditionAvgs,mean(ConditionAvgsbySub(:,:,i:conditions:size(ConditionAvgsbySub,3)),3));
            end
            
            figure
            subplot(1,2,1)
            topoplot(STPCAresults.Spatial.loadings(:,channelNum),chanlocs);
            subplot(1,2,2)
            plot(STPCAresults.time,squeeze(ConditionAvgs(channelNum,:,:)),'linewidth',3)
            axis tight
            legend(conditionlabels)
            %title(['Number: ', channelNum])
            set(gcf,'numbertitle','off','name',['Raw Results ', int2str(channelNum)])
        end

    end
    
end

