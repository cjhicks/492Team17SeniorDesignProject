%Prepare Data for PCAMUA
function [PCAdata,subID]=PCAMUA_DataPrep(Nsubs,Nconds)

% [filename, pathname, filterindex] = uigetfile('Pick a file','MultiSelect', 'on');
% prompttext=['Please input a list of condition identifiers\n' ...
%     'that can be found in the filenames of ALL files.\n' ...
%     'Be sure to list the condition identifiers inside\n' ...
%     'curly braces and separated by commas in the order\n' ...
%     'F1L1F2L1 F1L2F2L1...F1L1F2L3 F1L2F2L3 where\n' ...
%     'F=factor, L=level'];
% ConditionOrder=input(prompttext);
% 
% for cond=1:length(ConditionOrder)
%     thiscond=ConditionOrder{cond};
%     filesmeetcond=strfind(filename,thiscond);
%     for fil=1:length(filesmeetcond)
%         if ~isempty(filesmeetcond{fil})
%BRAIN FRIED
subID={};
PCAdata=[];
for sub=1:Nsubs
    thissub=[];
    for F3L=1:3
        message=['Select the file for level \b{1} of 2-level Factor and' ...
            'level ',int2str(F3L),' of 3-level Factor'];
        [filename1, pathname1, filterindex] = uigetfile('*',message);
        
        message=['Select the file for level 2 of 2-level Factor and' ...
            'level ',int2str(F3L),' of 3-level Factor'];
        [filename2, pathname2, filterindex] = uigetfile('*',message);
        
        Data1=load(fullfile(pathname1,filename1));
        Data2=load(fullfile(pathname2,filename2));
        if size(Data1,1)~=size(Data2,1) | size(Data1,2)~=size(Data2,2)
            disp('Data dimensions do not agree!')
        end
        if size(Data1,1)<size(Data1,2)
            disp('Data appear to be channelsXtime...transposing');
            Data1=Data1';
        end
        if size(Data2,1)<size(Data2,2)
            disp('Data appear to be channelsXtime...transposing');
            Data1=Data2';
        end
        thissub=cat(1,thissub,Data1,Data2);
    end
    PCAdata=cat(1,PCAdata,thissub);
    subID{sub,1}=sub;
    subID{sub,2}=filename1;
end


            