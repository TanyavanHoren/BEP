function ROIs = generate_binding_events_new(ROIs, set, t)

dt = set.mic.dt;
for i=1:set.ROI.number
    for j=1:ROIs.ROI(i).object_number_bind
        intensity_factor = 0;
        if t>ROIs.ROI(i).site(j).t_switch %if switch has taken place in previous frame
            t_lb=t-dt;
            while t>ROIs.ROI(i).site(j).t_switch
                if ROIs.ROI(i).site(j).isBound==0
                    tau=set.sample.tb;
                else
                    tau=set.sample.td;
                end
                t_switch_new = ROIs.ROI(i).site(j).t_switch+exprnd(tau); %determine new switch time
                intensity_factor = intensity_factor + (ROIs.ROI(i).site(j).t_switch-t_lb)/dt*ROIs.ROI(i).site(j).isBound;
                ROIs.ROI(i).site(j).isBound = abs(ROIs.ROI(i).site(j).isBound-1);
                t_lb=ROIs.ROI(i).site(j).t_switch;
                ROIs.ROI(i).site(j).t_switch=t_switch_new;
                ROIs.ROI(i).site(j).I_max=lognrnd(set.para.intensity.A*set.laser_power, set.para.intensity.B); %peak individual event
            end
            intensity_factor=intensity_factor+(t-t_lb)/dt*ROIs.ROI(i).site(j).isBound; %determine fraction bound
        else
            intensity_factor=ROIs.ROI(i).site(j).isBound;
        end
        ROIs.ROI(i).site(j).intensity_factor = intensity_factor;
    end
end
end
