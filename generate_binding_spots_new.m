function object_data = generate_binding_spots_new(object_data, system_choice)

for i=1:object_data.number
    if system_choice == 1
        for j=1
            object_data.object_bindingspots(i).binding_spot(j).position_x=object_data.object(i).position_x;
            object_data.object_bindingspots(i).binding_spot(j).position_y=object_data.object(i).position_y;
            object_data.object_bindingspots(i).binding_spot(j).isBound=0;
            object_data.object_bindingspots(i).binding_spot(j).time=0;
        end
    elseif system_choice == 2
        for j=1:object_data.object(i).number_bind
            x_prime=(-(1/2)+rand())*object_data.object(i).size_x;
            y_prime=(-(1/2)+rand())*object_data.object(i).size_y;
            x=cos(object_data.object(i).orientation)*x_prime-sin(object_data.object(i).orientation)*y_prime;
            y=sin(object_data.object(i).orientation)*x_prime+cos(object_data.object(i).orientation)*y_prime;
            object_data.object_bindingspots(i).binding_spot(j).position_x=object_data.object(i).position_x+x;
            object_data.object_bindingspots(i).binding_spot(j).position_y=object_data.object(i).position_y+y;
            object_data.object_bindingspots(i).binding_spot(j).isBound=0;
            object_data.object_bindingspots(i).binding_spot(j).time=0;
        end
    end
end
