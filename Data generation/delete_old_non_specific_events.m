function ROIs = delete_old_non_specific_events(ROIs, t, i)
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