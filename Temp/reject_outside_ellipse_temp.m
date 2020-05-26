function ana = reject_outside_ellipse_temp(ana,i, set, ROIs)

[~,r_ellipse] = error_elipse(ana, i);
data = [ana.ROI(i).loc.good(:,1) abs(inhull(ana.ROI(i).loc.good(:,2:3), r_ellipse)-1)*2']; %check if positions in ellipse
data(data(:,2) ~= 2,:)=[];

for j=1:size(ana.ROI(i).SupResParams,2)
    if ismember(ana.ROI(i).SupResParams(j).frame_idx,data(:,1))
        ana.ROI(i).SupResParams(j).isOutlier=2;
    end
end
visualize_rejection_ellipse(ana,i, set, ROIs, r_ellipse);
ana.ROI(i).loc=[];

end