function frame = generate_background(frame, set)

if set.other.background_mode == 1
    frame = frame + poissrnd(set.other.av_background,[set.mic.pixels_y,set.mic.pixels_x]);
end