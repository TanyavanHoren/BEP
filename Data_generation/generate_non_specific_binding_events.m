function obj = generate_non_specific_binding_events(obj, set, t)

dt = set.mic.dt;
for i=1:obj.non.N
    isBound = obj.non.site(i).isBound;
    t_switch = obj.non.site(i).t_switch;
    intensity_factor = 0;
    if t>t_switch
        t_lb=t-dt;
        while t>t_switch
            if isBound==0 
                tau=obj.non.site(i).tb; %same as non-specific, but with varying tb/td
            else
                tau=obj.non.site(i).td;
            end
            t_switch_new = t_switch+exprnd(tau); 
            intensity_factor = intensity_factor + (t_switch-t_lb)/dt*isBound;
            isBound = abs(isBound-1);
            t_lb=t_switch;
            t_switch=t_switch_new;
            obj.non.site(i).I_max=lognrnd(obj.non.site(i).I_mean,0.73);
        end
        intensity_factor=intensity_factor+(t-t_lb)/dt*isBound;
    else
        intensity_factor=isBound;
    end
    obj.non.site(i).isBound=isBound;
    obj.non.site(i).t_switch=t_switch;
    obj.non.site(i).intensity_factor = intensity_factor;
end
end
