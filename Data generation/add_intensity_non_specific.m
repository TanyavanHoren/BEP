function frame = add_intensity_non_specific(ROIs, set, frame, i)

gauss_data.sigma= set.mic.wavelength/(2*set.mic.NA*sqrt(8*log(2))*set.mic.pixelsize);
for j=1:ROIs.ROI(i).non_specific.number
    if ROIs.ROI(i).non_specific.site(j).intensity_factor>0 %if fraction of time bound
        xc=ROIs.ROI(i).non_specific.site(j).data.position_x/set.mic.pixelsize;
        yc=ROIs.ROI(i).non_specific.site(j).data.position_y/set.mic.pixelsize;
        center = [xc;yc];
        gauss_data.I_max=ROIs.ROI(i).non_specific.site(j).intensity_factor; %implementation shot noise
        frame = generate_frame_with_Gauss(frame, gauss_data, center);
    end
end
end