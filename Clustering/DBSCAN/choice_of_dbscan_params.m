function rej = choice_of_dbscan_params(calibration, estimation, set, rej)
%{
Select the appropriate eps and minPts values for the considered ROI. 
    The appropriate values are chosen from the optimization. We use the
    number of binding sites and the ratio of specific to non-specific events
    from the estimation. 

INPUTS
-------
calibration: struct containing the names of the calibration files that 
    should be used. In this case only DBSCAN calibration. 
estimation: struct containing the estimation of the number of binding sites
    and of the ratio of specific to non-specific events
set: system settings
rej: clustering settings (excluding eps and minPts)

OUTPUTS 
------
rej: clustering settings (including eps and minPts)

Created by Tanya van Horen - July 2020
%}

%%
load(calibration.dbscan);
%find the closest calibration ratio and binding spot value
deviations_ratio = abs(optimization_dbscan.options_freq_ratio-estimation.ratio);
closest_ratio = min(deviations_ratio);
id_ratio = find(deviations_ratio == closest_ratio);
if length(id_ratio)>1
    id_ratio=id_ratio(1);
end
deviations_bind = abs(optimization_dbscan.options_av_binding_spots-estimation.number_sites);
closest_bind = min(deviations_bind);
id_bind = find(deviations_bind == closest_bind);
if length(id_bind)>1
    id_bind=id_bind(1);
end
%find the eps and minPts value for this closest calibration set
if set.other.system_choice==1
    rej.dbscan_eps=optimization_dbscan.circle.eps(id_bind,id_ratio);
    rej.dbscan_minPts=round(optimization_dbscan.circle.minPts(id_bind,id_ratio));
elseif set.other.system_choice==2
    rej.dbscan_eps=optimization_dbscan.rectangle.eps(id_bind,id_ratio);
    rej.dbscan_minPts=round(optimization_dbscan.rectangle.minPts(id_bind,id_ratio));
end
end