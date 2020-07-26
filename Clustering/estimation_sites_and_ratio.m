function estimation=estimation_sites_and_ratio(ana,set,i,rej)
%{
Provide an estimation of the number of binding sites in the ROI and its 
    ratio of specific to non-specific events. 

INPUTS
-------
ana: struct containing results from analysis
set: system settings
i: index of the ROI considered
rej: settings for clustering, in this case the factor that indicates from
    which distance a point is considered to be an outlier

OUTPUTS 
------
estimation: struct containing the estimation of the number of binding sites
    and of the ratio of specific to non-specific events

Created by Tanya van Horen - July 2020
%}

%%
radial_distance = sqrt([ana.ROI(i).SupResParams.x_coord].^2+[ana.ROI(i).SupResParams.y_coord].^2);
if set.other.system_choice==1
    estimation.number_spec_events = sum(radial_distance*set.mic.pixelsize<ones(1,length(ana.ROI(i).SupResParams)).*(rej.outlier_factor*set.obj.av_radius));
elseif set.other.system_choice==2
    if set.obj.av_size_x>set.obj.av_size_y
        estimation.number_spec_events = sum(radial_distance*set.mic.pixelsize<ones(1,length(ana.ROI(i).SupResParams)).*(rej.outlier_factor*set.obj.av_size_x/2));
    else
        estimation.number_spec_events = sum(radial_distance*set.mic.pixelsize<ones(1,length(ana.ROI(i).SupResParams)).*(rej.outlier_factor*set.obj.av_size_y/2));
    end
end
estimation.number_non_spec_events = size(ana.ROI(i).SupResParams,2)-estimation.number_spec_events;
estimation.ratio = estimation.number_spec_events/estimation.number_non_spec_events;
av_number_events_single_site=set.mic.dt*set.mic.frames/(set.sample.tb+set.sample.td);
estimation.number_sites=estimation.number_spec_events/av_number_events_single_site;
end