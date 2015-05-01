clc; clear; 

% read the condition data, which indicates which trials contains meaningful
% stimuli
load('jlp_functionalImages_metadata/experimentalTrialsIndices.mat')

for subID = 1:1;
    % read the full functional data file 
    filename = sprintf('jlp%.2d_hc.mat', subID);
    load(filename);
    % subset full functional data with the condition data 
    X = X(expTrialsIndex',:);
    % save the new subsetted X with other old data into a folder
%     savedFilename = sprintf('jlp%.2d_hc_X_conds.mat', subID);
%     save(['selectedFunctionalData/' savedFilename], 'info','X','cortex','IJK')

end
