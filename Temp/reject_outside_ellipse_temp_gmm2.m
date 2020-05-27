function ana = reject_outside_ellipse_temp_gmm2(ana,i, set, ROIs, idx_gmm, idx_right_gmm)

logical = num2cell(idx_gmm'~=idx_right_gmm.*ones(1,length(ana.ROI(i).SupResParams)));
[ana.ROI(i).SupResParams.isOutlier_GMM2]=logical{:};
%good = use for error ellipse fitting
ana.ROI(i).loc.good_frame_GMM2 = [ana.ROI(i).SupResParams.frame_idx]'; %copy
ana.ROI(i).loc.good_frame_GMM2 = [ana.ROI(i).loc.good_frame_GMM2([ana.ROI(i).SupResParams.isOutlier_GMM2]==0)]; %condition
ana.ROI(i).loc.good_x_GMM2 = [ana.ROI(i).SupResParams.x_coord]'; %copy
ana.ROI(i).loc.good_x_GMM2 = [ana.ROI(i).loc.good_x_GMM2([ana.ROI(i).SupResParams.isOutlier_GMM2]==0)]; %condition
ana.ROI(i).loc.good_y_GMM2 = [ana.ROI(i).SupResParams.y_coord]';
ana.ROI(i).loc.good_y_GMM2 = [ana.ROI(i).loc.good_y_GMM2([ana.ROI(i).SupResParams.isOutlier_GMM2]==0)];
ana.ROI(i).loc.good_GMM2 = [ana.ROI(i).loc.good_frame_GMM2 ana.ROI(i).loc.good_x_GMM2 ana.ROI(i).loc.good_y_GMM2];

[~,r_ellipse] = error_elipse_temp_gmm2(ana, i);
data = [[ana.ROI(i).SupResParams.frame_idx]' abs(inhull([[ana.ROI(i).SupResParams.x_coord]' [ana.ROI(i).SupResParams.y_coord]'], r_ellipse)-1)*2']; %check if positions in ellipse
data(data(:,2) ~= 2,:)=[]; %use to find which values to change in isOutlier_GMM2

logical = num2cell(false(1,length(ana.ROI(i).SupResParams)));
[ana.ROI(i).SupResParams.isOutlier_GMM2]=logical{:};

for j=1:size(ana.ROI(i).SupResParams,2)
    if ismember(ana.ROI(i).SupResParams(j).frame_idx,data(:,1))
        ana.ROI(i).SupResParams(j).isOutlier_GMM2=2;
    end
end
visualize_rejection_ellipse_temp_gmm2(ana,i, set, ROIs, r_ellipse);
ana.ROI(i).loc=[];

end