function frame = generate_background_frame(set)

frame = set.para.A+(set.para.B*set.sample.concentration+set.para.C)*set.laser.power*set.laser.laser_frame/max(set.laser.laser_frame, [], 'all');
%create frame with average background value per pixel (based on eq. Maartje)
end