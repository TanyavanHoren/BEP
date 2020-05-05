function [obj, set, ana, frame_data] = data_generation_mode_2(t, n_frame, set, obj, ana, frame, frame_data)

%% Background (mode 1) and rest intensity
if set.other.background_mode == 1
    frame = generate_background_new(frame,set);
end
frame = generate_rest_intensity(obj, set, frame);
%% Binding and unbinding
obj = generate_binding_events(obj, set, t);
frame = generate_specific_binding_intensity(obj, set, frame);
set = generate_non_specific_binding_events(set, t);
frame = generate_nonspecific_binding_intensity(set, frame);
%% Find ROIs in frame and save frame for processing
if n_frame == 1
    ana = detect_ROI_cutoff(frame, ana); %cutoff based on first frame
end
ana = detect_ROIs(frame, ana, set);
frame_data = save_frames(frame, n_frame, frame_data);
%% Other
if mod(n_frame,set.other.visFreq) == 0
    imagesc([1:size(frame,2)], [1:size(frame,1)], frame, set.other.clims);
    title(["Frame: " num2str(n_frame)])
    pause(0.001)
end
end