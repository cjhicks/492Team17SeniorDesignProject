%standard plot
%plot(STPCAresults.time,STPCAresults.Spatial.PmxScr_mean')

% not sure what these labels are
%plot(STPCAresults.time,STPCAresults.Spatial.PmxScr_mean','linewidth',3)
%legend('C1','C2','C3','C4','C5','C6','C7','C8','C9');

conditions=6;
subjects=3;
channels=62;
epochTotal=801;

ConditionAvgsbySub=reshape(STPCAresults.Spatial.PmxScr',channels,epochTotal,subjects*conditions);
ConditionAvgs=[];
for i=1:conditions%length(conditions)
ConditionAvgs=cat(3,ConditionAvgs,mean(ConditionAvgsbySub(:,:,i:conditions:size(ConditionAvgsbySub,3)),3));
end

%ploteachcomponent
component=45;
figure
subplot(1,2,1)
topoplot(STPCAresults.Spatial.PmxPat(:,component),chanlocs);
subplot(1,2,2)
plot(STPCAresults.time,squeeze(ConditionAvgs(component,:,:)),'linewidth',3)
axis tight
%conditionlabels={'mcC','mcI','miC','miI'};
conditionlabels={'dwhb','dwlb','pbhb','pblb','pwhb','pwlb'};
legend(conditionlabels)
title(['Channel: ', chanlocs(component).labels])