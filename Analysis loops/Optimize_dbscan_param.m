function check = Optimize_dbscan_param(S, makePlot)
%% Parameters
rej.outlier_factor=1.5; %outlier rejection for d>d_av+..*sqrt(d_av)
rej.cluster_std_factor=3; %rejection clusters with number of localizations n<n_min_av-..*sqrt(n_min_av)
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
ana = determine_category_events(ana, time_trace_data_non, time_trace_data_spec, i, makePlot, set, ROIs);
check = [];
k=2;

%% Outlier rejection
ana = reject_outliers(ana, i, set, ROIs, makePlot, rej);

%% DBSCAN, k=2: wo error ellipse
[ana, check] = event_rejection_dbscan(ana, i, set, ROIs, makePlot, k, check, rej);
k=k+1;

end