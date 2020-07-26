function [ana, check] = event_rejection_gmm(ana, i, set, ROIs, makePlot, k, check, rej)
%{
Classify event localizations using GMM, and subsequently determine
    the amount of false positives and false negatives. 

INPUTS
-------
ana: struct containing results from analysis, such as the
    event classifications
i: index of considered ROI
set: system settings
ROIs: settings for the considered ROI specifically
makePlot: do not make plot (if 0), or do make plot (if 1)
index of the method that is considered (1:Error ellipse, 2:DBSCAN, 3:GMM)
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
gmm_var = function_gmm(ana, set, ROIs, i, makePlot, rej);
if gmm_var.fit_failed==0
    ana = determine_central_cluster(ana, gmm_var, i, makePlot, ROIs, set);
else
    logical = num2cell(false(1,size(ana.ROI(i).SupResParams,2)));
    [ana.ROI(i).SupResParams.isRej_GMM]=logical{:};
end
check = determine_tf_pn(ana, i, k, check);
check(k).time = toc;
end