function ana = reject_outliers(ana, i)

radial_distance = sqrt([ana.ROI(i).SupResParams.x_coord].^2+[ana.ROI(i).SupResParams.y_coord].^2);
logical = num2cell(isoutlier(radial_distance,'median'));
[ana.ROI(i).SupResParams.isOutlier]=logical{:};
ana.ROI(i).loc.good_x = [ana.ROI(i).SupResParams.x_coord]'; %copy
ana.ROI(i).loc.good_x = ana.ROI(i).loc.good_x([ana.ROI(i).SupResParams.isOutlier]==0); %condition
ana.ROI(i).loc.good_y = [ana.ROI(i).SupResParams.y_coord]';
ana.ROI(i).loc.good_y = ana.ROI(i).loc.good_y([ana.ROI(i).SupResParams.isOutlier]==0);
end