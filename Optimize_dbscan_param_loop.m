clear all
close all
clc

%% Give datasets to analyze 
workspaces=["non05bind5.mat", "non05bind20.mat", "non05bind100.mat", "non1bind5.mat", "non1bind20.mat", "non1bind100.mat", "non10bind5.mat", "non10bind20.mat", "non10bind100.mat"];
%workspaces=["non05bind5.mat"];

%% Give minPts and EPS to use for analysis
% minPts=20:1:70;
% eps=0.01:0.005:   0.2;
minPts=20:5:70;
eps=0.05:0.004:0.15;

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
            checks.dataset(i).check = Test_rejection_optimalization(S,0);
            % Delete empty row corresponding to k=1
            checks.dataset(i).check( all( cell2mat( arrayfun( @(x) structfun( @isempty, x ), checks.dataset(i).check, 'UniformOutput', false ) ), 1 ) ) = [];
            false_pos.dataset(i).dbscan(m,n)=checks.dataset(i).check.false_pos;
            false_neg.dataset(i).dbscan(m,n)=checks.dataset(i).check.false_neg;
            false_av.dataset(i).dbscan(m,n)=(checks.dataset(i).check.false_pos+checks.dataset(i).check.false_neg)/2;
        end
    end
end

%% Plot results in surface plot
for i=1:size(workspaces,2)
%     figure
%     surf(minPts, eps, false_pos.dataset(i).dbscan);
%     xlabel('minPts');
%     ylabel('eps');
%     zlabel('False positives');
%     box on

%     figure
%     surf(minPts, eps, false_neg.dataset(i).dbscan);
%     xlabel('minPts');
%     ylabel('eps');
%     zlabel('False negatives');
%     box on

    figure
    surf(minPts, eps, false_av.dataset(i).dbscan);
    xlabel('minPts');
    ylabel('eps');
    zlabel('Average false positives and negatives');
    box on
end
%% Average over all datasets
false_av_tot=zeros(size(eps,2),size(minPts,2));
for i=1:size(workspaces,2)
    false_av_tot = false_av_tot+false_av.dataset(i).dbscan;
end
false_av_tot_av=false_av_tot./size(workspaces,2);
figure
surf(minPts, eps, false_av_tot_av);
xlabel('minPts');
ylabel('eps');
zlabel('Average false positives and negatives - averaged over datasets');
box on