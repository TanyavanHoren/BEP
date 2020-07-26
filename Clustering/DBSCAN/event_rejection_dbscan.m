function [ana, check] = event_rejection_dbscan(ana, i, set, ROIs, makePlot, k, check, rej)
%{
Classify event localizations using DBSCAN, and subsequently determine
    the amount of false positives and false negatives. 

INPUTS
-------
ana: struct containing results from analysis, such as the
    event classifications
i: index of considered ROI
set: system settings
ROIs: settings for the considered ROI specifically
makePlot: do not make plot (if 0), or do make plot (if 1)
k: index of the method that is considered (1:Error ellipse, 2:DBSCAN, 3:GMM)
check: struct containing the amount of false positives and false negatives
    for each method
rej: settings for clustering

OUTPUTS 
------
ana: struct containing results from analysis, such as the updated
    event classifications
check: struct containing the amount of false positives and false negatives
    for each method (updated)

Created by Tanya van Horen - July 2020
%}

%%
tic
ana = reject_edge_points_dbscan(ana, i, rej);
[ana.ROI(i).SupResParams.isRej_DBSCAN]=ana.edge_points.logical{:}; 
dbscan_var = function_dbscan(ana, set, ROIs, i, makePlot, rej);
ana = merge_clusters(dbscan_var, set, i, ana, makePlot, ROIs);
check = determine_tf_pn(ana, i, k, check);
check(k).time = toc;
end