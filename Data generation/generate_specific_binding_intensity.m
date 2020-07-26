function frame = generate_specific_binding_intensity(ROIs, set, frame, i)
%{
Add intensities (in the form of pixelated Gaussians)
of specific events to the frames. 

INPUTS
-------
ROIs: settings for the considered ROI specifically
set: system settings
frame: single frame of the microscope movie. Consists only of background 
noise up to this point. 
i: index of considered ROI

OUTPUTS 
------
frame: single frame of the microscope movie. The Gaussian event peaks have
been added to the frame. 

Created by Tanya van Horen - July 2020
%}

%%
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