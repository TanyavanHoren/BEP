function k = choice_of_method(calibration, estimation, set)
%{
Select the appropriate clustering method for the considered ROI. 
    The appropriate method is chosen from the optimization. We use the
    number of binding sites and the ratio of specific to non-specific events
    from the estimation. 

INPUTS
-------
calibration: struct containing the names of the calibration files that 
    should be used. In this case method optimization is important.  
estimation: struct containing the estimation of the number of binding sites
    and of the ratio of specific to non-specific events
set: system settings

OUTPUTS 
------
k: index of the clustering method that should be used 
    (1:Error ellipse, 2:DBSCAN, 3:GMM)

Created by Tanya van Horen - July 2020
%}

%%
load(calibration.method);
%find the closest calibration ratio and binding spot value
deviations_ratio = abs(optimization_method.options_freq_ratio-estimation.ratio);
closest_ratio = min(deviations_ratio);
id_ratio = find(deviations_ratio == closest_ratio);
if length(id_ratio)>1
    id_ratio=id_ratio(1);
end
deviations_bind = abs(optimization_method.options_av_binding_spots-estimation.number_sites);
closest_bind = min(deviations_bind);
id_bind = find(deviations_bind == closest_bind);
if length(id_bind)>1
    id_bind=id_bind(1);
end
%find the method for this closest calibration set
if set.other.system_choice==1
    k=optimization_method.circle.method(id_bind,id_ratio);
elseif set.other.system_choice==2
    k=optimization_method.rectangle.method(id_bind,id_ratio);
end
end