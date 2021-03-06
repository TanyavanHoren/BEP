function params = spikes_analysis(time_axis, signal, set, frames)
%{
Analyze the intensity time trace. Extract among others the bright and
dark times. 

INPUTS
-------
time_axis: all time steps in the experiment
signal: intensity time trace
set: system settings
frames: frames that make up the microscope movie

OUTPUTS 
------
params: all information extracted from the intensity time trace

Edited by Tanya van Horen, received from Yuyang Wang, creator unknown
 - July 2020
%}

%%
%% initialize results
params = struct(); 
params.time_axis = time_axis;
params.CorrSignal = signal;
%% Analyze detrended signal and Thresholding based on a chosen period of time for calculating
params.threshold = set.bg.mu*set.ROI.size^2+set.ana.std_factor*set.bg.std*set.ROI.size; %std of sum N identical numbers is sqrt(N)*std_single
%% Find spikes above threshold - Adjusted!
params.spikes_pos = zeros(1,size(params.time_axis,2)); %predefine
for j=1:size(params.time_axis,2) %check if signal above threshold, account for signal dropping just below threshold for few frames
    if signal(j)>params.threshold
       params.spikes_pos(1,j)=j;
   end
end
params.spikes_log=params.spikes_pos~=0;
for j=3:size(params.time_axis,2)-2
    if params.spikes_log(j)==0
        if params.spikes_pos(1,j-1)==j-1 && params.spikes_pos(1,j+1)==j+1
            [X1,Y1] = localization_single_frame(frames(:,:,j-1), set);
            [X2,Y2] = localization_single_frame(frames(:,:,j+1), set);
            if abs(X2-X1)< set.ana.tolerance && abs(Y2-Y1)< set.ana.tolerance
                params.spikes_pos(1,j)=j;
            end
        elseif params.spikes_pos(1,j-2)==j-2 && params.spikes_pos(1,j+1)==j+1
            [X1,Y1] = localization_single_frame(frames(:,:,j-2), set);
            [X2,Y2] = localization_single_frame(frames(:,:,j+1), set);
            if abs(X2-X1)< set.ana.tolerance && abs(Y2-Y1)< set.ana.tolerance
                params.spikes_pos(1,j)=j;
            end
        end
    end
end
params.spikes_log=params.spikes_pos~=0;
params.spikes_pos = params.spikes_pos(params.spikes_log); %throw away where no events

params.spikes = signal(params.spikes_pos); % get intensities of spikes
params.fre_spikes = length(params.spikes_pos)/time_axis(end) ; % mean frequency of spikes through the whole time trace
params.spikes_only = zeros(1,length(signal));
params.spikes_only(params.spikes_pos) = 1; % spikes only for plotting
%% Find on-time distribution
if numel(params.spikes) <= 1 %% if there are no spikes, do nothing
    params.ontime = [];
    params.on_means = [];
    params.offtime = [];
    params.bg_pos = [];
    params.bg = [];   
else
    above_threshold = params.spikes_log; %
    [labeledOns, ~] = bwlabel(above_threshold);
    params.labeledOns = labeledOns ;
    props_ons = regionprops(labeledOns, 'Area')';
    params.props_ons = props_ons; 
    params.ontime = [props_ons.Area];
    params.ontime = params.ontime .* set.mic.dt;
%% Group on events and only take the maximum value from each event, and merge in to spikes. 
    params.maxspikes = zeros(1, max(params.labeledOns));
    params.maxspikes_pos = zeros(1, max(params.labeledOns));
    for j = 1 : max(params.labeledOns) %for each bright time 
            params.maxspikes(j) = max( params.CorrSignal( params.labeledOns == j ) );
            try
            params.maxspikes_pos(j) = find (params.CorrSignal == params.maxspikes(j));
            catch %if multiple frames have same value, find the one within the actual event
                temp = find (params.CorrSignal == params.maxspikes(j)); 
                k = 1;
                while k< size(temp,2)+1
                    if ismember(temp(k),find(params.labeledOns == j)) == 0
                        temp(k) =[];
                    else
                        k= k+1;
                    end
                end
                try
                params.maxspikes_pos(j) = temp;
                catch
                params.maxspikes_pos(j) = temp(1); %if multiple frames within one event have same value, choose first
                end
            end     
    end           
    %% Find on-time and intensity correlation
    for j = 1 : length(props_ons)
        pos = find(labeledOns == j);
        params.on_means(j) = max(signal(pos));
    end
    
    %% Find off-time distribution
    below_threshold = ( params.spikes_only < 1 );
    [labeledOffs, ~] = bwlabel(below_threshold);
    props_offs = regionprops(labeledOffs, 'Area');
    params.offtime = [props_offs.Area];
    params.offtime = params.offtime .*set.mic.dt;
    
    %% Find background signals
    params.bg_pos = find (signal < params.threshold) ; % get positions of background
    params.bg = signal(params.bg_pos); % get intensities of background
end
end