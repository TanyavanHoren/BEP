clear all
close all
clc

folder = fileparts(which('Data_generation_single_set.m'));
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
env = startup(); %start up parallel computing 

%% Modus and display
tic;
set.other.system_choice = 1; %1: spherical particle, 2: nanorod
set.other.timetrace_on = 1; %0: do not create timetrace, 1: do create
set.other.loc_analysis = 1; %0: no localization analysis, 1: do analyze 
set.other.time_analysis = 1; %0: no time trace analysis, 1: do analyze
set.other.visFreq = 500; %visualization made every # frames

%% Read input
%set=settings; sample, mic=microscope, objects, para=parameters, bg=background, intensity, other
%ROI; ROI(i): general, obj=object, sites, frames 
set.ROI.number = 1; % ROIs or objects
set.obj.av_binding_spots = 20; % per object
set.para.freq_ratio = 0.5; %ratio f_specific/f_non_specific
set.other.fixed_bind_spots = 0; %fix or not
[set, SNR] = give_inputs(set); %other inputs

%% Predefine
frame_data = [];
time_trace_data = [];
time_trace_data_non = [];
time_trace_data_spec = [];
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
    frame_data.ROI(i).frame = uint16(normrnd(set.bg.mu,set.bg.std,[set.ROI.size,set.ROI.size,set.mic.frames]));
    for t = time_axis
        frame = frame_data.ROI(i).frame(:,:,n_frame(i));
        ROIs = generate_binding_events(ROIs, set, t, i);
        frame = generate_specific_binding_intensity(ROIs, set, frame, i);
        time_trace_data_spec.ROI(i).frame(n_frame(i)) = create_spec_tt(ROIs, i);
        ROIs = generate_non_specific_events(ROIs, set, t, i);
        frame = add_intensity_non_specific(ROIs, set, frame, i);
        time_trace_data_non = create_non_tt(ROIs, i, n_frame, time_trace_data_non);
        ROIs = delete_old_non_specific_events(ROIs, t, i);
        if set.other.timetrace_on ==1
            if n_frame(i) == 1
                time_trace_data.ROI(i).frame = zeros([1, set.mic.frames]);
            end
            time_trace_data.ROI(i).frame(n_frame(i)) = sum(frame, 'all');
        end
        frame_data.ROI(i).frame(:,:,n_frame(i))=frame;
        if mod(n_frame(i),set.other.visFreq) == 0
            imagesc([1:size(frame,2)], [1:size(frame,1)], frame, set.other.clims);
            title(["Frame: " num2str(n_frame(i)), "ROI: " num2str(i)])
            pause(0.050)
        end
        n_frame(i)=n_frame(i)+1;
    end
end
t_end = toc;
disp("Generate data done" + newline + "Time taken: " + num2str(t_end) + " seconds" + newline)

%% Time trace analysis - Pre-correction
if set.other.time_analysis == 1
    tic;
    for i=1:set.ROI.number
        ana.ROI(i).timetrace_data = spikes_analysis(time_axis, time_trace_data.ROI(i).frame(:)', set, frame_data.ROI(i).frame(:,:,:));
    end
    plot_time_traces(time_trace_data, set, ana.ROI(i).timetrace_data);
    ana = determine_averages_and_binding_spots(ana, set);
    t_end = toc;
    disp("Time trace analysis - Pre-correction - done" + newline + "Time taken: " + num2str(t_end) + " seconds" + newline)
end

%% Localization
if set.other.loc_analysis == 1
    tic
    for i=1:set.ROI.number
        merged_frame_data = merge_events(ana,i,frame_data);
        ana.ROI(i).SupResParams = merge_Matej_inspired_fitting_by_Dion(merged_frame_data.ROI(i).frame, set, i, ana);
        ana = position_correction(ana, set, i);
        figure
        scatter([ana.ROI(i).SupResParams.x_coord], [ana.ROI(i).SupResParams.y_coord],1);
        xlabel('x-position (pixels)')
        ylabel('y-position (pixels)')
        xlim([-set.ROI.size/2 set.ROI.size/2])
        ylim([([-set.ROI.size/2 set.ROI.size/2])])
        box on
        title('Event localizations')
        ana = determine_category_events(ana, time_trace_data_non, time_trace_data_spec, i, 1, set, ROIs);
    end
    t_end = toc;
    disp("Localization done" + newline + "Time taken: " + num2str(t_end) + " seconds" + newline)
end