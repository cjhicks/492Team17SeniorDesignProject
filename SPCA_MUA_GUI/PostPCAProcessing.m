%Post-processing script

%baseline correction (only for early or whole analysis)
STPCAresults.Spatial.PmxScr_mean=STPCAresults.Spatial.PmxScr_mean-(mean(STPCAresults.Spatial.PmxScr_mean(:,1:100),2)*ones(1,601));

plot(STPCAresults.time,STPCAresults.Spatial.PmxScr_mean')
plot(STPCAresults.time,STPCAresults.Spatial.PmxScr_mean','linewidth',3)
legend('C1','C2','C3','C4','C5','C6','C7','C8','C9');

ConditionAvgsbySub=reshape(STPCAresults.Spatial.PmxScr',5,500,103*6);
ConditionAvgs=[];
for i=1:length(conditions)
ConditionAvgs=cat(3,ConditionAvgs,mean(ConditionAvgsbySub(:,:,i:6:size(ConditionAvgsbySub,3)),3));
end

%ploteachcomponent
component=5;
figure
subplot(1,2,1)
topoplot(STPCAresults.Spatial.PmxPat(:,component),chanlocs);
subplot(1,2,2)
plot(STPCAresults.time,squeeze(ConditionAvgs(component,:,:)),'linewidth',3)
axis tight
conditionlabels={'dwhb','dwlb','pbhb','pblb','pwhb','pwlb'};
legend(conditionlabels)