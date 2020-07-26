function [estimation, check] = Test_rejection(calibration, S, makePlot)
%{
Perform clustering on the event localizations of the ROI 
    using the three algorithms (error ellipse, DBSCAN,
    GMM), and save the amount of false positives and negatives.

INPUTS
-------
calibration:  struct containing the names of the calibration files that 
    should be used. In this case only DBSCAN calibration. 
S: information that was loaded in from the dataset to which the ROI
    corresponds
makePlot: do not make plot (if 0), or do make plot (if 1)

OUTPUTS 
------
estimation: struct containing the estimation of the number of binding sites
    and of the ratio of specific to non-specific events
check: struct containing the amount of false positives and false negatives
    for each method

Created by Tanya van Horen - July 2020
%}

%% Load data
ROIs=S.ROIs;
ana=S.ana;
i=S.i;
set=S.set;
time_trace_data=S.time_trace_data;
time_trace_data_non=S.time_trace_data_non;
time_trace_data_spec=S.time_trace_data_spec;
check = [];
k=1;

%% Parameters
rej.outlier_factor=1.5; %outlier rejection for d>d_av+..*sqrt(d_av)
rej.edge_point_distance=inf; %points further away than this radius from the center are not considered for DBSCAN
rej.number_gaussians=2; %number of Gaussians fitted within GMM

ana = determine_category_events(ana, time_trace_data_non, time_trace_data_spec, i, makePlot, set, ROIs);

%% Estimation ratio and binding sites
estimation = estimation_sites_and_ratio(ana,set,i,rej);

%% Outlier rejection
ana = reject_outliers(ana, i, set, ROIs, makePlot, rej);

%% Default (k=1)
[ana, check] = event_rejection_default(ana, i, set, ROIs, makePlot, k, check);
k=k+1;

%% DBSCAN (k=2)
rej = choice_of_dbscan_params(calibration, estimation, set, rej);
[ana, check] = event_rejection_dbscan(ana, i, set, ROIs, makePlot, k, check, rej);
k=k+1;

%% GMM (k=3)
[ana, check] = event_rejection_gmm(ana, i, set, ROIs, makePlot, k, check, rej);
k=k+1;

end