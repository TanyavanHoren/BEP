clear all
close all
clc

%% Settings
new_data_generated = 0; %1: yes or 0: no
S.set.ROI.number = 2; %number of ROIs/datasets with identical settings
av_binding_spots = [5 20 100]; %per object
freq_ratio = [0.1 0.5 1 5 10]; %ratio f_specific/f_non_specific
makePlot = 0;

%% Generate data
if new_data_generated == 1
    S.set.other.system_choice = 1; %1: spherical particle, 2: nanorod
    for m=1:size(av_binding_spots,2)
        for n=1:size(freq_ratio,2)
            S.set.obj.av_binding_spots=av_binding_spots(m);
            S.set.para.freq_ratio=freq_ratio(n);
            S.set.other.fixed_bind_spots=0;
            [ana, i, ROIs, set, time_trace_data, time_trace_data_non, time_trace_data_spec] = Generate_datasets(S);
            filename = strcat('C:\Users\20174314\Dropbox\_Y3Q4\BEP\BEP Dropbox\Code\Test cases\Double_events_calibration_',num2str(av_binding_spots(m)),'_ratio_',num2str(freq_ratio(n)),'_workspace.mat');
            save(filename);
        end
    end
end
filenames=[];
for m=1:size(av_binding_spots,2)
    for n=1:size(freq_ratio,2)
        filenames = [filenames, strcat("Test cases\Double_events_calibration_",num2str(av_binding_spots(m)),"_ratio_",num2str(freq_ratio(n)),"_workspace.mat")];
    end
end

%% Determine number of double events 
for m=1:size(av_binding_spots,2)
    workspaces=filenames(1+(m-1)*size(freq_ratio,2):m*size(freq_ratio,2));
    for i=1:size(workspaces,2)
        S = load(workspaces(i));
        for l=1:size(S.ROIs.ROI,2) %for each ROI separately, analysis is done
            ROIs=S.ROIs;
            ana=S.ana;
            set=S.set;
            time_trace_data=S.time_trace_data;
            time_trace_data_non=S.time_trace_data_non;
            time_trace_data_spec=S.time_trace_data_spec;
            ana = determine_category_events(ana, time_trace_data_non, time_trace_data_spec, l, makePlot, set, ROIs);
            series(m).double_events_fraction(i,l)=ana.ROI(l).numBoth/size(ana.ROI(l).SupResParams,2);
        end
    end
    series(m).double_events.mean=nanmean(series(m).double_events_fraction,2);
    series(m).double_events.std=nanstd(series(m).double_events_fraction,[],2);
    %% Plot
    if m==1
        figure
    end
    errorbar(freq_ratio, [series(m).double_events.mean]', [series(m).double_events.std]');
    hold on 
end

