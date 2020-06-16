function [filenames_circle, filenames_rectangle] = Generate_datasets_loop(S,av_binding_spots,freq_ratio, generate_new_data)

%% Generate datasets - circle
S.set.other.system_choice = 1; %1: spherical particle, 2: nanorod
if generate_new_data.circle==1 
    for m=1:size(av_binding_spots,2)
        for n=1:size(freq_ratio,2)
            S.set.obj.av_binding_spots=av_binding_spots(m);
            S.set.para.freq_ratio=freq_ratio(n);
            S.set.other.fixed_bind_spots=0;
            [ana, i, ROIs, set, time_trace_data, time_trace_data_non, time_trace_data_spec] = Generate_datasets(S);
            filename = strcat('C:\Users\20174314\Dropbox\_Y3Q4\BEP\BEP Dropbox\Code\Test cases\Circle_bind_',num2str(av_binding_spots(m)),'_ratio_',num2str(freq_ratio(n)),'_workspace.mat');
            save(filename);
        end
    end
end
filenames_circle=[];
for m=1:size(av_binding_spots,2)
    for n=1:size(freq_ratio,2)
        filenames_circle = [filenames_circle, strcat("Test cases\Circle_bind_",num2str(av_binding_spots(m)),"_ratio_",num2str(freq_ratio(n)),"_workspace.mat")];
    end
end

%% Generate datasets - rectangle
S.set.other.system_choice = 2; %1: spherical particle, 2: nanorod
if generate_new_data.rectangle==1 
    for m=1:size(av_binding_spots,2)
        for n=1:size(freq_ratio,2)
            S.set.obj.av_binding_spots=av_binding_spots(m);
            S.set.para.freq_ratio=freq_ratio(n);
            S.set.other.fixed_bind_spots=0;
            [ana, i, ROIs, set, time_trace_data, time_trace_data_non, time_trace_data_spec] = Generate_datasets(S);
            filename = strcat('C:\Users\20174314\Dropbox\_Y3Q4\BEP\BEP Dropbox\Code\Test cases\Rectangle_bind_',num2str(av_binding_spots(m)),'_ratio_',num2str(freq_ratio(n)),'_workspace.mat');
            save(filename);
        end
    end
end
filenames_rectangle=[];
for m=1:size(av_binding_spots,2)
    for n=1:size(freq_ratio,2)
        filenames_rectangle = [filenames_rectangle, strcat("Test cases\Rectangle_bind_",num2str(av_binding_spots(m)),"_ratio_",num2str(freq_ratio(n)),"_workspace.mat")];
    end
end
end