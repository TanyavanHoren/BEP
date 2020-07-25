function frame = generate_specific_binding_intensity(ROIs, set, frame, i)

gauss_data.sigma= set.mic.wavelength/(2*set.mic.NA*sqrt(8*log(2))*set.mic.pixelsize);

for j=1:ROIs.ROI(i).object_number_bind
    if ROIs.ROI(i).site(j).intensity_factor>0 %if fraction of time bound
        xc=ROIs.ROI(i).site(j).position_x/set.mic.pixelsize;
        yc=ROIs.ROI(i).site(j).position_y/set.mic.pixelsize;
        center = [yc;xc];
        gauss_data.I_max=ROIs.ROI(i).site(j).intensity_factor; %implementation shot noise
        frame = generate_frame_with_Gauss(frame, gauss_data, center);
    end
end
end