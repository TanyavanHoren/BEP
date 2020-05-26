function ana = reject_outliers_temp(ana, i, set, ROIs)

radial_distance = sqrt([ana.ROI(i).SupResParams.x_coord].^2+[ana.ROI(i).SupResParams.y_coord].^2);
% logical = num2cell(isoutlier(radial_distance,'percentiles', [0 85]));
logical = num2cell(radial_distance>ones(1,length(ana.ROI(i).SupResParams)).*(set.obj.av_radius+5*sqrt(set.obj.av_radius)));
[ana.ROI(i).SupResParams.isOutlier]=logical{:};
ana.ROI(i).loc.good_frame = [ana.ROI(i).SupResParams.frame_idx]'; %copy
ana.ROI(i).loc.good_frame = [ana.ROI(i).loc.good_frame([ana.ROI(i).SupResParams.isOutlier]==0)]; %condition
ana.ROI(i).loc.good_x = [ana.ROI(i).SupResParams.x_coord]'; %copy
ana.ROI(i).loc.good_x = [ana.ROI(i).loc.good_x([ana.ROI(i).SupResParams.isOutlier]==0)]; %condition
ana.ROI(i).loc.good_y = [ana.ROI(i).SupResParams.y_coord]';
ana.ROI(i).loc.good_y = [ana.ROI(i).loc.good_y([ana.ROI(i).SupResParams.isOutlier]==0)];
ana.ROI(i).loc.good = [ana.ROI(i).loc.good_frame ana.ROI(i).loc.good_x ana.ROI(i).loc.good_y];
visualize_rejection_outliers(ana,i, set, ROIs)
end