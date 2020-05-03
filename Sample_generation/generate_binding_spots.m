function obj = generate_binding_spots(obj, set)

for i=1:obj.gen.number
    if set.other.system_choice==1 %(x,y)site = (x,y)object
        for j=1
            obj.object(i).site(j).position_x=obj.object(i).position_x; %mu
            obj.object(i).site(j).position_y=obj.object(i).position_y; %mu
            obj.object(i).site(j).isBound=0; 
            obj.object(i).site(j).intensity_factor=0;
            obj.object(i).site(j).t_switch=exprnd(set.sample.td); %s
        end
    elseif set.other.system_choice==2 %(x,y)site anywhere on object
        for j=1:obj.object(i).number_bind 
            x_prime=(-(1/2)+rand())*obj.object(i).size_x;
            y_prime=(-(1/2)+rand())*obj.object(i).size_y;
            x=cos(obj.object(i).orientation)*x_prime-sin(obj.object(i).orientation)*y_prime;
            y=sin(obj.object(i).orientation)*x_prime+cos(obj.object(i).orientation)*y_prime;
            obj.object(i).site(j).position_x=obj.object(i).position_x+x;
            obj.object(i).site(j).position_y=obj.object(i).position_y+y;
            obj.object(i).site(j).isBound=0;
            obj.object(i).site(j).intensity_factor=0;
            obj.object(i).site(j).t_switch=exprnd(set.sample.td); %s
        end
    end
end
