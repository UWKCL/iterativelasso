function [numTrials, numExpTrials] = testCondsData()
%% this function runs some test for the jlp fmri data 

    % check if the folder 'conds' is in the working dir
    if exist('conds','dir') ~= 7
        disp('WARNING: this function only runs when the folder "conds"');
    end

    for subNum = 1:10
        % read the raw data file 
        filename = sprintf('conds/jlp%.2d_conds.csv',subNum);
        condsData = csvread(filename);
        
        %% check if every subject has the same number of trials
        if subNum == 1
            numTrials = size(condsData,2);
        else 
            if numTrials ~= size(condsData,2);
                disp('WARNING: number of trials mismatch');
            end
        end
        
        %% check if each condition has 150 trials, for every subject
        for row = 1:3
            if (sum(condsData(row,:) == 1) ~= 150)
                msg = sprintf('WARNING: %d row subject %.2d != 150', row, subNum);
                disp(msg);
            end
        end

        %% check if every subjects has 450 experimental trials (face/place/object)
        numExpTrials = 0;
        for col = 1 : numTrials;
            temp = condsData(:,col);
            for row = 1:3
                if temp(row, 1) == 1
        %             disp('ERROR!');
                    numExpTrials = numExpTrials + 1;
                end
            end
        end
        if numExpTrials ~= 450
            msg = sprinf('WARNING: subject %2.d experimental trials != 450', subNum);
            disp(msg);
        end
    
    end % end of the outter for loop
    disp('End of the test!');
    
end

