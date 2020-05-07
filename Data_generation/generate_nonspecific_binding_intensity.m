function frame = generate_nonspecific_binding_intensity(obj, set, frame)

for i=1:obj.non.N
    if obj.non.site(i).intensity_factor>0
        yc=obj.non.site(i).position_x/set.mic.pixelsize;
        xc=obj.non.site(i).position_y/set.mic.pixelsize;
        center = [xc;yc];
        %gauss_data.I_max=obj.non.site(i).intensity_factor*poissrnd(40*set.other.av_background);
        gauss_data.I_max=round(obj.non.site(i).intensity_factor*obj.non.site(i).I_max);
        gauss_data.sigma= 3*set.mic.pixelsize; 
        frame = generate_frame_with_Gauss(frame, gauss_data, center);
    end
end
end