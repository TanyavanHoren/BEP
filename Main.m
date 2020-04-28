clear all
close all
clc
folder = fileparts(which('main.m')); 
addpath(genpath(folder));
%% System choice and information
set.other.system_choice = 2;%1: Single tethers, 2: nanorods
set.other.background_mode = 2;%1: background generated per pixel, 2: SNR in timetrace 
%set=settings, sample, mic=microscope, other
%obj=objects, gen=general, object=object, site=binding site
%ana=analyisis, ROI, other
%res=results
%% Read input
set.mic.pixels_x = 1024; %number of pixels in x-direction
set.mic.pixels_y = 552; %number of pixels in y-direction
set.mic.pixelsize = 0.22; %width pixel in micrometers
set.mic.time_frame = 1E-3; %in seconds 
set.mic.dt = 50E-3;
set.mic.frames = 200; %144E3 for a full 2h experiment with 50ms frames
set.mic.t_end = set.mic.dt*set.mic.frames;
set.sample.concentration = 10E4; %in M
set.sample.k_off = 1.6; %M^-1s^-1
set.sample.k_on = 2.3E-6; %s^-1
set.sample.tb = 1/set.sample.k_off; %s
set.sample.td = 1/(set.sample.k_on*set.sample.concentration); %s
set.other.av_background = 1000;%experiment_data.concentration*9E10;
n_frame = 1;

obj.gen.av_size_x = 0.07; %average in mu
obj.gen.av_size_y = 0.02; %average in mu
obj.gen.number = 1; %total number of objects
obj.gen.av_binding_spots = 2; %per plasmonic particle
obj.gen.av_I0 = 100; %average reference intensity plasmonic particle

ana.ROI.size = 9; %NbyN ROI frame analyzed per object
%% Generate objects
obj = generate_objects(set, obj);
obj = generate_binding_spots_new(obj, set);
%% predefine
frame_data = [];
ana.ROI.frame=generate_frame(set); 
%% Generate data
for t=set.mic.dt:set.mic.dt:set.mic.t_end
    frame = generate_frame(set);
    %% Background noise for each frame separately(mode 1)
    %frame = generate_background(frame, set);
    %% Rest intensity 
    frame = generate_rest_intensity_new(obj, set, frame);
    %% Binding and unbinding (specific events) 
    obj = generate_binding_events_v2(obj, set, t);
    %% Add intensity from binding
    frame = generate_specific_binding_intensity(obj, set, frame);
    %% Non-specific events 

    %% Add intensity from non-specific events
    
    %% Save frame for processing
    frame_data = save_frames(frame, n_frame, frame_data);
    %% visualize seperate frame 
    %visualize(frame);  
    %% find ROIs in frame
    ana = detect_ROI_cutoff(frame, set, t, ana);
    ana = detect_ROIs(frame, ana, set);
    %% frame number
    n_frame = n_frame+1;
end
clear frame;
%% Process data 
%Everything below is data processing
%% Place ROIs in vector
ana = generate_ROI_vector(ana, set);
%% Localization
%At later stage
%% Intensity count
ana = count_intensity_ROIs_new(ana, frame_data, set);
%% SNR Intensity count
ana = generate_SNR(ana, set);
%% Plot continuous timetraces
generate_time_traces(ana);
%% Find cutoff, create two-level system
ana = generate_cutoff(ana, set);
%% Plot two-level timetraces
generate_time_traces_disc(ana);
%% Determine dark and bright times from two-level timetrace
res = determine_bright_dark_times(ana, set);
%% Plot dark and bright times in histograms
generate_bright_dark_histograms(res, ana)
%% Determine average dark and bright times and the number of binding spots
res = determine_averages_and_binding_spots(ana, res, set);
%% Plot average bright vs average dark time for all ROIs
generate_av_tau_plot(ana, res);