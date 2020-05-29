function ana = reject_outside_ellipse(ana,i, set, ROIs, makePlot)

%fit error ellipse to specified points
[~,r_ellipse] = error_elipse(ana, i);
%make list with points outside the ellipse
data = [ana.ROI(i).loc.good(:,1) abs(inhull(ana.ROI(i).loc.good(:,2:3), r_ellipse)-1)*2']; %check if positions in ellipse
data(data(:,2) ~= 2,:)=[];

%change isOutlier values 
for j=1:size(ana.ROI(i).SupResParams,2)
    if ismember(ana.ROI(i).SupResParams(j).frame_idx,data(:,1))
        ana.ROI(i).SupResParams(j).isOutlier=2;
    end
end

if makePlot == 1
    visualize_rejection_ellipse(ana,i, set, ROIs, r_ellipse);
end

ana.ROI(i).loc=[];

end