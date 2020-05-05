function frame = generate_background_new(frame, set)

for i=1:set.mic.pixels_x
    for j=1:set.mic.pixels_y
        frame(j,i) = frame(j,i) + int16(normrnd(set.sample.background_frame(j,i),-11.8+0.031*set.sample.background_frame(j,i)));
    end
end
end