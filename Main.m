clear all
close all
clc
folder = fileparts(which('main.m')); 
addpath(genpath(folder));
%% System choice and information
set.other.system_choice = 1;%1: Single tethers, 2: nanorods
set.other.background_mode = 2;%1: background generated per pixel, 2: SNR in timetrace 
set.other.ROI_mode = 3;%1: Nanorod: ROIs based on frame 1, 2: tethers, by post-processing, 3: Cheat mode. ROIs defined based on known positions (non)specific binding spots
set.other.visFreq = 1000; %how often a frame will be visualized
%set=settings, sample, mic=microscope, other, non-specific events
%obj=objects, gen=general, object=object, site=binding site
%ana=analyisis, ROI, other
%res=results
if set.other.ROI_mode == 1
    if set.other.system_choice == 1
        disp('ROI mode not compatible')
        return
    end
end
if set.other.ROI_mode == 2
    if set.other.system_choice == 2
        disp('ROI mode not compatible')
        return
    end
end
%% Read input
set.mic.pixels_x = 1024; %number of pixels in x-direction
set.mic.pixels_y = 552; %number of pixels in y-direction
set.mic.pixelsize = 0.22; %width pixel in micrometers
set.mic.time_frame = 1E-3; %in seconds 
set.mic.dt = 50E-3;
set.mic.frames = 20000; %144E3 for a full 2h experiment with 50ms frames
set.mic.t_end = set.mic.dt*set.mic.frames;
set.sample.concentration = 2E4; %in M
set.sample.k_off = 1.6; %M^-1s^-1
set.sample.k_on = 2.3E-6; %s^-1
set.sample.tb = 1/set.sample.k_off; %s
set.sample.td = 1/(set.sample.k_on*set.sample.concentration); %s
set.other.av_background = 50; %experiment_data.concentration*9E10;
set.non.lowbound_tb = 0.2; %s lower bound tb range
set.non.upbound_tb = 6; %s upper bound tb range
set.non.lowbound_td = 2; %s
set.non.upbound_td = 1700; %s
set.non.events_per_time = 1; %s^-1; number of non-specific events
set.non.N = set.non.events_per_time*set.mic.frames*set.mic.dt; %total number of non-specific events
n_frame = 1;
clims = [0 2000]; %fixed range of colours

obj.gen.av_size_x = 0.07; %average in mu
obj.gen.av_size_y = 0.02; %average in mu
obj.gen.number = 5; %total number of objects
obj.gen.av_binding_spots = 5; %per plasmonic particle
obj.gen.av_I0 = 200; %average reference intensity plasmonic particle

ana.ROI.size = 9; %NbyN ROI frame analyzed per object
%% Generate objects
obj = generate_objects(set, obj);
obj = generate_binding_spots_new(obj, set);
set = generate_non_spec_binding_spots(set);
%% predefine
if set.mic.frames/set.other.visFreq > 200 && set.mic.frames/set.other.visFreq ~= Inf
    disp('Doe maar gwn niet maat');
    return
end

frame_data = [];
ana.ROI.frame=generate_frame(set); 
BaseFrame = generate_frame(set);
%% Generate data
for t=set.mic.dt:set.mic.dt:set.mic.t_end
    frame = BaseFrame;
    %frame = generate_background(frame, set);
    frame = generate_rest_intensity_new(obj, set, frame);
    %% Binding and unbinding 
    obj = generate_binding_events_v2(obj, set, t);
    frame = generate_specific_binding_intensity(obj, set, frame);
    set = generate_non_specific_binding_events(set, t);
    frame = generate_nonspecific_binding_intensity(set, frame);
    %% Place ROIs in a vector and make timetraces
    if set.other.ROI_mode == 3 || set.other.ROI_mode == 1
        if n_frame == 1
            if set.other.ROI_mode == 3
                ana = generate_ROI_vector_mode_3(ana, set, obj);  %determine based on known positions binding spots
            else 
                ana = detect_ROI_cutoff(frame, ana); %at t==dt determine cutoff
                ana = detect_ROIs(frame, ana, set); 
                ana = generate_ROI_vector(ana, set);
            end
        end
        % Determine intensity over ROIs (Cheat mode)
        ana = count_intensity_ROIs(ana, frame, n_frame, obj); %error: for mode 3, position is in distance, for 1 it is in frames
    end
    %% find ROIs in frame (Mode 2)
    if set.other.ROI_mode==2
        if n_frame == 1
            ana = detect_ROI_cutoff(frame, ana);
        end
        ana = detect_ROIs(frame, ana, set);
    end
    %% Save frame for processing (Now only for mode 2)
    if set.other.ROI_mode == 2 
        frame_data = save_frames(frame, n_frame, frame_data);
    end
    %% other
    if mod(n_frame,set.other.visFreq) == 0
        imagesc([1:size(frame,2)], [1:size(frame,1)], frame, clims);
        title(["Frame: " num2str(n_frame)])
        pause(0.001)
    end
    n_frame = n_frame+1;
end
%% Place ROIs in vector (For mode 2)
if set.other.ROI_mode==2
    ana = generate_ROI_vector(ana, set);
    ana = count_intensity_ROIs_new(ana, frame_data, set);
end
%% General processing
ana = generate_SNR(ana, set);
ana = generate_cutoff(ana, set);
res = determine_bright_dark_times(ana, set);
res = determine_averages_and_binding_spots(ana, res, set);
%% visualization
%generate_time_traces(ana);
%generate_time_traces_disc(ana);
%generate_bright_dark_histograms(res, ana)
generate_av_tau_plot(ana, res);