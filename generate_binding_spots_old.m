function nanorod_data = generate_binding_spots(nanorod_data)

for i=1:nanorod_data.number
    for j=1:nanorod_data.nanorod(i).number_bind
        x_prime=(-(1/2)+rand())*nanorod_data.nanorod(i).size_x;
        y_prime=(-(1/2)+rand())*nanorod_data.nanorod(i).size_y;
        x=cos(nanorod_data.nanorod(i).orientation)*x_prime-sin(nanorod_data.nanorod(i).orientation)*y_prime;
        y=sin(nanorod_data.nanorod(i).orientation)*x_prime+cos(nanorod_data.nanorod(i).orientation)*y_prime;
        nanorod_data.nanorod_bindingspots(i).binding_spot(j).position_x=nanorod_data.nanorod(i).position_x+x;
        nanorod_data.nanorod_bindingspots(i).binding_spot(j).position_y=nanorod_data.nanorod(i).position_y+y;
        nanorod_data.nanorod_bindingspots(i).binding_spot(j).isBound=0;
        nanorod_data.nanorod_bindingspots(i).binding_spot(j).time=0;
    end
end
