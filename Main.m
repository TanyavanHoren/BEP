clear all
close all
clc
%% Read input
pixel_data.pixels_x = 1024; %number of pixels in x-direction
pixel_data.pixels_y = 552; %number of pixels in y-direction
pixel_data.pixelsize = 0.22; %width pixel in micrometers

nanorod_data.size_x = 0.07; %in mu
nanorod_data.size_y = 0.02; %in mu
nanorod_data.number = 1; %total number of rods
nanorod_data.average_binding_spots = 50; %per rod
nanorod_data.I0 = 100000; %reference intensity rods 

experiment_data.concentration = 10E5; %in M
experiment_data.average_background = experiment_data.concentration*9E10;
experiment_data.k_off = 2.3E6; %M^-1s^-1
experiment_data.k_on = 1.6; %s^-1
experiment_data.tb = 1/experiment_data.k_off; %s
experiment_data.td = 1/(experiment_data.k_on*experiment_data.concentration); %s

analysis_data.size_ROI = 9; %NbyN ROI frame analyzed per nanorod
analysis_data.time_frame = 1E-3; %in seconds 
analysis_data.dt = 1E-9;
analysis_data.frames = 1000;
analysis_data.t_end = analysis_data.dt*analysis_data.frames;
n_frame = 1;
%% Generate nanorods
nanorod_data = generate_nanorods(pixel_data, nanorod_data, analysis_data);
nanorod_data = generate_binding_spots(nanorod_data);
%% predefine
intensity_data.nanorod = zeros(nanorod_data.number, analysis_data.frames+1);
%% Generate frame
for t=0:analysis_data.dt:analysis_data.t_end
    frame = generate_frame(pixel_data);
    %% Background noise
    %frame = generate_background(frame, pixel_data, experiment_data);
    %% Rest intensity 
    frame = generate_rest_intensity(nanorod_data, pixel_data, frame);
    %% Binding and unbinding (specific events)
    nanorod_data = generate_binding_events(nanorod_data, experiment_data,t); 
    %% Add intensity from bounding
    
    %% Non-specific events 

    %% Intensity count
    intensity_data = count_intensity_ROIs(intensity_data, analysis_data, nanorod_data, pixel_data, frame, n_frame);
    %% visualize seperate frame 
    %visualize(frame);  
    %% frame number
    n_frame = n_frame+1;
end
%% Localization

%% plot timetraces
%generate_time_traces(intensity_data,nanorod_data,analysis_data);