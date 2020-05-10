function ROIs = generate_binding_events(ROIs, set, t, i)

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
            intensity_factor = intensity_factor + (t_switch-t_lb)/dt*isBound;
            isBound = abs(isBound-1);
            t_lb=t_switch;
            t_switch=t_switch_new;
            ROIs.ROI(i).site(j).I_max=lognrnd(set.intensity.mu, set.intensity.std); %peak individual event
        end
        intensity_factor=intensity_factor+(t-t_lb)/dt*isBound; %determine fraction bound
    else
        intensity_factor=isBound;
    end
    ROIs.ROI(i).site(j).isBound=isBound;
    ROIs.ROI(i).site(j).t_switch=t_switch;
    ROIs.ROI(i).site(j).intensity_factor = intensity_factor; 
end
end
