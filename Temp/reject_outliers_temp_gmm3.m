function ana = reject_outliers_temp_gmm3(ana, i, set, ROIs, makePlot, rej)

radial_distance = sqrt([ana.ROI(i).SupResParams.x_coord].^2+[ana.ROI(i).SupResParams.y_coord].^2);
% logical = num2cell(isoutlier(radial_distance,'percentiles', [0 85]));
logical = num2cell(radial_distance>ones(1,length(ana.ROI(i).SupResParams)).*(set.obj.av_radius+rej.outlier_std_factor*sqrt(set.obj.av_radius)));
[ana.ROI(i).SupResParams.isOutlier_GMM3]=logical{:};
ana.ROI(i).loc.good_frame_GMM3 = [ana.ROI(i).SupResParams.frame_idx]'; %copy
ana.ROI(i).loc.good_frame_GMM3 = [ana.ROI(i).loc.good_frame_GMM3([ana.ROI(i).SupResParams.isOutlier_GMM3]==0)]; %condition
ana.ROI(i).loc.good_x_GMM3 = [ana.ROI(i).SupResParams.x_coord]'; %copy
ana.ROI(i).loc.good_x_GMM3 = [ana.ROI(i).loc.good_x_GMM3([ana.ROI(i).SupResParams.isOutlier_GMM3]==0)]; %condition
ana.ROI(i).loc.good_y_GMM3 = [ana.ROI(i).SupResParams.y_coord]';
ana.ROI(i).loc.good_y_GMM3 = [ana.ROI(i).loc.good_y_GMM3([ana.ROI(i).SupResParams.isOutlier_GMM3]==0)];
ana.ROI(i).loc.good_GMM3 = [ana.ROI(i).loc.good_frame_GMM3 ana.ROI(i).loc.good_x_GMM3 ana.ROI(i).loc.good_y_GMM3];
if makePlot==1
    visualize_rejection_outliers_temp_gmm3(ana,i, set, ROIs)
end
end