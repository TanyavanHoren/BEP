function frame = generate_background_new(frame, set)

sigma_frame = set.para.D+set.para.E.*set.sample.background_frame; %relation Maartje
for i=1:set.mic.pixels_y
    for j=1:set.mic.pixels_x
        frame(i,j) = frame(i,j) + int16(normrnd(set.sample.background_frame(i,j),sigma_frame(i,j)));
    end
end
end