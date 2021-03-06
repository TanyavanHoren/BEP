function ana = reject_outliers(ana, i, set, ROIs, makePlot, rej)
%{
Perform outlier rejection on the event localizations. 

INPUTS
-------
ana: struct containing results from analysis
i: index of the ROI considered
set: system settings
ROIs: settings for the considered ROI specifically
makePlot: do not make plot (if 0), or do make plot (if 1)
rej: settings for clustering

OUTPUTS 
------
ana: struct containing results from analysis (updated)

Created by Tanya van Horen - July 2020
%}

%%
radial_distance = sqrt([ana.ROI(i).SupResParams.x_coord].^2+[ana.ROI(i).SupResParams.y_coord].^2);
if set.other.system_choice==1
    ana.outlier.logical = num2cell(radial_distance*set.mic.pixelsize>ones(1,length(ana.ROI(i).SupResParams)).*(rej.outlier_factor*set.obj.av_radius));
elseif set.other.system_choice==2
    if set.obj.av_size_x>set.obj.av_size_y
        ana.outlier.logical = num2cell(radial_distance*set.mic.pixelsize>ones(1,length(ana.ROI(i).SupResParams)).*(rej.outlier_factor*set.obj.av_size_x/2));
    else
        ana.outlier.logical = num2cell(radial_distance*set.mic.pixelsize>ones(1,length(ana.ROI(i).SupResParams)).*(rej.outlier_factor*set.obj.av_size_y/2));
    end
end
[ana.ROI(i).SupResParams.isOutlier]=ana.outlier.logical{:}; 
%'good' is anything not outlier -> these points can be used for further analysis 
ana.ROI(i).loc.good_event = [ana.ROI(i).SupResParams.event_idx]'; %copy
ana.ROI(i).loc.good_event = [ana.ROI(i).loc.good_event([ana.ROI(i).SupResParams.isOutlier]==0)]; %condition
ana.ROI(i).loc.good_x = [ana.ROI(i).SupResParams.x_coord]'; %copy
ana.ROI(i).loc.good_x = [ana.ROI(i).loc.good_x([ana.ROI(i).SupResParams.isOutlier]==0)]; %condition
ana.ROI(i).loc.good_y = [ana.ROI(i).SupResParams.y_coord]';
ana.ROI(i).loc.good_y = [ana.ROI(i).loc.good_y([ana.ROI(i).SupResParams.isOutlier]==0)];
ana.ROI(i).loc.good = [ana.ROI(i).loc.good_event ana.ROI(i).loc.good_x ana.ROI(i).loc.good_y];
if makePlot==1
    visualize_rejection_outliers(ana,i, set, ROIs)
end
end