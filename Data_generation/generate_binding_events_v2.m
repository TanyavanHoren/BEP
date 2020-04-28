function object_data = generate_binding_events_v2(object_data, experiment_data, t, analysis_data)

dt = analysis_data.dt;

for i=1:object_data.number
    for j=1:object_data.object(i).number_bind
        isBound = object_data.object_bindingspots(i).binding_spot(j).isBound;
        t_switch = object_data.object_bindingspots(i).binding_spot(j).t_switch;
        intensity_factor = 0;
        
        if t>t_switch
            t_lb=t-dt;
            
            while t>t_switch
                
                if isBound==0 %the state WAS 0 (we did not adjust it yet)
                    tau=experiment_data.tb;
                else
                    tau=experiment_data.td;
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
        object_data.object_bindingspots(i).binding_spot(j).isBound=isBound;
        object_data.object_bindingspots(i).binding_spot(j).t_switch=t_switch;
        object_data.object_bindingspots(i).binding_spot(j).intensity_factor = intensity_factor;
    end
end
