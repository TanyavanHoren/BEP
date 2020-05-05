function [obj, set, ana] = data_generation_mode_3(t, n_frame, set, obj, ana, frame)

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
%% Place ROIs in a vector and make timetraces
if n_frame == 1
    ana = generate_ROI_vector_mode_3(ana, set, obj); %use known positions
end
ana = count_intensity_ROIs(ana, frame, n_frame);
%% Other
if mod(n_frame,set.other.visFreq) == 0
    imagesc([1:size(frame,2)], [1:size(frame,1)], frame, set.other.clims);
    title(["Frame: " num2str(n_frame)])
    pause(0.001)
end

end