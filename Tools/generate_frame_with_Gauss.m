function gauss_on_frame = generate_frame_with_Gauss(frame, gauss_data, center)
gsize = size(frame); 
[R,C] = ndgrid(1:gsize(1), 1:gsize(2)); %Generate a matrix with the size of the frame
gauss_on_frame = generate_Gauss(R,C, gauss_data, center); %Place a gauss on the matrix
end
