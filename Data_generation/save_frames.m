function frame_data = save_frames(frame, n_frame, frame_data, set)

%take care to pass through frame_data itself; otherwise it cannot keep
%adding information to it
if set.other.ROI_mode == 1
    frame_data(n_frame).frame=frame;
end



