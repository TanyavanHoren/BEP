function ROIs = delete_old_non_specific_events(ROIs, t, i)
%{
Remove all non-specific sites that have become inactive in the past frame
from the list of non-specific sites. 

INPUTS
-------
ROIs: settings for the considered ROI specifically (including the list
of non-specific sites)
t: current moment in time
i: index of considered ROI

OUTPUTS 
------
ROIs: settings for the considered ROI specifically (including the updated
list of non-specific sites)

Created by Tanya van Horen - July 2020
%}

%%
j=1;
while j < ROIs.ROI(i).non_specific.number+1
    if t>ROIs.ROI(i).non_specific.site(j).data.off_time %if the binding site has turned off 
        ROIs.ROI(i).non_specific.site(j)=[];
        ROIs.ROI(i).non_specific.number=ROIs.ROI(i).non_specific.number-1;
    else
        j=j+1;
    end
end
end