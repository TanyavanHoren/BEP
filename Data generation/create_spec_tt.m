function time_trace_data_spec = create_spec_tt(ROIs, i, n_frame, time_trace_data_spec)

counter = 0;
for j=1:ROIs.ROI(i).object_number_bind
    if ROIs.ROI(i).site(j).intensity_factor > 0
        counter = counter+1;
    end  
end
time_trace_data_spec.ROI(i).frame(n_frame(i)) = counter;
end

 