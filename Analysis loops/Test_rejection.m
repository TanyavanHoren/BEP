function [estimation, check] = Test_rejection(calibration, S, makePlot)

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
rej.edge_point_distance=set.ROI.size/2; %points further away than this radius from the center are not considered for DBSCAN
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