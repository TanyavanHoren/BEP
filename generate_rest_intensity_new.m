function frame = generate_rest_intensity_new(object_data, pixel_data, frame, system_choice)

for i=1:object_data.number
    if system_choice == 1
        continue
    end 
        yc=object_data.object(i).position_x/pixel_data.pixelsize;
        xc=object_data.object(i).position_y/pixel_data.pixelsize;
        center = [xc;yc];
        gauss_data.I_max=poissrnd(object_data.I0*object_data.object(i).size_x*object_data.object(i).size_y);
        gauss_data.sigma=  10*pixel_data.pixelsize;
        gauss_on_frame = generate_frame_with_Gauss(frame, gauss_data, center);
        frame = frame + gauss_on_frame;
end
    
end