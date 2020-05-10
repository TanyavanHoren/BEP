function frame = generate_background(set)

frame = uint16(poissrnd(set.bg.mu,[set.ROI.size,set.ROI.size]));
end