function ROIs = generate_binding_spots(ROIs, set, i)
%{
Determine binding site positions, initiate parameters binding sites,
determine first switch time (between states) for each site. 

INPUTS
-------
ROIs: dimensions and orientation of the particle, number of binding sites
on the particle
set: system settings (circular or rectangular particles)
i: index of the ROI considered

OUTPUTS 
------
ROIs: properties of each binding site 

Created by Tanya van Horen - July 2020
%}

%%
if set.other.system_choice ==1
    for j=1:ROIs.ROI(i).object_number_bind
        r=sqrt(rand())*ROIs.ROI(i).object_radius;
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