function counter = create_spec_tt(ROIs, i)

counter = 0;
for j=1:ROIs.ROI(i).object_number_bind
    if ROIs.ROI(i).site(j).intensity_factor > 0
        counter = counter+1;
    end  
end
end

 