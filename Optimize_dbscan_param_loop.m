clear all
close all
clc

%% Give datasets to analyze 
%workspaces=["non05bind5.mat", "non05bind20.mat", "non05bind100.mat", "non1bind5.mat", "non1bind20.mat", "non1bind100.mat", "non10bind5.mat", "non10bind20.mat", "non10bind100.mat"];
workspaces=["non05bind5.mat"];

%% Give minPts and EPS to use for analysis
minPts=20:1:70;
eps=0.01:0.005:0.2;

%% Find number of false positives/negatives for each combination of minPts and EPS
for i=1:size(workspaces,2)
    S = load(workspaces(i));
    false_pos.dataset(i).dbscan=[];
    false_neg.dataset(i).dbscan=[];
    for m=1:size(eps,2) %rows are determined by y-variable
        for n=1:size(minPts,2) %columns are determined by x-variable 
            S.rej.dbscan_minPts=minPts(n);
            S.rej.dbscan_eps=eps(m);
            % Determine false/true positives/negatives
            checks.dataset(i).check = Test_rejection(S,0,1);
            false_pos.dataset(i).dbscan(m,n)=checks.dataset(i).check.false_pos;
            false_neg.dataset(i).dbscan(m,n)=checks.dataset(i).check.false_neg;
        end
    end
    % Plot results in surface plot
    figure
    surf(minPts, eps, false_pos.dataset(i).dbscan);
    xlabel('minPts');
    ylabel('eps');
    zlabel('False positives');
    box on
    figure
    surf(minPts, eps, false_neg.dataset(i).dbscan);
    xlabel('minPts');
    ylabel('eps');
    zlabel('False negatives');
    box on
end