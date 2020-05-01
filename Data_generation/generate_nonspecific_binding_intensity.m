function frame = generate_nonspecific_binding_intensity(set, frame)

for i=1:set.non.N
    if set.non.site(i).intensity_factor>0
        yc=set.non.site(i).position_x/set.mic.pixelsize;
        xc=set.non.site(i).position_y/set.mic.pixelsize;
        center = [xc;yc];
        gauss_data.I_max=set.non.site(i).intensity_factor*poissrnd(40*set.other.av_background); %not representative
        gauss_data.sigma= 5*set.mic.pixelsize; %not representative
        frame = generate_frame_with_Gauss_v2(frame, gauss_data, center);
    end
end