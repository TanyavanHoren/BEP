clear all
close all
clc
%% System choice
system_choice = 1;%1: Single tethers, 2: nanorods
background_mode = 2;%1: background generated per pixel, 2: SNR in timetrace 
%% Read input
pixel_data.pixels_x = 1024; %number of pixels in x-direction
pixel_data.pixels_y = 552; %number of pixels in y-direction
pixel_data.pixelsize = 0.22; %width pixel in micrometers

object_data.size_x = 0.07; %in mu
object_data.size_y = 0.02; %in mu
object_data.number = 1; %total number of objects
object_data.average_binding_spots = 5; %per nanorod
object_data.I0 = 100000; %reference intensity rods 

experiment_data.concentration = 10E4; %in M
experiment_data.average_background = 1000;%experiment_data.concentration*9E10;
experiment_data.k_off = 1.6; %M^-1s^-1
experiment_data.k_on = 2.3E-6; %s^-1
experiment_data.tb = 1/experiment_data.k_off; %s
experiment_data.td = 1/(experiment_data.k_on*experiment_data.concentration); %s

analysis_data.size_ROI = 9; %NbyN ROI frame analyzed per object
analysis_data.time_frame = 1E-3; %in seconds 
analysis_data.dt = 50E-3;
analysis_data.frames = 20; %144E3 voor volledig 2u experiment op 50ms frames
analysis_data.t_end = analysis_data.dt*analysis_data.frames;
n_frame = 1;
%% Generate objects
object_data = generate_objects(pixel_data, object_data, analysis_data, system_choice);
object_data = generate_binding_spots_new(object_data, system_choice);
%% predefine
%intensity_data.object = zeros(object_data.number, analysis_data.frames+1);
intensity_data = [];
%% Generate frame
for t=0:analysis_data.dt:analysis_data.t_end
    frame = generate_frame(pixel_data);
    %% Background noise (mode 1)
    frame = generate_background(frame, pixel_data, experiment_data, background_mode);
    %% Rest intensity 
    frame = generate_rest_intensity_new(object_data, pixel_data, frame, system_choice);
    %% Binding and unbinding (specific events)
    object_data = generate_binding_events(object_data, experiment_data,t); 
    object_data = generate_binding_events_v2(object_data, experiment_data, t);
    %% Add intensity from binding
    frame = generate_specific_binding_intensity(object_data, pixel_data, frame, experiment_data);
    %% Non-specific events 

    %% Add intensity from non-specific events
    
    %% Intensity count
    intensity_data = count_intensity_ROIs(intensity_data, analysis_data, object_data, pixel_data, frame, n_frame);
    %% SNR Intensity count
    intensity_data = generate_SNR(intensity_data,object_data,analysis_data, background_mode,n_frame, experiment_data);
    %% visualize seperate frame 
    %visualize(frame);  
    %% frame number
    n_frame = n_frame+1;
end
%% Localization

%% Plot timetraces
%generate_time_traces(intensity_data,object_data,analysis_data);
%% Find cutoff, create two-level system
intensity_data = generate_cutoff(intensity_data,analysis_data,object_data);
%% Plot two-level timetrace
%generate_time_traces(intensity_data,object_data,analysis_data);
%% Determine dark and bright times from two-level timetrace
intensity_data = determine_bright_dark_times(object_data, intensity_data);
%% Plot dark and bright times in histograms
generate_bright_dark_histograms(intensity_data,object_data)
%% Determine average dark and bright times and the number of binding spots
intensity_data = determine_averages_and_binding_spots(object_data, intensity_data,experiment_data);
%% Plot average bright vs average dark time for all ROIs
generate_av_tau_plot(intensity_data,object_data);