function ana = Nbind_rejection(calibration, S, makePlot)

%% Load data
ROIs=S.ROIs;
ana=S.ana;
i=S.i;
set=S.set;
time_trace_data=S.time_trace_data;
time_trace_data_non=S.time_trace_data_non;
time_trace_data_spec=S.time_trace_data_spec;
check = [];

%% Parameters
rej.outlier_factor=1.5; %outlier rejection for d>d_av+..*sqrt(d_av)
rej.edge_point_distance=set.ROI.size/2; %points further away than this radius from the center are not considered for DBSCAN
rej.number_gaussians=2; %number of Gaussians fitted within GMM

ana = determine_category_events(ana, time_trace_data_non, time_trace_data_spec, i, makePlot, set, ROIs);

%% Estimation ratio and binding sites
estimation = estimation_sites_and_ratio(ana,set,i,rej);
k = choice_of_method(calibration, estimation, set);

%% Outlier rejection
if k==1 || k==2
ana = reject_outliers(ana, i, set, ROIs, makePlot, rej);
end

%% Default (k=1)
if k==1
[ana, check] = event_rejection_default(ana, i, set, ROIs, makePlot, k, check);
end

%% DBSCAN (k=2)
if k==2
rej = choice_of_dbscan_params(calibration, estimation, set, rej);
[ana, check] = event_rejection_dbscan(ana, i, set, ROIs, makePlot, k, check, rej);
end

%% GMM (k=3)
if k==3
[ana, check] = event_rejection_gmm(ana, i, set, ROIs, makePlot, k, check, rej);
end

%% Event rejection 
ana = reject_bright_dark(ana, i, k);
ana = determine_corr_averages_and_binding_spots(ana, set, i);
end