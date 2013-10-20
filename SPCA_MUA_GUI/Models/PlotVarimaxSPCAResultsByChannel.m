function [ ] = PlotVarimaxSPCAResultsByChannel( STPCAresults, subjects, conditions, conditionlabels, epochTotal, chanlocs, channelNum )

%conditions=6;
%subjects=3;
%channels=62;
%epochTotal=801;
channels = length(chanlocs);

ConditionAvgsbySub=reshape(STPCAresults.Spatial.VmxScr',channels,epochTotal,subjects*conditions);
ConditionAvgs=[];
for i=1:conditions%length(conditions)
ConditionAvgs=cat(3,ConditionAvgs,mean(ConditionAvgsbySub(:,:,i:conditions:size(ConditionAvgsbySub,3)),3));
end

%ploteachcomponent
%component=8;
figure
subplot(1,2,1)
topoplot(STPCAresults.Spatial.VmxPat(:,channelNum),chanlocs);
subplot(1,2,2)
plot(STPCAresults.time,squeeze(ConditionAvgs(channelNum,:,:)),'linewidth',3)
axis tight
%conditionlabels={'mcC','mcI','miC','miI'};
legend(conditionlabels)
title(['Channel: ', chanlocs(channelNum).labels])
set(gcf,'numbertitle','off','name',['Varimax Rotation for ', chanlocs(channelNum).labels])
end


