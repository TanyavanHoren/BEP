function ROIs = generate_binding_events(ROIs, set, t, i)
%{
For each site, adapt switch time if an event takes place in the frame,
keep isBound (state) up to date, determine the fraction of the frame in 
which a binding event took place, determine the intensity of a new 
event if necessary.

INPUTS
-------
ROIs: settings for the considered ROI specifically
set: system settings
t: current moment in time
i: index of considered ROI

OUTPUTS 
------
ROIs: settings for the considered ROI specifically, in this case mostly 
specific binding site properties, such as switch times, isBound values,
event intensities. 

Created by Tanya van Horen - July 2020
%}


%%
dt = set.mic.dt;

for j=1:ROIs.ROI(i).object_number_bind
    isBound = ROIs.ROI(i).site(j).isBound;
    t_switch = ROIs.ROI(i).site(j).t_switch;
    intensity_factor = 0;
    if t>t_switch %if switch has taken place in previous frame
        t_lb=t-dt;
        while t>t_switch
            if isBound==0
                tau=set.sample.tb;
            else
                tau=set.sample.td;
            end
            t_switch_new = t_switch+exprnd(tau); %determine new switch time
            ROIs.ROI(i).site(j).I_max=lognrnd(set.intensity.mu, set.intensity.std);
            intensity_factor = intensity_factor + (t_switch-t_lb)/dt*isBound*ROIs.ROI(i).site(j).I_max; %peak individual event
            isBound = abs(isBound-1);
            t_lb=t_switch;
            t_switch=t_switch_new;
        end
        intensity_factor=intensity_factor+(t-t_lb)/dt*isBound*ROIs.ROI(i).site(j).I_max; %determine fraction bound %peak individual event
    else
        intensity_factor=isBound*ROIs.ROI(i).site(j).I_max; %peak individual event
    end
    ROIs.ROI(i).site(j).isBound=isBound;
    ROIs.ROI(i).site(j).t_switch=t_switch;
    ROIs.ROI(i).site(j).intensity_factor = intensity_factor; 
end
end
