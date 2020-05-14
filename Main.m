clear all
close all
clc

folder = fileparts(which('main.m'));
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
rainSTORM_env = startup(); %start up localization software

%% Modus and display
tic;
set.other.system_choice = 2; %1: spherical particle, 2: nanorod
set.other.save_mode = 1; %1: matrices, 2: tiffs
set.other.timetrace_on = 1; %0: do not create timetrace, 1: do create
set.other.loc_analysis = 0; %0: no localization analysis, 1: do analyze 
set.other.time_analysis = 1; %0: no time trace analysis, 1: do analyze
set.other.visFreq = 5000; %visualization made every # frames

%% Read input
%set=settings; sample, mic=microscope, objects, para=parameters, bg=background, intensity, other
%ROI; ROI(i): general, obj=object, sites, frames
set.mic.frames = 50000; %: 144E3 for a full 2h experiment with 50ms frames
set.ROI.number = 2; % ROIs or objects
set.obj.av_binding_spots = 20; % per object
set.mic.laser_power = 100; %in mW
set.para.freq_ratio = 4; %ratio f_specific/f_non_specific
set.ana.loc.algo_name = 'GF_Dion'; %Options: GF3, GF, CoM
[set, SNR]  = give_inputs(set); %other inputs
set.ana.rainSTORM_settings = create_standard_settings(set); %mimick rainSTORM settings

%% Predefine
frame_data = [];
time_trace_data = [];
ROIs = [];
time_axis = [set.mic.dt:set.mic.dt:set.mic.t_end];
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
    frame_data.ROI(i).frame = uint16(poissrnd(set.bg.mu,[set.ROI.size,set.ROI.size,set.mic.frames]));
    for t = time_axis
        frame = frame_data.ROI(i).frame(:,:,n_frame(i));
        ROIs = generate_binding_events(ROIs, set, t, i);
        frame = generate_specific_binding_intensity(ROIs, set, frame, i);
        ROIs = generate_non_specific_events(ROIs, set, t, i);
        frame = add_intensity_non_specific(ROIs, set, frame, i);
        ROIs = delete_old_non_specific_events(ROIs, t, i);
        if set.other.timetrace_on ==1
            if n_frame(i) == 1
                time_trace_data.ROI(i).frame = zeros([1, set.mic.frames]);
            end
            time_trace_data.ROI(i).frame(n_frame(i)) = sum(frame, 'all');
        end
        if set.other.save_mode == 1
            frame_data.ROI(i).frame(:,:,n_frame(i))=frame;
        else
            imwrite(frame, strcat('Figures\ROI',num2str(i)','frame',num2str(n_frame(i)),'.tif'));
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

%% Time trace analysis
if set.other.time_analysis == 1
    tic;
    generate_time_traces(time_trace_data, set);
    for i=1:set.ROI.number
        ana.timetrace_data(i) = spikes_analysis(time_axis, time_trace_data.ROI(i).frame(:)', i, 0, set);
    end
    generate_bright_dark_histograms(ana, set)
    ana = determine_averages_and_binding_spots(ana, set);
    generate_av_tau_plot(ana, set)
    t_end = toc;
    disp("Time trace analysis done" + newline + "Time taken: " + num2str(t_end) + " seconds" + newline)
end

%% Localization
if set.other.loc_analysis == 1
    tic
    for i=1:set.ROI.number
        SupResParams=rainSTORM_main(rainSTORM_env, frame_data.ROI(i).frame, set);
        plot_loc_and_sites(SupResParams, set, ROIs, i)
        if set.other.system_choice == 1
            viscircles([0 0],ROIs.ROI(i).object_radius/set.mic.pixelsize, 'LineWidth', 0.5)
        elseif set.other.system_choice == 2
            square = plot_square(ROIs, set, i);
        end
    end
    t_end = toc;
    disp("Localization analysis done" + newline + "Time taken: " + num2str(t_end) + " seconds" + newline)
end