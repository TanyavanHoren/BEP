function [filenames_circle, filenames_rectangle] = Generate_datasets_loop()

%% Generate datasets - circle
%identical settings:
S.set.other.system_choice = 1; %1: spherical particle, 2: nanorod
S.set.other.visFreq = inf; %visualization made every # frames
S.set.ROI.number = 3; %number of ROIs/datasets with identical settings
S.set.mic.frames = 50000; %: 144E3 for a full 2h experiment with 50ms frames
%varying settings:
% av_binding_spots = [5 10 20 50 100]; % per object
% freq_ratio = [0.1 0.2 0.3 0.4 0.5 1 5 10]; %ratio f_specific/f_non_specific
av_binding_spots = [5]; % per object
freq_ratio = [0.1 0.5 10]; %ratio f_specific/f_non_specific
for m=1:size(av_binding_spots,2)
    for n=1:size(freq_ratio,2)
        S.set.obj.av_binding_spots=av_binding_spots(m);
        S.set.para.freq_ratio=freq_ratio(n);
        [ana, i, ROIs, set, time_trace_data, time_trace_data_non, time_trace_data_spec] = Generate_datasets(S);
        filename = strcat('Test cases\Circle_bind_',num2str(av_binding_spots(m)),'_ratio_',num2str(freq_ratio(n)),'_workspace.mat');
        save(filename);
    end
end
filenames_circle=[];
for m=1:size(av_binding_spots,2)
    for n=1:size(freq_ratio,2)
        filenames_circle = [filenames_circle, strcat("Test cases\Circle_bind_",num2str(av_binding_spots(m)),"_ratio_",num2str(freq_ratio(n)),"_workspace.mat")];
    end
end

%% Generate datasets - rectangle
%identical settings:
S.set.other.system_choice = 2; %1: spherical particle, 2: nanorod
S.set.other.visFreq = inf; %visualization made every # frames
S.set.ROI.number = 3; %number of ROIs/datasets with identical settings
S.set.mic.frames = 100000; %: 144E3 for a full 2h experiment with 50ms frames
%varying settings:
av_binding_spots = [5 10 20 50 100]; % per object
freq_ratio = [0.1 0.5 1 5 10]; %ratio f_specific/f_non_specific
for m=1:size(av_bindin_spots,2)
    for n=1:size(freq_ratio,2)
        S.set.obj.av_binding_spots=av_binding_spots(m);
        S.set.para.freq_ratio=set.para.freq_ratio(n);
        [ana, i, ROIs, set, time_trace_data, time_trace_data_non, time_trace_data_spec] = Generate_datasets(S);
        filename = strcat('Test cases\Rectangle_bind_',num2str(av_binding_spots(m)),'_ratio_',num2str(freq_ratio(n)),'_workspace.mat');
        save(filename);
    end
end
filenames_rectangle=[];
for m=1:size(av_binding_spots,2)
    for n=1:size(freq_ratio,2)
        filenames_rectangle = [filenames_rectangle, strcat("Test cases\Rectangle_bind_",num2str(av_binding_spots(m)),"_ratio_",num2str(freq_ratio(n)),"_workspace.mat")];
    end
end
end