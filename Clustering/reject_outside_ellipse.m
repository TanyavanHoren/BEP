function ana = reject_outside_ellipse(ana,i, set, ROIs, makePlot)

%fit error ellipse to specified points
[~,r_ellipse] = error_elipse(ana, i);
%make list with points outside the ellipse
<<<<<<< HEAD
data = [[ana.ROI(i).SupResParams.frame_idx]' abs(inhull([[ana.ROI(i).SupResParams.x_coord]' [ana.ROI(i).SupResParams.y_coord]'], r_ellipse)-1)*2']; %check if positions in ellipse
data(data(:,2) ~= 2,:)=[]; %make a list of all points outside of the ellipse
logical = num2cell(false(1,length(ana.ROI(i).SupResParams))); %reset; we only want to judge based on error ellipse
[ana.ROI(i).SupResParams.isRej_DEFAULT]=logical{:};

%change isRej values 
for j=1:size(ana.ROI(i).SupResParams,2)
    if ismember(ana.ROI(i).SupResParams(j).frame_idx,data(:,1))
        ana.ROI(i).SupResParams(j).isRej_DEFAULT=2;
    end
end
=======
data = [[ana.ROI(i).SupResParams.event_idx]' abs(inhull([[ana.ROI(i).SupResParams.x_coord]' [ana.ROI(i).SupResParams.y_coord]'], r_ellipse)-1)*2']; %check if positions in ellipse
data(data(:,2) ~= 2,:)=[]; %make a list of all points outside of the ellipse

%change isRej values, start with all false 
logical=num2cell(ismember([ana.ROI(i).SupResParams.event_idx],data(:,1)));
[ana.ROI(i).SupResParams.isRej_DEFAULT]=logical{:};
>>>>>>> Merged-ROIs

if makePlot == 1
    visualize_rejection_ellipse(ana,i, set, ROIs, r_ellipse);
end
end