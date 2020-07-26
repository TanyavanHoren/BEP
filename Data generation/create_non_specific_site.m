function site = create_non_specific_site(ROIs, i, set)
%{
Make new non-specific site. Assign it a position in the frame. Determine
the event duration. Determine the time at which the site becomes inactive.

INPUTS
-------
ROIs: settings for the considered ROI specifically
set: system settings
i: index of considered ROI

OUTPUTS 
------
site: properties of the site that is created

Created by Tanya van Horen - July 2020
%}

%%
site.position_x = (-set.ROI.size/2+rand()*set.ROI.size)*set.mic.pixelsize;
site.position_y = (-set.ROI.size/2+rand()*set.ROI.size)*set.mic.pixelsize;
if set.other.system_choice == 1
    while site.position_x^2 + site.position_y^2 < ROIs.ROI(i).object_radius^2
        if rand() > set.sample.non_on_object_chance
            site.position_x = (-set.ROI.size/2+rand()*set.ROI.size)*set.mic.pixelsize;
            site.position_y =  (-set.ROI.size/2+rand()*set.ROI.size)*set.mic.pixelsize;
        end
    end
elseif set.other.system_choice == 2
    x_prime = cos(ROIs.ROI(i).object_orientation)*site.position_x+sin(ROIs.ROI(i).object_orientation)*site.position_y;
    y_prime = -sin(ROIs.ROI(i).object_orientation)*site.position_x+cos(ROIs.ROI(i).object_orientation)*site.position_y;
    while abs(x_prime) < (1/2)*ROIs.ROI(i).object_size_x  && abs(y_prime) < (1/2)*ROIs.ROI(i).object_size_y
        if rand() > set.sample.non_on_object_chance
            site.position_x = (-set.ROI.size/2+rand()*set.ROI.size)*set.mic.pixelsize;
            site.position_y= (-set.ROI.size/2+rand()*set.ROI.size)*set.mic.pixelsize;
            x_prime = cos(ROIs.ROI(i).object_orientation)*site.position_x+sin(ROIs.ROI(i).object_orientation)*site.position_y;
            y_prime = -sin(ROIs.ROI(i).object_orientation)*site.position_x+cos(ROIs.ROI(i).object_orientation)*site.position_y;
        end
    end
end

t_b = set.sample.non_lowbound_tb + rand()*(set.sample.non_upbound_tb-set.sample.non_lowbound_tb);
site.off_time = ROIs.ROI(i).non_specific.t_start+t_b;

end