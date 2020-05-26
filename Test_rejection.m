%files: non: 05, 1, 10
%       bind: 5, 20, 100
clear all
close all
clc

load ('non1bind5')
ana = determine_category_events(ana, time_trace_data_non, time_trace_data_spec, i);
k=1;

%% Matej v2 (first row)
ana = reject_outliers_temp(ana, i, set, ROIs);
ana = reject_outside_ellipse_temp(ana,i, set, ROIs);
check = determine_tf_pn_temp(ana, i, k);
k=k+1;

%% DBSCAN
%wo outlier rejection, wo addiditional clustering, wo ellipse fit -> find the biggest cluster
idx_dbscan = function_dbscan_temp(ana, set, ROIs, i);
[GC_dbscan,GR_dbscan] = groupcounts(idx_dbscan);
list_dbscan = [GR_dbscan GC_dbscan];
list_dbscan = list_dbscan(2:length(list_dbscan),:);
GC_dbscan = list_dbscan(:,2);
GR_dbscan = list_dbscan(:,1);
for l=1:length(list_dbscan)
    if GC_dbscan(l)==max(GC_dbscan)
       idx_max_dbscan = GR_dbscan(l);
    end
end
logical = num2cell(idx_dbscan'~=idx_max_dbscan.*ones(1,length(ana.ROI(i).SupResParams)));
[ana.ROI(i).SupResParams.isOutlierDBSCAN]=logical{:};
check = determine_tf_pn_temp_DBSCAN(ana, i, k, check);
k=k+1;

%% GMM
idx_gmm = function_gmm_temp(ana, set, ROIs, i);
[GC_gmm,GR_gmm] = groupcounts(idx_gmm);
list_gmm = [GR_gmm GC_gmm];
GC_gmm = list_gmm(:,2);
GR_gmm = list_gmm(:,1);
for l=1:length(list_gmm)
    if GC_gmm(l)==max(GC_gmm)
       idx_max_gmm = GR_gmm(l);
    end
end
logical = num2cell(idx_gmm'~=idx_max_gmm.*ones(1,length(ana.ROI(i).SupResParams)));
[ana.ROI(i).SupResParams.isOutlierGMM]=logical{:};
check = determine_tf_pn_temp_GMM(ana, i, k, check);
k=k+1;