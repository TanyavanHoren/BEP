function frame = generate_background_frame(set)

frame = 400+(0.51*set.sample.concentration*10^9+0.79)*set.laser.power*set.laser.laser_frame/max(set.laser.laser_frame, [], 'all');

end