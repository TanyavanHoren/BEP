clear all
close all
clc
folder = fileparts(which('main.m')); 
addpath(genpath(folder));
%% System choice
system_choice = 2;%1: Single tethers, 2: nanorods
background_mode = 2;%1: background generated per pixel, 2: SNR in timetrace 
%% Read input
pixel_data.pixels_x = 1024; %number of pixels in x-direction
pixel_data.pixels_y = 552; %number of pixels in y-direction
pixel_data.pixelsize = 0.22; %width pixel in micrometers

object_data.size_x = 0.07; %in mu
object_data.size_y = 0.02; %in mu
object_data.number = 1; %total number of objects
object_data.average_binding_spots = 2; %per plasmonic particle
object_data.I0 = 100000; %reference intensity plasmonic particle

experiment_data.concentration = 10E4; %in M
experiment_data.average_background = 1000;%experiment_data.concentration*9E10;
experiment_data.k_off = 1.6; %M^-1s^-1
experiment_data.k_on = 2.3E-6; %s^-1
experiment_data.tb = 1/experiment_data.k_off; %s
experiment_data.td = 1/(experiment_data.k_on*experiment_data.concentration); %s

analysis_data.size_ROI = 9; %NbyN ROI frame analyzed per object
analysis_data.time_frame = 1E-3; %in seconds 
analysis_data.dt = 50E-3;
analysis_data.frames = 50; %144E3 for a full 2h experiment with 50ms frames
analysis_data.t_end = analysis_data.dt*analysis_data.frames;
n_frame = 1;
%% Generate objects
object_data = generate_objects(pixel_data, object_data, analysis_data, system_choice);
object_data = generate_binding_spots_new(object_data, system_choice,experiment_data);
%% predefine
%intensity_data.object = zeros(object_data.number, analysis_data.frames+1);
intensity_data = [];
frame_data = [];
ROI_frame=generate_frame(pixel_data); 
%% Generate data
for t=analysis_data.dt:analysis_data.dt:analysis_data.t_end
    frame = generate_frame(pixel_data);
    %% Background noise (mode 1)
    frame = generate_background(frame, pixel_data, experiment_data, background_mode);
    %% Rest intensity 
    frame = generate_rest_intensity_new(object_data, pixel_data, frame, system_choice);
    %% Binding and unbinding (specific events)
    %object_data = generate_binding_events(object_data, experiment_data,t); 
    object_data = generate_binding_events_v2(object_data, experiment_data, t, analysis_data);
    %% Add intensity from binding
    frame = generate_specific_binding_intensity(object_data, pixel_data, frame, experiment_data,t,analysis_data);
    %% Non-specific events 

    %% Add intensity from non-specific events
    
    %% Save frame for processing
    frame_data = save_frames(frame, n_frame, frame_data);
    %% visualize seperate frame 
    %visualize(frame);  
    %% find ROIs in frame
    analysis_data = detect_ROI_cutoff(frame, analysis_data,t);
    ROI_frame = detect_ROIs(frame, ROI_frame, analysis_data, pixel_data);
    %% frame number
    n_frame = n_frame+1;
end
clear frame;
%% Process data 
%Everything below is data processing
%% Place ROIs in vector
ROI_data = generate_ROI_vector(ROI_frame, pixel_data, analysis_data);
%% Localization
%At later stage
%% Intensity count
intensity_data = count_intensity_ROIs_new(intensity_data, analysis_data, ROI_data, frame_data);
%% SNR Intensity count
intensity_data = generate_SNR(intensity_data,ROI_data,analysis_data, background_mode, experiment_data);
%% Plot continuous timetraces
%generate_time_traces(intensity_data,ROI_data);
%% Find cutoff, create two-level system
intensity_data = generate_cutoff(intensity_data,analysis_data,ROI_data);
%% Plot two-level timetraces
%generate_time_traces_disc(intensity_data,ROI_data);
%% Determine dark and bright times from two-level timetrace
intensity_data = determine_bright_dark_times(ROI_data, intensity_data, analysis_data);
%% Plot dark and bright times in histograms
generate_bright_dark_histograms(intensity_data,ROI_data)
%% Determine average dark and bright times and the number of binding spots
intensity_data = determine_averages_and_binding_spots(ROI_data, intensity_data,experiment_data);
%% Plot average bright vs average dark time for all ROIs
%generate_av_tau_plot(intensity_data,ROI_data);