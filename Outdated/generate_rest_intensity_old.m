function frame = generate_rest_intensity(nanorod_data, pixel_data, frame)

for i=1:nanorod_data.number
    yc=nanorod_data.nanorod(i).position_x/pixel_data.pixelsize;
    xc=nanorod_data.nanorod(i).position_y/pixel_data.pixelsize;
    center = [xc;yc];
    gauss_data.I_max=poissrnd(nanorod_data.I0*nanorod_data.nanorod(i).size_x*nanorod_data.nanorod(i).size_y);
    gauss_data.sigma=  10*pixel_data.pixelsize;
    gauss_on_frame = generate_frame_with_Gauss(frame, gauss_data, center);
    frame = frame + gauss_on_frame;
end
    
end