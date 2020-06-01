clear all
close all
clc

%% Give datasets to analyze 
%workspaces=["non05bind5.mat", "non05bind20.mat", "non05bind100.mat", "non1bind5.mat", "non1bind20.mat", "non1bind100.mat", "non10bind5.mat", "non10bind20.mat", "non10bind100.mat"];
workspaces=["non10bind100.mat"];

%% Determine false/true positives/negatives
for i=1:size(workspaces,2)
    S = load(workspaces(i));
    checks.dataset(i).check = Test_rejection(S,1);
end

%% Plot result false positives 
false_positives=[];
counter = 1;
for i=1:size(workspaces,2)
    false_positives(counter,:)=[checks.dataset(i).check.false_pos];
    counter=counter+1;
end
figure
bar(false_positives)
legend('Method 1','Method 2', 'Method 3', 'Method 4', 'Method 5', 'Method 6', 'Method 7', 'Method 8');
xlabel('Dataset')
ylabel('Relative number of false positives')
box on
title('False positives')

%% Plot result false negatives
false_negatives=[];
counter = 1;
for i=1:size(workspaces,2)
    false_negatives(counter,:)=[checks.dataset(i).check.false_neg];
    counter=counter+1;
end
figure
bar(false_negatives)
legend('Method 1','Method 2', 'Method 3', 'Method 4', 'Method 5', 'Method 6', 'Method 7', 'Method 8');
xlabel('Dataset')
ylabel('Relative number of false negatives')
box on
title('False negatives')