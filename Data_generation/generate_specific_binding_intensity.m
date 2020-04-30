function frame = generate_specific_binding_intensity(obj, set, frame)

for i=1:obj.gen.number
    for j=1:obj.object(i).number_bind
        if obj.object(i).site(j).intensity_factor>0
            yc=obj.object(i).site(j).position_x/set.mic.pixelsize;
            xc=obj.object(i).site(j).position_y/set.mic.pixelsize;
            center = [xc;yc];
            gauss_data.I_max=obj.object(i).site(j).intensity_factor*poissrnd(6*set.other.av_background); %not representative
            gauss_data.sigma= 5*set.mic.pixelsize; %not representative
            gauss_on_frame = generate_frame_with_Gauss(frame, gauss_data, center);
            frame = frame + gauss_on_frame;  
        end
    end
end