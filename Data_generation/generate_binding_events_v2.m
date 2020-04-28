function obj = generate_binding_events_v2(obj, set, t)

dt = set.mic.dt;

for i=1:obj.gen.number
    for j=1:obj.object(i).number_bind
        isBound = obj.object(i).site(j).isBound;
        t_switch = obj.object(i).site(j).t_switch;
        intensity_factor = 0;
        if t>t_switch
            t_lb=t-dt;  
            while t>t_switch
                if isBound==0 %the state WAS 0 (we did not adjust it yet)
                    tau=set.sample.tb;
                else
                    tau=set.sample.td;
                end
                t_switch_new = t_switch+exprnd(tau); %find the time of the next switch 
                intensity_factor = intensity_factor + (t_switch-t_lb)/dt*isBound; 
                isBound = abs(isBound-1);
                t_lb=t_switch;
                t_switch=t_switch_new;
            end
            intensity_factor=intensity_factor+(t-t_lb)/dt*isBound;
        else
            intensity_factor=isBound;
        end
        obj.object(i).site(j).isBound=isBound;
        obj.object(i).site(j).t_switch=t_switch;
        obj.object(i).site(j).intensity_factor = intensity_factor;
    end
end
