function TestBuildDatasetFailsSubjectConditionMismatch
% Test class to ensure Build dataset fails on a subject/condition mismatch

          buildDatasetModel = BuildDatasetModel();
          buildDatasetModel.numberOfSubjects = 10;
          buildDatasetModel.numberOfConditions = 5;
          buildDatasetModel.inputDirName = '10SubjectDirectory.txt';
          buildDatasetModel.inputDirPath = 'C:\Users\Public\Documents\GitHub\492Team17SeniorDesignProject\SampleData10Subjects\';
          [count] = buildDatasetModel.doBuildDataset();
          assertFalse(count == buildDatasetModel.numberOfSubjects*buildDatasetModel.numberOfConditions);
end

