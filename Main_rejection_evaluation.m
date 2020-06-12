clear all
close all
clc

%% Settings
generate_new_data.circle = 0; %0: no new data generation, 1: new data generation
generate_new_data.rectangle = 0; %0: no new data generation, 1: new data generation
S.set.ROI.number = 3; %number of ROIs/datasets with identical settings
S.set.mic.frames = 10000; %: 144E3 for a full 2h experiment with 50ms frames

av_binding_spots = [5 10 20 50 100]; % per object
freq_ratio = [1 5 10]; %ratio f_specific/f_non_specific

optimize_dbscan.circle = 0; %0: do not run optimalization, 1: do run optimalization
optimize_dbscan.rectangle = 0; %0: do not run optimalization, 1: do run optimalization
optimization_minPts=5:5:50; %range of minPts tested in optimization
optimization_eps=0.05:0.01:0.25; %range of eps tested in optimization
av_binding_spots_optimization = [5 10 20 50 100]; % per object -> these values were used for optimization
freq_ratio_optimization = [0.1 0.5 1 5 10]; %ratio f_specific/f_non_specific -> these values were used for optimization

test_rejection.circle = 1; %0: do not test rejection, 1: do test rejection
test_rejection.rectangle = 0; %0: do not test rejection, 1: do test rejection
makePlot = 0; %0: do not make plots of rejection processes, 1: do make plots

%% Data generation (if necessary)
[filenames_circle, filenames_rectangle] = Generate_datasets_loop(S,av_binding_spots,freq_ratio, generate_new_data);

%% Optimization dbscan (should in principle only be done once) - circle
if optimize_dbscan.circle == 1
    workspaces=filenames_circle;
    [opt.circle.false_pos, opt.circle.false_neg, opt.circle.false_av, opt.circle.minima] = Optimize_dbscan_loop(workspaces, optimization_minPts, optimization_eps);
    optimization_dbscan = create_lookup_table_dbscan(av_binding_spots,freq_ratio,opt);
end

%% Find adequate eps, minPts for dbscan
% true_ratio=0.65;
% true_bind=34;
% dist_ratio = abs(freq_ratio_optimization-true_ratio);
% minDist_ratio = min(dist_ratio);
% id_ratio = find(dist_ratio == minDist_ratio);
% dist_bind = abs(av_binding_spots_optimization-true_bind);
% minDist_bind = min(dist_bind);
% id_bind = find(dist_bind == minDist_bind);
% to_be_used_eps=optimization_dbscan.eps(id_bind,id_ratio);
% to_be_used_minPts=optimization_dbscan.minPts(id_bind,id_ratio);

%% Optimization dbscan (should in principle only be done once) - rectangle
if optimize_dbscan.rectangle == 1
    workspaces=filenames_rectangle;
    [opt.rectangle.false_pos, opt.rectangle.false_neg, opt.rectangle.false_av, opt.rectangle.minima] = Optimize_dbscan_loop(workspaces, optimization_minPts, optimization_eps);
end

%% Test rejection - circle
if test_rejection.circle==1
    for m=1:size(av_binding_spots,2)
        workspaces=filenames_circle(1+(m-1)*size(freq_ratio,2):m*size(freq_ratio,2));
        [circle_series(m).false_positives, circle_series(m).false_negatives, circle_series(m).false_overall] = Test_rejection_loop(makePlot, workspaces, av_binding_spots, freq_ratio, m);
    end
end

%% Test rejection - rectangle
if test_rejection.rectangle==1
    for m=1:size(av_binding_spots,2)
        workspaces=filenames_rectangle(1+(m-1)*size(freq_ratio,2):m*size(freq_ratio,2));
        [rectangle_series(m).false_positives, rectangle_series(m).false_negatives, rectangle_series(m).false_overall] = Test_rejection_loop(makePlot, workspaces, av_binding_spots, freq_ratio, m);
    end
end

%% Update if necessary
if optimize_dbscan.circle == 1 || optimize_dbscan.rectangle == 1
    disp('Update current freq_ratio_optimization and av_binding_spots_optimization values!')
end