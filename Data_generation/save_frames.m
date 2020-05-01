function frame_data = save_frames(frame, n_frame, frame_data)

%take care to pass through frame_data itself; otherwise it cannot keep
%adding information to it
frame_data(n_frame).frame=frame;
end



