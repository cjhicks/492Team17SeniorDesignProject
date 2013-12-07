
function []=RunMUA3x2(PCAresults,F3lab,F3Clab,F2lab,F2Clab,chanlocs, base, epochStartInSamples, epochEndInSamples, spatialComponents)
%ASSUMPTION IS THAT DATA ARE NxChan MATRIX WITH ORGANIZATION:
%       F2_1-F3_1
%       F2_2-F3_1
%       F2_1-F3_2
%       F2_2-F3_2
%       F2_1-F3_3
%       F2_2-F3_3
%
%example:
%RunMUA3x2(STPCAresults,'Winner',{'Dealer','Bust','Player'},'Bet',{'large','small'},'chanlocs',EEG.chanlocs);
%for i=1:2:length(varargin)
%    flag=lower(varargin{i});
%    arg=varargin{i+1};
%    switch flag
%        case 'chanlocs'
%            chanlocs=arg;
%    end
%end
%Set-up
%baseline=[1 101]; %baseline [start stop] (in samples)
baseline = [1 (0-base+1)];

%startA=101;%analyis start time (in samples)
%stopA=1101;%analysis stop time (in samples)
startA = baseline(2) + epochStartInSamples;
stopA = baseline(2) + epochEndInSamples;

pcrit=.01;%critical value
Contiguity=25;%contiguity threshold
Nconds=6;% Number of conditions 3x2
Ncomps=size(PCAresults.Spatial.PmxPat,2);%determine number of retained components from pattern matrix
Nsubs=size(PCAresults.Spatial.scores,1)/length(PCAresults.time)/6; %determine number of subjects = (length of concatenated data)/(length of epoch)/6 (3x2=6 conditions)
RMdata=reshape(PCAresults.Spatial.PmxScr',Ncomps,length(PCAresults.time),size(PCAresults.Spatial.scores,1)/length(PCAresults.time));
%baseline correct PCAdata
for r=1:size(RMdata,1)
    for t=1:size(RMdata,3)
        RMdata(r,:,t)=RMdata(r,:,t)-mean(RMdata(r,baseline(1):baseline(2),t));
    end
end
PCAresults.Spatial.PmxScr=reshape(RMdata,Ncomps,size(RMdata,2)*size(RMdata,3))';

%pre-allocate Factor matrices
sublist=reshape(repmat([1:Nsubs],6,1),1,Nsubs*6)'; %subject factor
F3=repmat([1 1 2 2 3 3]',Nsubs,1);
F2=repmat([1 2 1 2 1 2]',Nsubs,1);

%Pre-allocate F-value and P-value ComponentXTime Output matrices
F3_F=zeros(Ncomps,length(PCAresults.time));
F3_P=zeros(Ncomps,length(PCAresults.time));
F2_F=zeros(Ncomps,length(PCAresults.time));
F2_P=zeros(Ncomps,length(PCAresults.time));
F3xF2_F=zeros(Ncomps,length(PCAresults.time));
F3xF2_P=zeros(Ncomps,length(PCAresults.time));

%Perform RMANOVA on each Component and pull out stats for Main effects and
%interactions
for component=1:size(RMdata,1)
    for slice=1:size(RMdata,2)
        thisRM=squeeze(RMdata(component,slice,:));
        [stats] = rm_anova2(thisRM,sublist,F3,F2,{F3lab F2lab});
        F3_F(component,slice)=stats{2,5};
        F3_P(component,slice)=stats{2,6};
        F2_F(component,slice)=stats{3,5};
        F2_P(component,slice)=stats{3,6};
        F3xF2_F(component,slice)=stats{4,5};
        F3xF2_P(component,slice)=stats{4,6};
    end
end
%Determine FDR-corrected p-value over ALL p-values from ANOVA
FDRmatrix=[F3xF2_P(:,startA:stopA);F3_P(:,startA:stopA);F2_P(:,startA:stopA)];
[all_masked, crit_all, adj_p]=fdr_bh(FDRmatrix,pcrit);

%The following line is used to pad the "masked" output with zeros
%so that plotting will show entire epoch even if smaller window
%used for analysis
all_masked=cat(2,zeros(size(all_masked,1),startA-1),all_masked,zeros(size(all_masked,1),size(F3_P,2)-stopA));

%Extract "masked" matrix of p-values for each main effect and interaction
p_maskedF3xF2=all_masked(1:Ncomps,:);
p_maskedF3=all_masked(Ncomps+1:Ncomps*2,:);
p_maskedF2=all_masked(Ncomps*2+1:Ncomps*3,:);


%Find "bins" of significance defined by contiguity threshold.
F3xF2bins={};
F3bins={};
F2bins={};
for component=1:size(p_maskedF3xF2,1)
    %Interaction Bins
    temp=find(abs(diff(cat(2,0,p_maskedF3xF2(component,:),0)')));%convert boolean vector of significance (0/1) to onsets/offsets
    temp(2:2:end)=temp(2:2:end)-1;%move offsets back by one point (correction for "diff" above).
    tempfilt=ones(length(temp),1);
    for i=1:2:length(temp)
        if temp(i+1)-temp(i)<Contiguity %For each "onset" of significance, check if subsequent "offset" meets contiguity threshold and flip all to zero if it doesn't
            tempfilt(i:i+1)=0;
        end
    end
    temp=temp(boolean(tempfilt));%convert to logical matrix
    F3xF2bins{component}=temp; 
    
    %Main Effect F2 bins
    temp=find(abs(diff(cat(2,0,p_maskedF2(component,:),0)')));
    temp(2:2:end)=temp(2:2:end)-1;
    tempfilt=ones(length(temp),1);
    for i=1:2:length(temp)
        if temp(i+1)-temp(i)<Contiguity 
            tempfilt(i:i+1)=0;
        end
    end
    temp=temp(boolean(tempfilt));
    F2bins{component}=temp;
    
    %Main Effect F3 bins
    temp=find(abs(diff(cat(2,0,p_maskedF3(component,:),0)')));
    temp(2:2:end)=temp(2:2:end)-1;
    tempfilt=ones(length(temp),1);
    for i=1:2:length(temp)
        if temp(i+1)-temp(i)<Contiguity
            tempfilt(i:i+1)=0;
        end
    end
    temp=temp(boolean(tempfilt));
    F3bins{component}=temp;
end

%For each "bin" (group of significant p-values > contiguity threshold) in the omnibus test, find bins for paired contrasts
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   F2 Contrasts
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
F2ContrastsH=NaN(Ncomps,length(PCAresults.time));
F2ContrastsP=NaN(Ncomps,length(PCAresults.time));
for component=1:Ncomps
    for bin=1:2:length(F2bins{component})
        thisbin=[F2bins{component}(bin) F2bins{component}(bin+1)];
        for slice=thisbin(1):thisbin(2)
            thisRM=squeeze(RMdata(component,slice,:));
            [F2ContrastsH(component,slice),F2ContrastsP(component,slice)] = ttest(thisRM(F2==1),thisRM(F2==2));
        end
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Winer Contrasts
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
F312ContrastsH=NaN(Ncomps,length(PCAresults.time));
F312ContrastsP=NaN(Ncomps,length(PCAresults.time));
F313ContrastsH=NaN(Ncomps,length(PCAresults.time));
F313ContrastsP=NaN(Ncomps,length(PCAresults.time));
F323ContrastsH=NaN(Ncomps,length(PCAresults.time));
F323ContrastsP=NaN(Ncomps,length(PCAresults.time));
for component=1:Ncomps
    for bin=1:2:length(F3bins{component})
        thisbin=[F3bins{component}(bin) F3bins{component}(bin+1)];
        for slice=thisbin(1):thisbin(2)
            thisRM=squeeze(RMdata(component,slice,:));
            [F312ContrastsH(component,slice),F312ContrastsP(component,slice)] = ttest(thisRM(F3==1),thisRM(F3==2));
            [F313ContrastsH(component,slice),F313ContrastsP(component,slice)] = ttest(thisRM(F3==1),thisRM(F3==3));
            [F323ContrastsH(component,slice),F323ContrastsP(component,slice)] = ttest(thisRM(F3==3),thisRM(F3==2));
        end
    end
end
%correct contrast p-values for FDR
F312FDR=F312ContrastsP(~isnan(F312ContrastsP));
F313FDR=F313ContrastsP(~isnan(F313ContrastsP));
F323FDR=F323ContrastsP(~isnan(F323ContrastsP));
FDRmatrix=[F312FDR';F313FDR';F323FDR'];
[p_maskedF3, crit_pF3, adj_p]=fdr_bh(FDRmatrix,pcrit);
p_maskedF312=F312ContrastsP<=crit_pF3;
p_maskedF313=F313ContrastsP<=crit_pF3;
p_maskedF323=F323ContrastsP<=crit_pF3;
%find bins in each contrast (same method as above)
F312bins={};
F313bins={};
F323bins={};
for component=1:Ncomps
    temp=find(abs(diff(cat(2,0,p_maskedF312(component,:),0)')));%convert boolean vector of significance (0/1) to onsets/offsets
    temp(2:2:end)=temp(2:2:end)-1;%move offsets back by one point (correction for "diff" above).
    tempfilt=ones(length(temp),1);
    for i=1:2:length(temp)
        if temp(i+1)-temp(i)<Contiguity %For each bin, check if meets contiguity threshold and flip to zero if it doesn't
            tempfilt(i:i+1)=0;
        end
    end
    temp=temp(boolean(tempfilt));
    F312bins{component}=temp; 
    
    temp=find(abs(diff(cat(2,0,p_maskedF313(component,:),0)')));%convert boolean vector of significance (0/1) to onsets/offsets
    temp(2:2:end)=temp(2:2:end)-1;
    tempfilt=ones(length(temp),1);
    for i=1:2:length(temp)
        if temp(i+1)-temp(i)<Contiguity %For each bin, check if meets contiguity threshold and flip to zero if it doesn't
            tempfilt(i:i+1)=0;
        end
    end
    temp=temp(boolean(tempfilt));
    F313bins{component}=temp;

    temp=find(abs(diff(cat(2,0,p_maskedF323(component,:),0)')));%convert boolean vector of significance (0/1) to onsets/offsets
    temp(2:2:end)=temp(2:2:end)-1;%move offsets back by one point (correction for "diff" above).
    tempfilt=ones(length(temp),1);
    for i=1:2:length(temp)
        if temp(i+1)-temp(i)<Contiguity %For each bin, check if meets contiguity threshold and flip to zero if it doesn't
            tempfilt(i:i+1)=0;
        end
    end
    temp=temp(boolean(tempfilt));
    F323bins{component}=temp; 
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Winer X Bet Contrasts
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
F2AtF31H=NaN(Ncomps,length(PCAresults.time));%test main effect of winner at bet=1
F2AtF31P=NaN(Ncomps,length(PCAresults.time));
F2AtF32H=NaN(Ncomps,length(PCAresults.time));%test main effect of winner at bet=2
F2AtF32P=NaN(Ncomps,length(PCAresults.time));
F2AtF33H=NaN(Ncomps,length(PCAresults.time));%test main effect of winner at bet=2
F2AtF33P=NaN(Ncomps,length(PCAresults.time));
for component=1:Ncomps
    for bin=1:2:length(F3xF2bins{component})
        thisbin=[F3xF2bins{component}(bin) F3xF2bins{component}(bin+1)];
        for slice=thisbin(1):thisbin(2)
            thisRM=squeeze(RMdata(component,slice,:));
            [F2AtF31H(component,slice),F2AtF31P(component,slice)] = ttest(thisRM(F2==1&F3==1),thisRM(F2==2&F3==1));
            [F2AtF32H(component,slice),F2AtF32P(component,slice)] = ttest(thisRM(F2==1&F3==2),thisRM(F2==2&F3==2));
            [F2AtF33H(component,slice),F2AtF33P(component,slice)] = ttest(thisRM(F2==1&F3==3),thisRM(F2==2&F3==3));
        end
    end
end
%correct for FDR
F2AtF31FDR=F2AtF31P(~isnan(F2AtF31P));
F2AtF32FDR=F2AtF32P(~isnan(F2AtF32P));
F2AtF33FDR=F2AtF33P(~isnan(F2AtF33P));
FDRmatrix=[F2AtF31FDR';F2AtF32FDR';F2AtF33FDR'];
[p_maskedWxB, crit_pWxBin, adj_p]=fdr_bh(FDRmatrix,pcrit);
p_maskedF2AtF31=F2AtF31P<=crit_pWxBin;
p_maskedF2AtF32=F2AtF32P<=crit_pWxBin;
p_maskedF2AtF33=F2AtF33P<=crit_pWxBin;
%find bins in each contrast
F2F31bins={};
F2F32bins={};
F2F33bins={};
for component=1:Ncomps
    temp=find(abs(diff(cat(2,0,p_maskedF2AtF31(component,:),0)')));%convert boolean vector of significance (0/1) to onsets/offsets
    temp(2:2:end)=temp(2:2:end)-1;%move offsets back by one point (correction for "diff" above).
    tempfilt=ones(length(temp),1);
    for i=1:2:length(temp)
        if temp(i+1)-temp(i)<Contiguity %For each bin, check if meets contiguity threshold and flip to zero if it doesn't
            tempfilt(i:i+1)=0;
        end
    end
    temp=temp(boolean(tempfilt));
    F2F31bins{component}=temp; 
    
    temp=find(abs(diff(cat(2,0,p_maskedF2AtF32(component,:),0)')));%convert boolean vector of significance (0/1) to onsets/offsets
    temp(2:2:end)=temp(2:2:end)-1;
    tempfilt=ones(length(temp),1);
    for i=1:2:length(temp)
        if temp(i+1)-temp(i)<Contiguity %For each bin, check if meets contiguity threshold and flip to zero if it doesn't
            tempfilt(i:i+1)=0;
        end
    end
    temp=temp(boolean(tempfilt));
    F2F32bins{component}=temp;

    temp=find(abs(diff(cat(2,0,p_maskedF2AtF33(component,:),0)')));%convert boolean vector of significance (0/1) to onsets/offsets
    temp(2:2:end)=temp(2:2:end)-1;%move offsets back by one point (correction for "diff" above).
    tempfilt=ones(length(temp),1);
    for i=1:2:length(temp)
        if temp(i+1)-temp(i)<Contiguity %For each bin, check if meets contiguity threshold and flip to zero if it doesn't
            tempfilt(i:i+1)=0;
        end
    end
    temp=temp(boolean(tempfilt));
    F2F33bins{component}=temp; 
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Plot Results 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%generate condition averages for plotting

channels = length(chanlocs);

temp=reshape(PCAresults.Spatial.PmxScr',channels,length(PCAresults.time),size(PCAresults.Spatial.PmxScr,1)/length(PCAresults.time));
PCAScoreMeans=[];
for cond=1:Nconds
    for component=1:Ncomps
        PCAScoreMeans(component,:,cond)=squeeze(mean(temp(component,:,cond:Nconds:size(temp,3)),3));
    end
end
for component=1:spatialComponents
    figure
    H1=subplot(2,1,1);
    plot(PCAresults.time,squeeze(PCAScoreMeans(component,:,:))'*1000000,'LineWidth',3)
    legend([F3Clab{1},'/',F2Clab{1}],[F3Clab{1},'/',F2Clab{2}],[F3Clab{2},'/',F2Clab{1}],[F3Clab{2},'/',F2Clab{2}],[F3Clab{3},'/',F2Clab{1}],[F3Clab{3},'/',F2Clab{2}]);
    ThisBins=F3bins{component};
    bounds=get(gca,'YLim');
    axis tight
    ybounds=get(H1,'YLim');
    xbounds=get(gca,'xlim');
    line([xbounds(1) xbounds(2)],[0 0],'color','k');
    set(H1,'YLim',[ybounds(1)-.2 ybounds(2)+.2])
    line([0 0],[ybounds(1)-.2 ybounds(2)+.2],'color','k');
    set(gca,'FontSize',32,'LineWidth',3,'box','off')

%      %draw significant patches
%      for bin=1:2:length(ThisBins)
%          p=patch([PCAresults.time(ThisBins(bin)) PCAresults.time(ThisBins(bin+1)) PCAresults.time(ThisBins(bin+1)) PCAresults.time(ThisBins(bin))],[bounds(1) bounds(1) bounds(2) bounds(2)],'r');
%          set(p,'FaceAlpha',0.3,'LineStyle','none');
%      end
    H2=subplot(2,1,2);
    set(gca,'FontSize',32)
    plot(H2,PCAresults.time,zeros(length(PCAresults.time)))
    ax1=get(H1,'Position');
    ax1(2)=.3;
    ax1(4)=.6;
    set(H1,'Position',ax1)
    ax2=get(H2,'Position');
    ax2(4)=.14; %set subplot height
    ax2(2)=ax1(2)-ax2(4);
    xlim1=get(H1,'xlim');
    set(H2,'xlim',xlim1);
    set(H2,'Position',ax2)
    set(H1,'xticklabel',[]);
    set(H2,'yticklabel',[]);
    set(H2,'ylim',[0 1]);
    set(H2,'ytick',[])
    set(H1,'xtick',[])
    set(H2,'color',[.8 .8 .8])
    %PLOT STATS
    %Omnibus F3
    for bin=1:2:length(F3bins{component})
        line([PCAresults.time(F3bins{component}(bin)) PCAresults.time(F3bins{component}(bin+1))],[.1 .1],'color','k','linewidth',9);
        disp(['Omnibus ', F3lab]);
        disp(['Comp ' int2str(component) ', bin ' int2str(bin) ', start ' int2str(PCAresults.time(F3bins{component}(bin))) ', stop ' int2str(PCAresults.time(F3bins{component}(bin+1)))]);
    end
    %F3 Contrasts
    for bin=1:2:length(F312bins{component})
        line([PCAresults.time(F312bins{component}(bin)) PCAresults.time(F312bins{component}(bin+1))],[.2 .2],'color','r','linewidth',9);
        disp([F3lab,' 12_contrast'])
        disp(['Comp ' int2str(component) ', bin ' int2str(bin) ', start ' int2str(PCAresults.time(F312bins{component}(bin))) ', stop ' int2str(PCAresults.time(F312bins{component}(bin+1)))]);
    end
    for bin=1:2:length(F313bins{component})
        line([PCAresults.time(F313bins{component}(bin)) PCAresults.time(F313bins{component}(bin+1))],[.3 .3],'color','y','linewidth',9);
        disp([F3lab,' 13_contrast'])
        disp(['Comp ' int2str(component) ', bin ' int2str(bin) ', start ' int2str(PCAresults.time(F313bins{component}(bin))) ', stop ' int2str(PCAresults.time(F313bins{component}(bin+1)))]);
    end
    for bin=1:2:length(F323bins{component})
        line([PCAresults.time(F323bins{component}(bin)) PCAresults.time(F323bins{component}(bin+1))],[.4 .4],'color','m','linewidth',9);
        disp([F3lab, ' 23_contrast'])
        disp(['Comp ' int2str(component) ', bin ' int2str(bin) ', start ' int2str(PCAresults.time(F323bins{component}(bin))) ', stop ' int2str(PCAresults.time(F323bins{component}(bin+1)))]);
    end
        %Omnibus F2
    for bin=1:2:length(F2bins{component})
        line([PCAresults.time(F2bins{component}(bin)) PCAresults.time(F2bins{component}(bin+1))],[.5 .5],'color','b','linewidth',9);
        %plot([PCAresults.time(Wbins{component}(bin)):PCAresults.time(Wbins{component}(bin+1))],.1*ones(1,PCAresults.time(Wbins{component}(bin+1))-PCAresults.time(Wbins{component}(bin))+1),'color','r','linewidth',8);
        disp(['Omnibus ',F2lab])
        disp(['Comp ' int2str(component) ', bin ' int2str(bin) ', start ' int2str(PCAresults.time(F2bins{component}(bin))) ', stop ' int2str(PCAresults.time(F2bins{component}(bin+1)))]);
    end
        %Omnibus F3XF2
    for bin=1:2:length(F3xF2bins{component})
        line([PCAresults.time(F3xF2bins{component}(bin)) PCAresults.time(F3xF2bins{component}(bin+1))],[.6 .6],'color','g','linewidth',9);
        disp([F3lab,'x',F2lab])
        disp(['Comp ' int2str(component) ', bin ' int2str(bin) ', start ' int2str(PCAresults.time(F3xF2bins{component}(bin))) ', stop ' int2str(PCAresults.time(F3xF2bins{component}(bin+1)))]);
        %plot([PCAresults.time(Wbins{component}(bin)):PCAresults.time(Wbins{component}(bin+1))],.1*ones(1,PCAresults.time(Wbins{component}(bin+1))-PCAresults.time(Wbins{component}(bin))+1),'color','r','linewidth',8);
    end
        %Contrasts F3XF2
    for bin=1:2:length(F2F31bins{component})
        line([PCAresults.time(F2F31bins{component}(bin)) PCAresults.time(F2F31bins{component}(bin+1))],[.7 .7],'color',[1 1 1],'linewidth',9);
        disp([F2lab,'@',F3lab,'1'])
        disp(['Comp ' int2str(component) ', bin ' int2str(bin) ', start ' int2str(PCAresults.time(F2F31bins{component}(bin))) ', stop ' int2str(PCAresults.time(F2F31bins{component}(bin+1)))]);
        %plot([PCAresults.time(Wbins{component}(bin)):PCAresults.time(Wbins{component}(bin+1))],.1*ones(1,PCAresults.time(Wbins{component}(bin+1))-PCAresults.time(Wbins{component}(bin))+1),'color','r','linewidth',8);
    end
    for bin=1:2:length(F2F32bins{component})
        line([PCAresults.time(F2F32bins{component}(bin)) PCAresults.time(F2F32bins{component}(bin+1))],[.8 .8],'color',[1 .5 0],'linewidth',9);
        disp([F2lab,'@',F3lab,'2'])
        disp(['Comp ' int2str(component) ', bin ' int2str(bin) ', start ' int2str(PCAresults.time(F2F32bins{component}(bin))) ', stop ' int2str(PCAresults.time(F2F32bins{component}(bin+1)))]);
        %plot([PCAresults.time(Wbins{component}(bin)):PCAresults.time(Wbins{component}(bin+1))],.1*ones(1,PCAresults.time(Wbins{component}(bin+1))-PCAresults.time(Wbins{component}(bin))+1),'color','r','linewidth',8);
    end
    for bin=1:2:length(F2F33bins{component})
        line([PCAresults.time(F2F33bins{component}(bin)) PCAresults.time(F2F33bins{component}(bin+1))],[.9 .9],'color','y','linewidth',9);
        disp([F2lab,'@',F3lab,'3'])
        disp(['Comp ' int2str(component) ', bin ' int2str(bin) ', start ' int2str(PCAresults.time(F2F33bins{component}(bin))) ', stop ' int2str(PCAresults.time(F2F33bins{component}(bin+1)))]);
        %plot([PCAresults.time(Wbins{component}(bin)):PCAresults.time(Wbins{component}(bin+1))],.1*ones(1,PCAresults.time(Wbins{component}(bin+1))-PCAresults.time(Wbins{component}(bin))+1),'color','r','linewidth',8);
    end
    [legh,objh,outh,outm]=legend(H2,['Omnibus ',F3lab],[F3Clab{1},'/',F3Clab{2}],[F3Clab{2},'/',F3Clab{3}],[F3Clab{1},'/',F3Clab{3}],['Omnibus ', F2lab],[F3lab,'x',F2lab],[F2lab,'@',F3Clab{1}],[F2lab,'@',F3Clab{2}],[F2lab,'@',F3Clab{3}]);
    set(objh,'linewidth',5);
    set(gcf,'color','white')
end

if exist('chanlocs')==1
    topofig=figure;
    figdim=ceil(sqrt(Ncomps));
    for i=1:spatialComponents
        subplot(figdim,figdim,i)
        topoplot(PCAresults.Spatial.PmxPat(:,i),chanlocs);
    end
end

