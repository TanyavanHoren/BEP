function [PositionX, PositionY] = test_matlab_phasor(ROI)

%% Perform a 2D Fourier transformation on the complete ROI.
fft_values = fft2(ROI);
%Get the size of the matrix
WindowPixelSize = size(ROI,1);
%Calculate the angle of the X-phasor from the first Fourier coefficient in X
angX = angle(fft_values(1,2));
%Correct the angle
if (angX>0) angX=angX-2*pi; end;
%Normalize the angle by 2pi and the amount of pixels of the ROI
PositionX = (abs(angX)/(2*pi/WindowPixelSize) + 0.5);
%Calculate the angle of the Y-phasor from the first Fourier coefficient in Y
angY = angle(fft_values(2,1));
%Correct the angle
if (angY>0) angY=angY-2*pi; end;
%Normalize the angle by 2pi and the amount of pixels of the ROI
PositionY = (abs(angY)/(2*pi/WindowPixelSize) + 0.5);

end