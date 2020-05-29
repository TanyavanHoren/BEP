function check = Test_rejection(S, makePlot)
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
ana = determine_category_events(ana, time_trace_data_non, time_trace_data_spec, i);
k=1;

%% Outlier rejection 
ana = reject_outliers(ana, i, set, ROIs, makePlot, rej);

%% Default 
check = event_rejection_default(ana, i, set, ROIs, makePlot, k);
k=k+1;

%% DBSCAN 1
%wo outlier rejection, wo addiditional clustering, wo ellipse fit -> find the biggest cluster
tic
idx_dbscan = function_dbscan_temp(ana, set, ROIs, i, makePlot, rej);
[GC_dbscan,GR_dbscan] = groupcounts(idx_dbscan);
list_dbscan = [GR_dbscan GC_dbscan];
list_dbscan = list_dbscan(2:length(list_dbscan),:);
GC_dbscan = list_dbscan(:,2);
GR_dbscan = list_dbscan(:,1);
for l=1:size(list_dbscan,1)
    if GC_dbscan(l)==max(GC_dbscan)
       idx_right_dbscan = GR_dbscan(l);
    end
end
logical = num2cell(idx_dbscan'~=idx_right_dbscan.*ones(1,length(ana.ROI(i).SupResParams)));
[ana.ROI(i).SupResParams.isOutlier_DBSCAN]=logical{:};
check = determine_tf_pn_temp_DBSCAN(ana, i, k, check);
check(k).time = toc;
k=k+1;

%% DBSCAN 2
%wo outlier rejection, w addiditional clustering (radius+min number events), wo ellipse fit
tic 
idx_dbscan = function_dbscan_temp(ana, set, ROIs, i, makePlot, rej);
[GC_dbscan,GR_dbscan] = groupcounts(idx_dbscan);
list_dbscan = [GR_dbscan GC_dbscan];
list_dbscan = list_dbscan(2:length(list_dbscan),:);
GC_dbscan = list_dbscan(:,2);
GR_dbscan = list_dbscan(:,1);
av_localizations_single_site = set.sample.tb*set.mic.frames/(set.sample.tb+set.sample.td);
list_dbscan(GC_dbscan<av_localizations_single_site-rej.cluster_std_factor*sqrt(av_localizations_single_site),:)=[];
logical=num2cell(abs(ismember(idx_dbscan,list_dbscan(:,1))-1));
[ana.ROI(i).SupResParams.isOutlier_DBSCAN2]=logical{:};
check = determine_tf_pn_temp_DBSCAN2(ana, i, k, check);
check(k).time = toc;
k=k+1;

%% DBSCAN 3
%wo outlier rejection, w addiditional clustering (radius+min number events), w ellipse fit
tic 
idx_dbscan = function_dbscan_temp(ana, set, ROIs, i, makePlot, rej);
[GC_dbscan,GR_dbscan] = groupcounts(idx_dbscan);
list_dbscan = [GR_dbscan GC_dbscan];
list_dbscan = list_dbscan(2:length(list_dbscan),:);
GC_dbscan = list_dbscan(:,2);
GR_dbscan = list_dbscan(:,1);
av_localizations_single_site = set.sample.tb*set.mic.frames/(set.sample.tb+set.sample.td);
list_dbscan(GC_dbscan<av_localizations_single_site-rej.cluster_std_factor*sqrt(av_localizations_single_site),:)=[];
logical=num2cell(abs(ismember(idx_dbscan,list_dbscan(:,1))-1));
[ana.ROI(i).SupResParams.isOutlier_DBSCAN3]=logical{:};
%Fit an error ellipse to the points within the merged cluster 
%Find all points within ellipse (also those not belonging to central cluster)
ana = reject_outside_ellipse_temp_dbscan3(ana,i, set, ROIs, makePlot);
check = determine_tf_pn_temp_DBSCAN3(ana, i, k, check);
check(k).time = toc;
k=k+1;

%% DBSCAN 4
%w outlier rejection, wo addiditional clustering, wo ellipse fit
tic 
ana = reject_outliers_temp_dbscan4(ana, i, set, ROIs, makePlot, rej); %reject outliers from dbscan4 data
idx_dbscan = function_dbscan4_temp(ana, set, ROIs, i, makePlot, rej); %determine idx non-outlier data 
[GC_dbscan,GR_dbscan] = groupcounts(idx_dbscan);
list_dbscan = [GR_dbscan GC_dbscan];
list_dbscan = list_dbscan(2:length(list_dbscan),:);
GC_dbscan = list_dbscan(:,2);
GR_dbscan = list_dbscan(:,1);
for l=1:size(list_dbscan,1)
    if GC_dbscan(l)==max(GC_dbscan)
       idx_right_dbscan = GR_dbscan(l);
    end
end
data = ana.ROI(i).loc.good_DBSCAN4;
data(idx_dbscan == idx_right_dbscan,:)=[];
for j=1:size(ana.ROI(i).SupResParams,2)
    if ismember(ana.ROI(i).SupResParams(j).frame_idx,data(:,1))
        ana.ROI(i).SupResParams(j).isOutlier_DBSCAN4=2;
    end
end
check = determine_tf_pn_temp_DBSCAN4(ana, i, k, check);
check(k).time = toc;
k=k+1;

%% GMM 1
%wo outlier rejection, wo ellipse fit 
tic
idx_gmm = function_gmm_temp(ana, set, ROIs, i, makePlot, rej);
x_1=0;
counter_1=0;
x_2=0;
counter_2=0;
for l=1:size(idx_gmm,1)
    if idx_gmm(l) == 1
        x_1=x_1+abs(ana.ROI(i).SupResParams(l).x_coord);
        counter_1=counter_1+1;
    else
        x_2=x_2+abs(ana.ROI(i).SupResParams(l).x_coord);
        counter_2=counter_2+1;
    end
end
x_1_norm=x_1/counter_1;
x_2_norm=x_2/counter_2;
if x_1_norm>x_2_norm
    idx_right_gmm=2;
else 
    idx_right_gmm=1;
end
logical = num2cell(idx_gmm'~=idx_right_gmm.*ones(1,length(ana.ROI(i).SupResParams)));
[ana.ROI(i).SupResParams.isOutlier_GMM]=logical{:};
check = determine_tf_pn_temp_GMM(ana, i, k, check);
check(k).time = toc;
k=k+1;

%% GMM 2
%wo outlier rejection, w ellipse fit 
tic
idx_gmm = function_gmm_temp(ana, set, ROIs, i, makePlot, rej);
x_1=0;
counter_1=0;
x_2=0;
counter_2=0;
for l=1:length(idx_gmm)
    if idx_gmm(l) == 1
        x_1=x_1+abs(ana.ROI(i).SupResParams(l).x_coord);
        counter_1=counter_1+1;
    else
        x_2=x_2+abs(ana.ROI(i).SupResParams(l).x_coord);
        counter_2=counter_2+1;
    end
end
x_1_norm=x_1/counter_1;
x_2_norm=x_2/counter_2;
if x_1_norm>x_2_norm
    idx_right_gmm=2;
else 
    idx_right_gmm=1;
end
%Fit an error ellipse to the points within the central cluster 
%Find all points within ellipse (also those not belonging to central cluster)
ana = reject_outside_ellipse_temp_gmm2(ana,i, set, ROIs, idx_gmm, idx_right_gmm, makePlot);
check = determine_tf_pn_temp_GMM2(ana, i, k, check);
check(k).time = toc;
k=k+1;

%% GMM 3
%w outlier rejection, wo ellipse fit 
% tic
% ana = reject_outliers_temp_gmm3(ana, i, set, ROIs, makePlot, rej);
% idx_gmm = function_gmm3_temp(ana, set, ROIs, i, makePlot, rej); 
% x_1=0;
% counter_1=0;
% x_2=0;
% counter_2=0;
% for l=1:length(idx_gmm)
%     if idx_gmm(l) == 1
%         x_1=x_1+abs(ana.ROI(i).loc.good_x_GMM3(l));
%         counter_1=counter_1+1;
%     else
%         x_2=x_2+abs(ana.ROI(i).loc.good_x_GMM3(l));
%         counter_2=counter_2+1;
%     end
% end
% x_1_norm=x_1/counter_1;
% x_2_norm=x_2/counter_2;
% if x_1_norm>x_2_norm
%     idx_right_gmm=2;
% else 
%     idx_right_gmm=1;
% end
% data = ana.ROI(i).loc.good_GMM3;
% data(idx_gmm == idx_right_gmm,:)=[];
% for j=1:size(ana.ROI(i).SupResParams,2)
%     if ismember(ana.ROI(i).SupResParams(j).frame_idx,data(:,1))
%         ana.ROI(i).SupResParams(j).isOutlier_GMM3=2;
%     end
% end
% check = determine_tf_pn_temp_GMM3(ana, i, k, check);
% check(k).time = toc;
% k=k+1;
end