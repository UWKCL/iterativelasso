
clear;

load('../jlp_metadata.mat');
numSubjects = size(metadata,2);
% run some tests
% and get num of total trials (1170) and num of experiment tirals (450)
[numTrials, numExptrials] = testCondsData();
stimuliTrials = NaN(numTrials, numSubjects);
for subNum = 1:numSubjects;
    % read the raw data file 
    filename = sprintf('conds/jlp%.2d_conds.csv',subNum);
    condsData = csvread(filename);

    % preallocate 
    expTrialsIndex = zeros(1,numTrials);
    % select columns that contains "1" (i.e. indentify experimental trials)
    for col = 1 : numTrials;
        temp = condsData(:,col);
        % check face, place & object row 
        for row = 1:3
            if temp(row, 1) == 1
                % mark the experimental trials
                expTrialsIndex(col) = 1;
                % convert it to logical type
                expTrialsIndex = logical(expTrialsIndex);
            end
        end
    end

    temp = condsData(1,:);
    % subset it using the logical vector that just created 
    temp = temp(expTrialsIndex)';
    stimuliTrials(:,subNum) = expTrialsIndex';
    % test if they are the same as the originalca metadata 
    if ~all(temp == metadata(subNum).TrueFaces)
        msg = sprinf('ERROR: Subject $d face != the metadata', subNum);
        disp(msg)
    end

end

disp('No error is displayed means the condition data match')
disp('Next: start subsetting fmri data with the conditions')


