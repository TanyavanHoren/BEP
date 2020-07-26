function ROIs = shuffle(ROIs, set, i)
%{
Generate a sequence of bright and dark times. Prevent switching times of 
binding sites to resemble one another too much (pattern-forming). After 
shuffle, translation in time such that we will still start at t=0. 

INPUTS
-------
ROIs: number of binding sites
set: system settings
i: index of the ROI considered

OUTPUTS 
------
ROIs: properties of ROI i (specific site properties)

Created by Tanya van Horen - July 2020
%}

%%
ROIs = generate_binding_events(ROIs, set, set.other.t_shuffle, i);
for j=1:ROIs.ROI(i).object_number_bind
    ROIs.ROI(i).site(j).t_switch = ROIs.ROI(i).site(j).t_switch - set.other.t_shuffle;
end
end
