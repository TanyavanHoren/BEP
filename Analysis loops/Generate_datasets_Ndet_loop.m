function [filenames_circle, filenames_rectangle] = Generate_datasets_Ndet_loop(S,av_binding_spots,freq_ratio, generate_new_data)
%{
Generate the datasets (for both circular and rectangular particles) that
we will need to assess the improvement in binding site quantification. 
List the filenames in a struct such that the datasets can be loaded in 
easily later. 

INPUTS
-------
S: settings that have to be taken into account for data generation 
    f.e. number of ROIs
av_binding_spots: average binding site numbers tested
freq_ratio: ratios of specific to non-specific events tested
generate_new_data: 0 if no new data has to generated, 1 if new data has to 
    be generated

OUTPUTS 
------
filenames_circle: filenames of the circular particle datasets
filenames_rectangle: filenames of the rectangular particle datasets
datasets (saved in folder)

Created by Tanya van Horen - July 2020
%}

%% Generate datasets - circle
S.set.other.system_choice = 1; %1: spherical particle, 2: nanorod
if generate_new_data.circle==1 
    for m=1:size(av_binding_spots,2)
        for n=1:size(freq_ratio,2)
            S.set.obj.av_binding_spots=av_binding_spots(m);
            S.set.para.freq_ratio=freq_ratio(n);
            S.set.other.fixed_bind_spots=1; %the number of binding sites does not vary from ROI to ROI (no Poisson distribution)
            [ana, i, ROIs, set, time_trace_data, time_trace_data_non, time_trace_data_spec] = Generate_datasets(S);
            filename = strcat('C:\Users\20174314\Dropbox\_Y3Q4\BEP\BEP Dropbox\Code\Test cases\Ndet_Circle_bind_',num2str(av_binding_spots(m)),'_ratio_',num2str(freq_ratio(n)),'_workspace.mat');
            save(filename);
        end
    end
end
filenames_circle=[];
for m=1:size(av_binding_spots,2)
    for n=1:size(freq_ratio,2)
        filenames_circle = [filenames_circle, strcat("Test cases\Ndet_Circle_bind_",num2str(av_binding_spots(m)),"_ratio_",num2str(freq_ratio(n)),"_workspace.mat")];
    end
end

%% Generate datasets - rectangle
S.set.other.system_choice = 2; %1: spherical particle, 2: nanorod
if generate_new_data.rectangle==1 
    for m=1:size(av_binding_spots,2)
        for n=1:size(freq_ratio,2)
            S.set.obj.av_binding_spots=av_binding_spots(m);
            S.set.para.freq_ratio=freq_ratio(n);
            S.set.other.fixed_bind_spots=1; %the number of binding sites does not vary from ROI to ROI (no Poisson distribution)
            [ana, i, ROIs, set, time_trace_data, time_trace_data_non, time_trace_data_spec] = Generate_datasets(S);
            filename = strcat('C:\Users\20174314\Dropbox\_Y3Q4\BEP\BEP Dropbox\Code\Test cases\Ndet_Rectangle_bind_',num2str(av_binding_spots(m)),'_ratio_',num2str(freq_ratio(n)),'_workspace.mat');
            save(filename);
        end
    end
end
filenames_rectangle=[];
for m=1:size(av_binding_spots,2)
    for n=1:size(freq_ratio,2)
        filenames_rectangle = [filenames_rectangle, strcat("Test cases\Ndet_Rectangle_bind_",num2str(av_binding_spots(m)),"_ratio_",num2str(freq_ratio(n)),"_workspace.mat")];
    end
end
end