function ana = reject_outside_ellipse_temp_dbscan3(ana,i, set, ROIs, makePlot)

%good = use for error ellipse fitting
ana.ROI(i).loc.good_frame_DBSCAN3 = [ana.ROI(i).SupResParams.frame_idx]'; %copy
ana.ROI(i).loc.good_frame_DBSCAN3 = [ana.ROI(i).loc.good_frame_DBSCAN3([ana.ROI(i).SupResParams.isOutlier_DBSCAN3]==0)]; %condition
ana.ROI(i).loc.good_x_DBSCAN3 = [ana.ROI(i).SupResParams.x_coord]'; %copy
ana.ROI(i).loc.good_x_DBSCAN3 = [ana.ROI(i).loc.good_x_DBSCAN3([ana.ROI(i).SupResParams.isOutlier_DBSCAN3]==0)]; %condition
ana.ROI(i).loc.good_y_DBSCAN3 = [ana.ROI(i).SupResParams.y_coord]';
ana.ROI(i).loc.good_y_DBSCAN3 = [ana.ROI(i).loc.good_y_DBSCAN3([ana.ROI(i).SupResParams.isOutlier_DBSCAN3]==0)];
ana.ROI(i).loc.good_DBSCAN3 = [ana.ROI(i).loc.good_frame_DBSCAN3 ana.ROI(i).loc.good_x_DBSCAN3 ana.ROI(i).loc.good_y_DBSCAN3];

[~,r_ellipse] = error_elipse_temp_dbscan3(ana, i);
data = [[ana.ROI(i).SupResParams.frame_idx]' abs(inhull([[ana.ROI(i).SupResParams.x_coord]' [ana.ROI(i).SupResParams.y_coord]'], r_ellipse)-1)*2']; %check if positions in ellipse
data(data(:,2) ~= 2,:)=[]; %use to find which values to change in isOutlier_GMM2

logical = num2cell(false(1,length(ana.ROI(i).SupResParams))); %reset; we only want to judge based on error ellipse
[ana.ROI(i).SupResParams.isOutlier_DBSCAN3]=logical{:};

for j=1:size(ana.ROI(i).SupResParams,2)
    if ismember(ana.ROI(i).SupResParams(j).frame_idx,data(:,1))
        ana.ROI(i).SupResParams(j).isOutlier_DBSCAN3=2;
    end
end
if makePlot==1
    visualize_rejection_ellipse_temp_dbscan3(ana,i, set, ROIs, r_ellipse);
end
ana.ROI(i).loc=[];
end