function obj = generate_binding_events_new(obj, set, t)

dt = set.mic.dt;
for i=1:obj.gen.number
    for j=1:obj.object(i).number_bind
        intensity_factor = 0;
        if t>obj.object(i).site(j).t_switch %if switch has taken place in previous frame
            t_lb=t-dt;  
            while t>obj.object(i).site(j).t_switch
                if obj.object(i).site(j).isBound==0 
                    tau=set.sample.tb; 
                else
                    tau=set.sample.td;
                end
                t_switch_new = obj.object(i).site(j).t_switch+exprnd(tau); %determine new switch time
                intensity_factor = intensity_factor + (obj.object(i).site(j).t_switch-t_lb)/dt*obj.object(i).site(j).isBound; 
                obj.object(i).site(j).isBound = abs(obj.object(i).site(j).isBound-1);
                t_lb=obj.object(i).site(j).t_switch;
                obj.object(i).site(j).t_switch=t_switch_new;
                obj.object(i).site(j).I_max=lognrnd(obj.object(i).site(j).I_mean,0.73);
            end
            intensity_factor=intensity_factor+(t-t_lb)/dt*obj.object(i).site(j).isBound; %determine fraction bound
        else
            intensity_factor=obj.object(i).site(j).isBound;
        end
        obj.object(i).site(j).intensity_factor = intensity_factor;
    end
end
end
