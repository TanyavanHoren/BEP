clear all
close all
clc

folder = fileparts(which('main.m'));
addpath(genpath(folder)); %add folder to path
try
    rmdir Figures s
end
pause(0.1)
mkdir Figures
addpath(genpath(folder)); %create empty folder for figures

%% Modii and display
tic;
set.other.system_choice = 1; %1: single tethers, 2: nanorods, 3: spherical cells, 4: spherical plasmonic particles
set.other.background_mode = 2; %1: background generated per pixel, 2: background added in timetrace
set.other.ROI_mode = 3;%1: nanorod: ROIs based on frame 1, 2: tethers: post-processing, 3: cheat mode: ROIs from known positions
if set.other.ROI_mode == 1 %check if compatible
    if set.other.system_choice == 1
        disp('ROI mode not compatible')
        return
    end
end
if set.other.ROI_mode == 2 %check if compatible
    if set.other.system_choice == 2
        disp('ROI mode not compatible')
        return
    end
end
set.other.visFreq = 100; %once every N frames, visualization is done

%% Read input
<<<<<<< Updated upstream
%set=settings; sample, mic=microscope, laser, other
%obj=objects; gen=general, object=object, non=non-specific
%ana=analyisis; ROI, other
%res=results; ROI
set.mic.frames = 50000; %#: 144E3 for a full 2h experiment with 50ms frames
obj.non.events_per_time = 0.002; %#_non-specific/s
obj.gen.number = 10; %# objects
obj.gen.av_binding_spots = 5; %# per object
set.laser.focus = [0;0]; %[x;y] in mu counted from center
set.laser.power = 100; %in mW
set.laser.width = Inf; %FWHM in mu (Inf if homogeneous)
[set, n_frame, obj, ana]  = give_inputs(set, obj); %other inputs
=======
%set=settings; sample, mic=microscope, objects, para=parameters, bg=background, intensity, other
%ROI; ROI(i): general, obj=object, sites, frames
set.mic.frames = 10000; %: 144E3 for a full 2h experiment with 50ms frames
set.ROI.number = 1; % ROIs or objects
set.obj.av_binding_spots = 5; % per object
set.para.freq_ratio = 1; %ratio f_specific/f_non_specific
[set, SNR]  = give_inputs(set); %other inputs
set = determination_loc_precision(set);
>>>>>>> Stashed changes

%% Predefine
frame_data = [];
set.laser.laser_frame = generate_laser_profile(set);
imagesc([1:size(set.laser.laser_frame,2)], [1:size(set.laser.laser_frame,1)], set.laser.laser_frame, set.other.clims_laser);
title(["Laser intensity"])
pause(0.001)
set.sample.background_frame = generate_background_frame(set);
ana.ROI.frame = generate_frame(set);
BaseFrame = generate_frame(set);

t_end = toc;
disp("Initialisation done" + newline + "Time taken: " + num2str(t_end) + " seconds" + newline)
%% Generate objects
tic;

obj = generate_objects(set, obj);
obj = generate_binding_spots(obj, set);
obj = generate_non_spec_binding_spots(obj, set);
[obj, set] = shuffle(obj, set);

t_end = toc;
disp("Generate objects done" + newline + "Time taken: " + num2str(t_end) + " seconds" + newline)
%% Generate data
tic;
for t = set.mic.dt:set.mic.dt:set.mic.t_end
    if set.other.ROI_mode == 1
        [obj, set, ana] = data_generation_mode_1(t, n_frame, set, obj, ana, BaseFrame);
    elseif set.other.ROI_mode == 2
        [obj, set, ana, frame_data] = data_generation_mode_2(t, n_frame, set, obj, ana, BaseFrame, frame_data);
    elseif set.other.ROI_mode == 3
        [obj, set, ana] = data_generation_mode_3(t, n_frame, set, obj, ana, BaseFrame); 
    end
    n_frame = n_frame+1;
end

t_end = toc;
disp("Generate data done" + newline + "Time taken: " + num2str(t_end) + " seconds" + newline)
<<<<<<< Updated upstream
%% General processing
tic;
if set.other.ROI_mode == 2
    [ana, res] = processing_ROI_mode_2(ana, set, obj, frame_data);
elseif set.other.ROI_mode ~= 2
    [ana, res] = processing_ROI_mode_other(ana, set, obj);
=======

%% Time trace analysis - Pre-correction
if set.other.time_analysis == 1
    tic;
    generate_time_traces(time_trace_data, set);
    for i=1:set.ROI.number
        ana.ROI(i).timetrace_data = spikes_analysis(time_axis, time_trace_data.ROI(i).frame(:)', i, 0, set);
    end
%     generate_bright_dark_histograms(ana, set);
    ana = determine_averages_and_binding_spots(ana, set);
%     generate_av_tau_plot(ana, set);
    t_end = toc;
    disp("Time trace analysis - Pre-correction - done" + newline + "Time taken: " + num2str(t_end) + " seconds" + newline)
end

%% Localization
if set.other.loc_analysis == 1
    tic
    for i=1:set.ROI.number
        merged_frame_data = merge_events(ana,i,frame_data);
        ana.ROI(i).SupResParams = merge_Matej_inspired_fitting_by_Dion(merged_frame_data.ROI(i).frame, set, i, ana);
        ana = position_correction(ana, set, i);
    end
    t_end = toc;
    disp("Localization done" + newline + "Time taken: " + num2str(t_end) + " seconds" + newline)
>>>>>>> Stashed changes
end

t_end = toc;
disp("General processing" + newline + "Time taken: " + num2str(t_end) + " seconds" + newline)
%% Visualization
tic

generate_time_traces(ana, set);
generate_time_traces_disc(ana, set);
generate_bright_dark_histograms(res, ana)
generate_av_tau_plot(ana, res);

t_end = toc;
disp("Visualization" + newline + "Time taken: " + num2str(t_end) + " seconds" + newline)