function ROIs = generate_binding_spots(ROIs, set, i)

if set.other.system_choice ==1
    for j=1:ROIs.ROI(i).object_number_bind
        r=rand()*ROIs.ROI(i).object_radius;
        theta=rand()*2*pi;
        ROIs.ROI(i).site(j).position_x=r*cos(theta);
        ROIs.ROI(i).site(j).position_y=r*sin(theta);
        ROIs.ROI(i).site(j).isBound=0;
        ROIs.ROI(i).site(j).intensity_factor=0;
        ROIs.ROI(i).site(j).t_switch=exprnd(set.sample.td); %s
    end
elseif set.other.system_choice==2
    for j=1:ROIs.ROI(i).object_number_bind
        x_prime=(-(1/2)+rand())*ROIs.ROI(i).object_size_x;
        y_prime=(-(1/2)+rand())*ROIs.ROI(i).object_size_y;
        ROIs.ROI(i).site(j).position_x=cos(ROIs.ROI(i).object_orientation)*x_prime-sin(ROIs.ROI(i).object_orientation)*y_prime;
        ROIs.ROI(i).site(j).position_y=sin(ROIs.ROI(i).object_orientation)*x_prime+cos(ROIs.ROI(i).object_orientation)*y_prime;
        ROIs.ROI(i).site(j).isBound=0;
        ROIs.ROI(i).site(j).intensity_factor=0;
        ROIs.ROI(i).site(j).t_switch=exprnd(set.sample.td); %s
    end
end
end