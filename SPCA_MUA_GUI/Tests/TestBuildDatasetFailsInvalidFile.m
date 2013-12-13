function TestBuildDatasetFailsInvalidFile
% Test class to ensure Build dataset fails on an invalid file path

          buildDatasetModel = BuildDatasetModel();
          buildDatasetModel.numberOfSubjects = 10;
          buildDatasetModel.numberOfConditions = 5;
          buildDatasetModel.inputDirName = '10SubjectDirectory.txt';
          buildDatasetModel.inputDirPath = 'C:\InvalidFilePath\SampleData10Subjects\';
          [count] = buildDatasetModel.doBuildDataset();
          assertFalse(count == buildDatasetModel.numberOfSubjects*buildDatasetModel.numberOfConditions);
end

