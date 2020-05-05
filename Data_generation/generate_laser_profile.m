function laser_frame = generate_laser_profile(set)
laser_frame = double(generate_frame(set));
if set.laser.focus(1)<-(set.mic.pixels_x-1)*set.mic.pixelsize/2 || set.laser.focus(1)>(set.mic.pixels_x-1)*set.mic.pixelsize/2 || set.laser.focus(2)<-(set.mic.pixels_y-1)*set.mic.pixelsize/2 || set.laser.focus(2)>(set.mic.pixels_y-1)*set.mic.pixelsize/2
    disp('Change focal point laser')
    return
end
xc= set.mic.pixels_x/2+set.laser.focus(1)/set.mic.pixelsize;
yc= set.mic.pixels_y/2-set.laser.focus(2)/set.mic.pixelsize;
center = [yc;xc];
gauss_data.I_max= set.laser.power; %mW/pixel
gauss_data.sigma= set.laser.width/(2*sqrt(2*log(2))*set.mic.pixelsize); %pixels
gauss_on_frame = generate_frame_with_Gauss_laser(laser_frame, gauss_data, center);
laser_frame = laser_frame + gauss_on_frame;
end
