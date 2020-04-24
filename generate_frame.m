function frame = generate_frame(pixel_data)
frame = zeros(pixel_data.pixels_x,pixel_data.pixels_y)';
end

%Generates a matrix of zeroes with the dimensions of
%the number of pixels in x and y direction. Transpose
%such that i=1,..,N gives N the number of pixels in x and
%j=1,...,M, gives M the number of pixels in y. 