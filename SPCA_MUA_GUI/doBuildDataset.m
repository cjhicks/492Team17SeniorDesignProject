function [ dataset ] = doBuildDataset( inputDir, inputFile )
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

dataset = [];

%   While this line is valid
while ischar(thisLine)
    disp(strcat(inputDir, thisLine)); % display this line as full path
    
    thisSubjectConditionData = load(strcat(inputDir, thisLine));
    dataset = cat(1, dataset, thisSubjectConditionData);
    
    thisLine = fgets(fileID);   % get next line
end

fclose(fileID); % close file

%   write dataset eventually
disp(dataset);
end

