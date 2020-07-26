function [ana, check] = event_rejection_default(ana, i, set, ROIs, makePlot, k, check)
%{
Classify event localizations using Error Ellipse fitting, 
    and subsequently determine the amount of false positives and false 
    negatives. 

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
tic;
[ana.ROI(i).SupResParams.isRej_DEFAULT]=ana.outlier.logical{:};
ana = reject_outside_ellipse(ana,i, set, ROIs, makePlot);
check = determine_tf_pn(ana, i, k, check);
check(k).time = toc;
end