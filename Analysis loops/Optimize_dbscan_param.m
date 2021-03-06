function check = Optimize_dbscan_param(S, makePlot)
%{
Perform DBSCAN clustering on a single ROI. Check the results at the end. 

INPUTS
-------
S: information that was loaded in from the dataset to which the ROI
    corresponds
makePlot: do not make plot (if 0), or do make plot (if 1)

OUTPUTS 
------
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

%% Parameters
rej.edge_point_distance=inf; %points further away than this radius from the center are not considered for DBSCAN
rej.dbscan_minPts=S.rej.dbscan_minPts;
rej.dbscan_eps=S.rej.dbscan_eps;

ana = determine_category_events(ana, time_trace_data_non, time_trace_data_spec, i, makePlot, set, ROIs);
check = [];
k=2;

%% DBSCAN, k=2: wo error ellipse
[ana, check] = event_rejection_dbscan(ana, i, set, ROIs, makePlot, k, check, rej);
k=k+1;

end