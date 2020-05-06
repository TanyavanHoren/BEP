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

%% System choice and display
set.other.system_choice = 4; %1: single tethers, 2: nanorods, 3: spherical cells, 4: spherical plasmonic particles
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
%set=settings; sample, mic=microscope, laser, non=non-specific events, other
%obj=objects; gen=general, object=object
%ana=analyisis; ROI, other
%res=results; ROI
set.mic.frames = 20000; %#: 144E3 for a full 2h experiment with 50ms frames
set.non.events_per_time = 0.001; %#_non-specific/s
obj.gen.number = 10; %# objects
obj.gen.av_binding_spots = 5; %# per object
set.laser.focus = [0;0]; %[x;y] in mu counted from center
set.laser.power = 100; %in mW
set.laser.width = Inf; %FWHM in mu (Inf if homogeneous)
[set, n_frame, obj, ana]  = give_inputs(set, obj); %other inputs

%% Predefine
% if set.mic.frames/set.other.visFreq > 100 && set.mic.frames/set.other.visFreq ~= Inf
%     disp('Increase set.other.visFreq');
%     return
% end
frame_data = [];
set.laser.laser_frame = generate_laser_profile(set);
imagesc([1:size(set.laser.laser_frame,2)], [1:size(set.laser.laser_frame,1)], set.laser.laser_frame, set.other.clims_laser);
title(["Laser intensity"])
pause(0.001)
set.sample.background_frame = generate_background_frame(set);
ana.ROI.frame = generate_frame(set);
BaseFrame = generate_frame(set);

%% Generate objects
obj = generate_objects(set, obj);
obj = generate_binding_spots(obj, set);
set = generate_non_spec_binding_spots(set);
[obj, set] = shuffle(obj, set);

%% Generate data
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

%% General processing
if set.other.ROI_mode == 2
    [ana, res] = processing_ROI_mode_2(ana, set, obj, frame_data);
elseif set.other.ROI_mode ~= 2
    [ana, res] = processing_ROI_mode_other(ana, set, obj);
end

%% Visualization
generate_time_traces(ana);
%generate_time_traces_disc(ana);
generate_bright_dark_histograms(res, ana)
generate_av_tau_plot(ana, res);