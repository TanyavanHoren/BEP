function ana = reject_outside_ellipse(ana,i, set, ROIs, makePlot)
%{
Fit an error ellipse to the event localizations (that were determined
    to be inliers). Distinguish between event localizations inside and 
    outside the error ellipse. 

INPUTS
-------
ana: struct containing results from analysis, such as the intermediate
    event classifications
i: index of considered ROI
set: system settings
ROIs: settings specific to considered ROI
makePlot: do not make plot (if 0), or do make plot (if 1)

OUTPUTS 
------
ana: struct containing results from analysis, such as the 
    event classifications

Created by Tanya van Horen - July 2020
%}

%%
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