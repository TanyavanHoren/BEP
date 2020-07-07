function time_trace_data_non = create_non_tt(ROIs, i, n_frame, time_trace_data_non)

time_trace_data_non.ROI(i).frame(n_frame(i)) = ROIs.ROI(i).non_specific.number;
end