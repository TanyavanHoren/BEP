function frame = generate_rest_intensity_new(obj, set, frame)

for i=1:obj.gen.number
    if set.other.system_choice == 1
        break
    end
    yc=obj.object(i).position_x/set.mic.pixelsize;
    xc=obj.object(i).position_y/set.mic.pixelsize;
    center = [xc;yc];
    %gauss_data.I_max=poissrnd(obj.gen.av_I0*obj.object(i).size_x*obj.object(i).size_y);
    gauss_data.I_max=poissrnd(obj.gen.av_I0);
    gauss_data.sigma=  10*set.mic.pixelsize;
    frame = generate_frame_with_Gauss_v2(frame, gauss_data, center);
end

end