function [ana, i, ROIs, set, time_trace_data, time_trace_data_non, time_trace_data_spec] = Generate_datasets(S)

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
env = startup(); %start up localization software

%% Modus and display
set.other.system_choice = S.set.other.system_choice; %1: spherical particle, 2: nanorod
set.other.timetrace_on = 1; %0: do not create timetrace, 1: do create
set.other.loc_analysis = 1; %0: no localization analysis, 1: do analyze 
set.other.time_analysis = 1; %0: no time trace analysis, 1: do analyze
set.other.visFreq = S.set.other.visFreq; %visualization made every # frames

%% Read input
%set=settings; sample, mic=microscope, objects, para=parameters, bg=background, intensity, other
%ROI; ROI(i): general, obj=object, sites, frames
set.mic.frames = S.set.mic.frames; %: 144E3 for a full 2h experiment with 50ms frames
set.ROI.number = S.set.ROI.number; % ROIs or objects
set.obj.av_binding_spots = S.set.obj.av_binding_spots; % per object
set.para.freq_ratio = S.set.para.freq_ratio; %ratio f_specific/f_non_specific
[set, SNR]  = give_inputs(set); %other inputs

%% Predefine
frame_data = [];
time_trace_data = [];
time_trace_data_non = [];
time_trace_data_spec = [];
ROIs = [];
time_axis = [set.mic.dt:set.mic.dt:set.mic.t_end];
n_frame = ones(1,set.ROI.number); %set counter

%% Generate ROIs
for i=1:set.ROI.number
    ROIs = generate_objects(ROIs, set, i);
    ROIs = generate_binding_spots(ROIs, set, i);
    ROIs = shuffle(ROIs, set, i);
end

%% Data generation
for i=1:set.ROI.number
    frame_data.ROI(i).frame = uint16(poissrnd(set.bg.mu,[set.ROI.size,set.ROI.size,set.mic.frames]));
    for t = time_axis
        frame = frame_data.ROI(i).frame(:,:,n_frame(i));
        ROIs = generate_binding_events(ROIs, set, t, i);
        frame = generate_specific_binding_intensity(ROIs, set, frame, i);
        time_trace_data_spec = create_spec_tt(ROIs, i, n_frame, time_trace_data_spec);
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
        n_frame(i)=n_frame(i)+1;
    end
end

%% Time trace analysis - Pre-correction
if set.other.time_analysis == 1
    for i=1:set.ROI.number
        ana.ROI(i).timetrace_data = spikes_analysis(time_axis, time_trace_data.ROI(i).frame(:)', i, 0, set);
    end
    ana = determine_averages_and_binding_spots(ana, set);
end

%% Localization
if set.other.loc_analysis == 1
    for i=1:set.ROI.number
        ana.ROI(i).SupResParams = Matej_inspired_fitting_by_Dion(frame_data.ROI(i).frame, set);
        ana = succes_rate_loc(ana, i);
        ana = position_correction(ana, set, i);
    end
end