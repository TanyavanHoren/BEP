function [estimation, check] = Test_rejection(S, makePlot)
%% Parameters
rej.outlier_std_factor=5; %outlier rejection for d>d_av+..*sqrt(d_av)
rej.cluster_std_factor=7; %rejection clusters with number of localizations n<n_min_av-..*sqrt(n_min_av)
rej.number_gaussians=2; %number of Gaussians fitted within GMM
rej.dbscan_minPts=30;
rej.dbscan_eps=0.1;

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

ana = determine_category_events(ana, time_trace_data_non, time_trace_data_spec, i);
ratio_actual = ana.ROI(i).numSpecific/ana.ROI(i).numNonSpecific;

%% Estimation ratio and binding sites
estimation=estimation_sites_and_ratio(ana,set,i);

%% Outlier rejection
ana = reject_outliers(ana, i, set, ROIs, makePlot, rej);

%% Default (k=1)
[ana, check] = event_rejection_default(ana, i, set, ROIs, makePlot, k, check);
k=k+1;

%% DBSCAN (k=2 wo error ellipse, k=3 with)
[ana, check] = event_rejection_dbscan1(ana, i, set, ROIs, makePlot, k, check, rej);
k=k+1;
[ana, check] = event_rejection_dbscan2(ana, i, set, ROIs, makePlot, k, check, rej);
k=k+1;

%% GMM (k=4 wo error ellipse, k=5 with)
[ana, check] = event_rejection_gmm1(ana, i, set, ROIs, makePlot, k, check, rej);
k=k+1;
[~, check] = event_rejection_gmm2(ana, i, set, ROIs, makePlot, k, check, rej);
k=k+1;

end