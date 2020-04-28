function frame = generate_specific_binding_intensity(object_data, pixel_data, frame, experiment_data,t,analysis_data)

for i=1:object_data.number
    for j=1:object_data.object(i).number_bind
        if object_data.object_bindingspots(i).binding_spot(j).intensity_factor>0
            yc=object_data.object_bindingspots(i).binding_spot(j).position_x/pixel_data.pixelsize;
            xc=object_data.object_bindingspots(i).binding_spot(j).position_y/pixel_data.pixelsize;
            center = [xc;yc];
            gauss_data.I_max=object_data.object_bindingspots(i).binding_spot(j).intensity_factor*poissrnd(2*experiment_data.average_background); %not representative
            gauss_data.sigma= 5*pixel_data.pixelsize; %not representative
            gauss_on_frame = generate_frame_with_Gauss(frame, gauss_data, center);
            frame = frame + gauss_on_frame;  
        end
    end
end