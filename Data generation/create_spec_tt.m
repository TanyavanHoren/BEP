function counter = create_spec_tt(ROIs, i)
%{
Keep track of the amount of specific events occuring at any moment in time.

INPUTS
-------
ROIs: settings for the considered ROI specifically
i: index of considered ROI

OUTPUTS 
------
counter: the amount of specific sites 'on' at this moment in time (counting
sites that switch in the current frame to either 'on' or 'off')

Created by Tanya van Horen - July 2020
%}

%%
counter = 0;
for j=1:ROIs.ROI(i).object_number_bind
    if ROIs.ROI(i).site(j).intensity_factor > 0
        counter = counter+1;
    end  
end
end

 