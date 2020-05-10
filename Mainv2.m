clear all
close all
clc

folder = fileparts(which('mainv2.m'));
addpath(genpath(folder)); %add folder to path
try
    rmdir Figures s
end
pause(0.1)
while 1==1
    try
        mkdir Figures
        break;
    catch
        continue;
    end
end
addpath(genpath(folder)); %create empty folder for figures

%% Modus and display
tic;
set.other.system_choice = 2; %1: spherical particle, 2: nanorod
set.other.save_mode = 1; %1: matrices, 2: tiffs
set.other.timetrace_on = 1; %1: also save timetrace, 0: no timetrace
set.other.visFreq = 100; %visualization made every # frames

%% Read input
%set=settings; sample, mic=microscope, objects, para=parameters, bg=background, intensity, other
%ROI; ROI(i): general, obj=object, sites, frames
set.mic.frames = 50000; %#: 144E3 for a full 2h experiment with 50ms frames
set.ROI.number = 2; %# ROIs or objects
set.obj.av_binding_spots = 5; %# per object
set.mic.laser_power = 100; %in mW
set.para.freq_ratio = 1/4; %ratio f_non_specific/f_specific
[set, SNR]  = give_inputs(set); %other inputs

%% Predefine
frame_data = [];
time_trace_data = [];
ROIs = [];

n_frame = ones(1,set.ROI.number); %set counter

t_end = toc;
disp("Initialisation done" + newline + "Time taken: " + num2str(t_end) + " seconds" + newline)
%% Generate ROIs
tic;
for i=1:set.ROI.number
    ROIs = generate_objects(ROIs, set, i);
    ROIs = generate_binding_spots(ROIs, set, i);
    ROIs = shuffle(ROIs, set, i);
end

t_end = toc;
disp("Generate ROIs done" + newline + "Time taken: " + num2str(t_end) + " seconds" + newline)
%% Data generation
tic;
for i=1:set.ROI.number
    
    for t = set.mic.dt:set.mic.dt:set.mic.t_end
        frame = generate_background(set);
        ROIs = generate_binding_events(ROIs, set, t, i);
        frame = generate_specific_binding_intensity(ROIs, set, frame, i);
        %ROIs = generate_non_specific_binding_events();
        %frame = generate_nonspecific_binding_intensity();
        if set.other.timetrace_on ==1
            time_trace_data = count_intensity_ROIs(time_trace_data, frame, n_frame(i), i);
        end
        if set.other.save_mode == 1
            frame_data = save_frames(frame, n_frame(i), frame_data, i);
        else
            save_tiffs(frame, n_frame, i);
        end
        if mod(n_frame(i),set.other.visFreq) == 0
            imagesc([1:size(frame,2)], [1:size(frame,1)], frame, set.other.clims);
            title(["Frame: " num2str(n_frame(i)), "ROI: " num2str(i)])
            pause(0.001)
        end
        n_frame(i)=n_frame(i)+1;
    end
end

t_end = toc;
disp("Generate data done" + newline + "Time taken: " + num2str(t_end) + " seconds" + newline)

%% Visualize
tic; 
generate_time_traces(time_trace_data, set);

t_end = toc;
disp("Visualization" + newline + "Time taken: " + num2str(t_end) + " seconds" + newline)

%View TIFF:
% im = imread('ROI1frame1.tiff');
% figure
% imshow(im, [0 1000])