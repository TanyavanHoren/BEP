function rej = choice_of_dbscan_params(estimation, set, rej)

load calibration_dbscan_16_06_2020
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