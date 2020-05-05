function frame = generate_background(frame, set)

frame = frame + int16(poissrnd(set.other.av_background,[set.mic.pixels_y,set.mic.pixels_x]));
end