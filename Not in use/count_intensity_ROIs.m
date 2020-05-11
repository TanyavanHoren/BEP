function time_trace_data = count_intensity_ROIs(time_trace_data, frame, n_frame, i)

time_trace_data.ROI(i).frame(n_frame) = sum(frame, 'all'); %sum over all elements of submatrix A
end
