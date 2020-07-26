function ROIs = generate_non_specific_events(ROIs, set, t, i)
%{
Check if new non-specific site becomes active in the frame. If so, the 
site is created (gets assigned a position, peak intensity, etc.). 
Furthermore, an intensity factor is calculated for each site. 

INPUTS
-------
ROIs: settings for the considered ROI specifically
set: system settings
t: current moment in time
i: index of considered ROI

OUTPUTS 
------
ROIs: settings for the considered ROI specifically, in this case mostly 
non-specific binding properties, such as start times, off-times, etc. 

Created by Tanya van Horen - July 2020
%}

%%
dt = set.mic.dt;
t_start = ROIs.ROI(i).non_specific.t_start;
intensity_factor=0;
number = ROIs.ROI(i).non_specific.number;

if t>t_start
    while t>t_start
        t_start_new=t_start+exprnd(ROIs.ROI(i).non_specific.period);
        number = number+1;
        ROIs.ROI(i).non_specific.site(number).data = create_non_specific_site(ROIs,i, set);
        ROIs.ROI(i).non_specific.site(number).I_max=lognrnd(set.intensity.mu, set.intensity.std);
        intensity_factor = intensity_factor + (t-t_start)/dt*ROIs.ROI(i).non_specific.site(number).I_max; %peak individual event
        ROIs.ROI(i).non_specific.site(number).intensity_factor=intensity_factor;
        t_start=t_start_new;
    end
end

ROIs.ROI(i).non_specific.t_start=t_start;
ROIs.ROI(i).non_specific.number=number;

for j=1:number
    if ROIs.ROI(i).non_specific.site(number).data.off_time > t %on for full frame 
        ROIs.ROI(i).non_specific.site(number).intensity_factor= ROIs.ROI(i).non_specific.site(number).I_max;
    else %on for only fraction
        ROIs.ROI(i).non_specific.site(number).intensity_factor = ROIs.ROI(i).non_specific.site(number).I_max*(ROIs.ROI(i).non_specific.site(number).data.off_time-(t-dt))/dt;
    end
end
end