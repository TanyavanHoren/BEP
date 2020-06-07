function estimation=estimation_sites_and_ratio(ana,set,i)

radial_distance = sqrt([ana.ROI(i).SupResParams.x_coord].^2+[ana.ROI(i).SupResParams.y_coord].^2);
if set.other.system_choice==1
    estimation.number_spec_loc = sum(radial_distance*set.mic.pixelsize<ones(1,length(ana.ROI(i).SupResParams)).*set.obj.av_radius);
elseif set.other.system_choice==2
    if set.obj.av_size_x>set.obj.av_size_y
        estimation.number_spec_loc = sum(radial_distance*set.mic.pixelsize<ones(1,length(ana.ROI(i).SupResParams)).*set.obj.av_size_x);
    else
        estimation.number_spec_loc = sum(radial_distance*set.mic.pixelsize<ones(1,length(ana.ROI(i).SupResParams)).*set.obj.av_size_y);
    end
end
estimation.number_non_spec_loc = size(ana.ROI(i).SupResParams,2)-estimation.number_spec_loc;
estimation.ratio = estimation.number_spec_loc/estimation.number_non_spec_loc;
av_number_loc_single_site=set.sample.tb*set.mic.frames/(set.sample.tb+set.sample.td);
estimation.number_sites=estimation.number_spec_loc/av_number_loc_single_site;

estimation.number_sites_2 = ana.ROI(i).timetrace_data.number_bind_calculated;
estimation.number_spec_loc_2 = estimation.number_sites_2*av_number_loc_single_site;
estimation.number_non_spec_loc_2 = size(ana.ROI(i).SupResParams,2)-estimation.number_spec_loc_2;
estimation.ratio_2 = estimation.number_spec_loc_2/estimation.number_non_spec_loc_2;
end