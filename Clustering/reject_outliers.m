function ana = reject_outliers(ana, i, set, ROIs, makePlot, rej)

radial_distance = sqrt([ana.ROI(i).SupResParams.x_coord].^2+[ana.ROI(i).SupResParams.y_coord].^2);
ana.outlier.logical = num2cell(radial_distance>ones(1,length(ana.ROI(i).SupResParams)).*(set.obj.av_radius+rej.outlier_std_factor*sqrt(set.obj.av_radius)));
[ana.ROI(i).SupResParams.isOutlier]=ana.outlier.logical{:}; 
%'good' is anything not outlier -> these points can be used for further analysis 
ana.ROI(i).loc.good_frame = [ana.ROI(i).SupResParams.frame_idx]'; %copy
ana.ROI(i).loc.good_frame = [ana.ROI(i).loc.good_frame([ana.ROI(i).SupResParams.isOutlier]==0)]; %condition
ana.ROI(i).loc.good_x = [ana.ROI(i).SupResParams.x_coord]'; %copy
ana.ROI(i).loc.good_x = [ana.ROI(i).loc.good_x([ana.ROI(i).SupResParams.isOutlier]==0)]; %condition
ana.ROI(i).loc.good_y = [ana.ROI(i).SupResParams.y_coord]';
ana.ROI(i).loc.good_y = [ana.ROI(i).loc.good_y([ana.ROI(i).SupResParams.isOutlier]==0)];
ana.ROI(i).loc.good = [ana.ROI(i).loc.good_frame ana.ROI(i).loc.good_x ana.ROI(i).loc.good_y];
if makePlot==1
    visualize_rejection_outliers(ana,i, set, ROIs)
end
end