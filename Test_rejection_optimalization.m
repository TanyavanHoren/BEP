function check = Test_rejection_optimalization(S, makePlot)
%% Parameters
rej.outlier_std_factor=5; %outlier rejection for d>d_av+..*sqrt(d_av)
rej.cluster_std_factor=7; %rejection clusters with number of localizations n<n_min_av-..*sqrt(n_min_av)
rej.number_gaussians=2; %number of Gaussians fitted within GMM
rej.dbscan_minPts=S.rej.dbscan_minPts;
rej.dbscan_eps=S.rej.dbscan_eps;

%% Load data
ROIs=S.ROIs;
ana=S.ana;
i=S.i;
set=S.set;
time_trace_data=S.time_trace_data;
time_trace_data_non=S.time_trace_data_non;
time_trace_data_spec=S.time_trace_data_spec;
ana = determine_category_events(ana, time_trace_data_non, time_trace_data_spec, i);
check = [];
k=2;

%% Outlier rejection
ana = reject_outliers(ana, i, set, ROIs, makePlot, rej);

%% DBSCAN, k=2: wo error ellipse
[ana, check] = event_rejection_dbscan1(ana, i, set, ROIs, makePlot, k, check, rej);
k=k+1;

end