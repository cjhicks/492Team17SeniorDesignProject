function [ dataset, count ] = doBuildDataset( inputDir, inputFile )
%BUILDDATASET Summary of this function goes here
%   Builds dataset from directory file.
%   This will read in directory file, and  
%   open each file in the directory (in order),
%   then concatinate it to the dataset.
%   Finally, this function will output a dataset
%   as a .MAT file

% create full file path
fullFilePath = strcat(inputDir, inputFile);

fileID = fopen(fullFilePath); % Open file
thisLine = fgets(fileID); % Get first line

% init dataset
dataset = [];

% init waitbar
wBar = waitbar(0,'Please wait, Building Dataset...');
Nrows = numel(textread(fullFilePath,'%1c%*[^\n]'));
count = 0;

%   While this line is valid
while ischar(thisLine) 
    % do build
    disp(strcat(inputDir, thisLine)); % display this line as full path
    
    thisSubjectConditionData = load(strcat(inputDir, thisLine));
    dataset = cat(1, dataset, thisSubjectConditionData);
    
    thisLine = fgets(fileID);   % get next line
    
    % update wait bar
    count = count + 1;
    waitbar(count/Nrows);
end

close(wBar);
fclose(fileID); % close file

%   write dataset eventually
disp(dataset);
end

