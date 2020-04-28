function obj = generate_binding_spots_new(obj, set)

for i=1:obj.gen.number
    if set.other.system_choice == 1
        for j=1
            obj.object(i).site(j).position_x=obj.object(i).position_x;
            obj.object(i).site(j).position_y=obj.object(i).position_y;
            obj.object(i).site(j).isBound=0;
            obj.object(i).site(j).intensity_factor =0;
            obj.object(i).site(j).t_switch=exprnd(set.sample.td);
        end
    elseif set.other.system_choice == 2
        for j=1:obj.object(i).number_bind
            x_prime=(-(1/2)+rand())*obj.object(i).size_x;
            y_prime=(-(1/2)+rand())*obj.object(i).size_y;
            x=cos(obj.object(i).orientation)*x_prime-sin(obj.object(i).orientation)*y_prime;
            y=sin(obj.object(i).orientation)*x_prime+cos(obj.object(i).orientation)*y_prime;
            obj.object(i).site(j).position_x=obj.object(i).position_x+x;
            obj.object(i).site(j).position_y=obj.object(i).position_y+y;
            obj.object(i).site(j).isBound=0;
            obj.object(i).site(j).intensity_factor =0;
            obj.object(i).site(j).t_switch=exprnd(set.sample.td);
        end
    end
end
