function TestBuildDatasetPassesNormally
% Test that Build Dataset Passes under normal conditions

          buildDatasetModel = BuildDatasetModel();
          buildDatasetModel.numberOfSubjects = 10;
          buildDatasetModel.numberOfConditions = 6;
          buildDatasetModel.inputDirName = '10SubjectDirectory.txt';
          buildDatasetModel.inputDirPath = 'C:\Users\Chris\Documents\GitHub\492Team17SeniorDesignProject\SampleData10Subjects\';
          [count] = buildDatasetModel.doBuildDataset();
          assertEqual(count, buildDatasetModel.numberOfSubjects*buildDatasetModel.numberOfConditions);
end

