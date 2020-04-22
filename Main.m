clear all
close all
clc
%% Read input
pixel_data.pixels_x = 1024; %number of pixels in x-direction
pixel_data.pixels_y = 552; %number of pixels in y-direction
pixel_data.pixelsize = 0.22; %width pixel in micrometers
nanorod_data.size_x = 0.07; %in mu
nanorod_data.size_y = 0.02; %in mu
nanorod_data.number = 3; 
nanorod_data.average_binding_spots = 5;
experiment_data.concentration = 10E-9; %in M
experiment_data.average_background = experiment_data.concentration*9E10;
%% Generate nanorods
nanorod_data = generate_nanorods(pixel_data, nanorod_data);
%% Generate frame
frame = generate_frame(pixel_data);
%% Background noise
frame = generate_background(frame, pixel_data, experiment_data);
%% Shot noise 


%% visualize
visualize(frame);   