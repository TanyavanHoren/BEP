clear all
close all
clc

%% Settings
generate_new_data.circle = 0; %0: no new data generation, 1: new data generation
generate_new_data.rectangle = 0; %0: no new data generation, 1: new data generation
S.set.ROI.number = 50; %number of ROIs/datasets with identical settings

av_binding_spots = [10 20 50 100]; %per object
freq_ratio = [0.2 0.5 1 2]; %ratio f_specific/f_non_specific

optimize_dbscan.circle = 0; %0: do not run optimalization, 1: do run optimalization
optimize_dbscan.rectangle = 0; %0: do not run optimalization, 1: do run optimalization
optimization_dbscan.options_minPts = 3:1:15; %range of minPts tested in optimization
optimization_dbscan.options_eps = 0.08:0.02:0.50; %range of eps tested in optimization
if optimize_dbscan.circle == 1 || optimize_dbscan.rectangle == 1 
    optimization_dbscan.options_av_binding_spots = av_binding_spots; % per object -> these values were used for optimization
    optimization_dbscan.options_freq_ratio = freq_ratio; %ratio f_specific/f_non_specific -> these values were used for optimization
end
calibration.dbscan = 'calibration_dbscan_21_07_2020';

optimize_method.circle = 0; %0: do not run optimalization, 1: do run optimalization
optimize_method.rectangle = 0; %0: do not run optimalization, 1: do run optimalization
test_rejection.circle = 0; %0: do not test rejection, 1: do test rejection
test_rejection.rectangle = 1; %0: do not test rejection, 1: do test rejection
makePlot = 0; %0: do not make plots of rejection processes, 1: do make plots
if optimize_method.circle == 1 || optimize_method.rectangle == 1 
    optimization_method.options_av_binding_spots = av_binding_spots; % per object -> these values were used for optimization
    optimization_method.options_freq_ratio = freq_ratio; %ratio f_specific/f_non_specific -> these values were used for optimization
end
calibration.method = 'calibration_methods_21_07_2020';

generate_new_data_Ndet.circle = 0; %0: no new data generation, 1: new data generation
generate_new_data_Ndet.rectangle = 0; %0: no new data generation, 1: new data generation
correction_binding_spots.circle = 0; %0: no correction analysis, 1: correction analysis
correction_binding_spots.rectangle = 0; %0: no correction analysis, 1: correction analysis
Ndet_binding_spots = [10 20 50 100]; %per object
Ndet_freq_ratio = 0.2:0.2:5; %ratio f_specific/f_non_specific
plotcolours=[0 0.4470 0.7410; 0.8500 0.3250 0.0980; 0.9290 0.6940 0.1250; 0.4940 0.1840 0.5560];

%% Data generation (if necessary)
[filenames_circle, filenames_rectangle] = Generate_datasets_loop(S,av_binding_spots,freq_ratio, generate_new_data);

%% Optimization dbscan (should in principle only be done once) - circle
if optimize_dbscan.circle == 1
    workspaces=filenames_circle;
    opt.circle.minima = Optimize_dbscan_loop(workspaces, optimization_dbscan.options_minPts, optimization_dbscan.options_eps);
    optimization_dbscan = create_lookup_table_dbscan_circle(av_binding_spots,freq_ratio,opt,optimization_dbscan);
end

%% Optimization dbscan (should in principle only be done once) - rectangle
if optimize_dbscan.rectangle == 1
    workspaces=filenames_rectangle;
    opt.rectangle.minima = Optimize_dbscan_loop(workspaces, optimization_dbscan.options_minPts, optimization_dbscan.options_eps);
    optimization_dbscan = create_lookup_table_dbscan_rectangle(av_binding_spots,freq_ratio,opt,optimization_dbscan);
end

%% Test rejection - circle
if test_rejection.circle==1
    for m=1:size(av_binding_spots,2)
        workspaces=filenames_circle(1+(m-1)*size(freq_ratio,2):m*size(freq_ratio,2));
        [circle_series(m).false_positives, circle_series(m).false_negatives, circle_series(m).false_overall] = Test_rejection_loop(calibration, makePlot, workspaces, av_binding_spots, freq_ratio, m);
    end
    if optimize_method.circle == 1
        optimization_method = create_lookup_table_method_circle(optimization_method, av_binding_spots, freq_ratio, circle_series);
    end
end

%% Test rejection - rectangle
if test_rejection.rectangle==1
    for m=1:size(av_binding_spots,2)
        workspaces=filenames_rectangle(1+(m-1)*size(freq_ratio,2):m*size(freq_ratio,2));
        [rectangle_series(m).false_positives, rectangle_series(m).false_negatives, rectangle_series(m).false_overall] = Test_rejection_loop(calibration, makePlot, workspaces, av_binding_spots, freq_ratio, m);
    end
    if optimize_method.rectangle == 1
    optimization_method = create_lookup_table_method_rectangle(optimization_method, av_binding_spots, freq_ratio, rectangle_series);
    end
end

%% Show improvement in binding spot determination
[filenames_Ndet_circle, filenames_Ndet_rectangle] = Generate_datasets_Ndet_loop(S,Ndet_binding_spots,Ndet_freq_ratio, generate_new_data_Ndet);
if correction_binding_spots.circle==1
    circle_series_Ndet=[];
    for m=1:size(Ndet_binding_spots,2)
        workspaces=filenames_Ndet_circle(1+(m-1)*size(Ndet_freq_ratio,2):m*size(Ndet_freq_ratio,2));
        circle_series_Ndet = Nbind_rejection_loop(calibration, makePlot, workspaces, m, circle_series_Ndet);
        create_scatter_plot_Nbind(workspaces, Ndet_binding_spots, Ndet_freq_ratio, m, circle_series_Ndet,plotcolours);
    end
end

if correction_binding_spots.rectangle==1
    rectangle_series_Ndet=[];
    for m=1:size(Ndet_binding_spots,2)
        workspaces=filenames_Ndet_rectangle(1+(m-1)*size(Ndet_freq_ratio,2):m*size(Ndet_freq_ratio,2));
        rectangle_series_Ndet = Nbind_rejection_loop(calibration, makePlot, workspaces, m, rectangle_series_Ndet);
        create_scatter_plot_Nbind(workspaces, Ndet_binding_spots, Ndet_freq_ratio, m, rectangle_series_Ndet,plotcolours);
    end
end