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
set.other.system_choice = 1; %1: single tethers, 2: nanorods
set.other.background_mode = 2; %1: background generated per pixel, 2: background added in timetrace 
set.other.ROI_mode = 2;%1: nanorod: ROIs based on frame 1, 2: tethers: post-processing, 3: cheat mode: ROIs from known positions
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
set.other.visFreq = 10; %once every N frames, visualization is done

%% Read input
%set=settings; sample, mic=microscope, other, non=non-specific events
%obj=objects; gen=general, object=object
%ana=analyisis; ROI, other
%res=results; ROI
set.mic.frames = 2000; %#: 144E3 for a full 2h experiment with 50ms frames
set.other.av_background = 50; %photons
set.non.events_per_time = 1; %#_non-specific/s
obj.gen.number = 5; %# objects
obj.gen.av_binding_spots = 5; %# per object
[set, n_frame, obj, ana, clims]  = give_inputs(set, obj); %other inputs

%% Generate objects
obj = generate_objects(set, obj);
obj = generate_binding_spots(obj, set);
set = generate_non_spec_binding_spots(set);

%% Predefine
% if set.mic.frames/set.other.visFreq > 100 && set.mic.frames/set.other.visFreq ~= Inf
%     disp('Increase set.other.visFreq');
%     return
% end
frame_data = [];
ana.ROI.frame = generate_frame(set); 
BaseFrame = generate_frame(set);

%% Generate data
for t = set.mic.dt:set.mic.dt:set.mic.t_end
    frame = BaseFrame;
    %% Background (mode 1) and rest intensity
    if set.other.background_mode == 1
        frame = generate_background(frame, set);
    end
    frame = generate_rest_intensity(obj, set, frame);
    %% Binding and unbinding 
    obj = generate_binding_events(obj, set, t);
    frame = generate_specific_binding_intensity(obj, set, frame);
    set = generate_non_specific_binding_events(set, t);
    frame = generate_nonspecific_binding_intensity(set, frame);
    %% Place ROIs in a vector and make timetraces (mode 1 and 3)
    if set.other.ROI_mode == 3 || set.other.ROI_mode == 1
        if n_frame == 1
            if set.other.ROI_mode == 3
                ana = generate_ROI_vector_mode_3(ana, set, obj); %use known positions
            else 
                ana = detect_ROI_cutoff(frame, ana); %determine intensity cutoff 
                ana = detect_ROIs(frame, ana, set); %find nanorod positions
                ana = generate_ROI_vector(ana, set);
            end
        end
        ana = count_intensity_ROIs(ana, frame, n_frame); 
    end
    %% Find ROIs in frame and save frame for processing (mode 2)
    if set.other.ROI_mode == 2
        if n_frame == 1
            ana = detect_ROI_cutoff(frame, ana); %cutoff based on first frame
        end
        ana = detect_ROIs(frame, ana, set);
        frame_data = save_frames(frame, n_frame, frame_data);
    end
    %% Other
    if mod(n_frame,set.other.visFreq) == 0
        imagesc([1:size(frame,2)], [1:size(frame,1)], frame, clims);
        title(["Frame: " num2str(n_frame)])
        pause(0.001)
    end
    n_frame = n_frame+1;
end

%% Place ROIs in a vector and make timetraces (mode 2)
if set.other.ROI_mode == 2
    ana = generate_ROI_vector(ana, set);
    ana = count_intensity_ROIs_mode_2(ana, frame_data, set);
end

%% General processing
ana = generate_SNR_v2(ana, set);
ana = generate_cutoff(ana, set);
if set.other.ROI_mode ~= 3
    res = find_if_specific(ana, obj,set);
else
    res = [];
end
res = determine_bright_dark_times(res, ana, set);
res = determine_averages_and_binding_spots(ana, res, set);

%% Visualization
%generate_time_traces(ana);
%generate_time_traces_disc(ana);
%generate_bright_dark_histograms(res, ana)
generate_av_tau_plot(ana, res);