function estimation=estimation_sites_and_ratio(ana,set,i,rej)

% median_x=ones(1,size(ana.ROI(i).SupResParams,2)).*median([ana.ROI(i).SupResParams.x_coord]);
% median_y=ones(1,size(ana.ROI(i).SupResParams,2)).*median([ana.ROI(i).SupResParams.y_coord]);
% radial_distance = sqrt(([ana.ROI(i).SupResParams.x_coord]-median_x).^2+([ana.ROI(i).SupResParams.y_coord]-median_y).^2);
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

estimation.number_sites_2 = ana.ROI(i).timetrace_data.number_bind_calculated;
estimation.number_spec_events_2 = estimation.number_sites_2*av_number_events_single_site;
estimation.number_non_spec_events_2 = size(ana.ROI(i).SupResParams,2)-estimation.number_spec_events_2;
estimation.ratio_2 = estimation.number_spec_events_2/estimation.number_non_spec_events_2;
end