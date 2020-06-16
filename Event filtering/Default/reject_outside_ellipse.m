function ana = reject_outside_ellipse(ana,i, set, ROIs, makePlot)

%fit error ellipse to specified points
[~,r_ellipse] = error_elipse(ana, i);
%make list with points outside the ellipse
data = [[ana.ROI(i).SupResParams.event_idx]' abs(inhull([[ana.ROI(i).SupResParams.x_coord]' [ana.ROI(i).SupResParams.y_coord]'], r_ellipse)-1)*2']; %check if positions in ellipse
data(data(:,2) ~= 2,:)=[]; %make a list of all points outside of the ellipse

%change isRej values, start with all false 
logical=num2cell(ismember([ana.ROI(i).SupResParams.event_idx],data(:,1)));
[ana.ROI(i).SupResParams.isRej_DEFAULT]=logical{:};

if makePlot == 1
    visualize_rejection_ellipse(ana,i, set, ROIs, r_ellipse);
end
end