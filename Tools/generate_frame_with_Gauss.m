function frame = generate_frame_with_Gauss(frame, gauss_data, center)
gauss_data.xc = size(frame,1)/2 + center(1);
gauss_data.yc = size(frame,1)/2 + center(2);

[R,C] = ndgrid(0.5:size(frame,1)-0.5, 0.5:size(frame,1)-0.5); %generate subgrid for Gauss
gauss_on_frame_small = imnoise(uint16(generate_Gauss(R,C, gauss_data)),'poisson'); %place Gauss on subgrid

frame  =  frame + gauss_on_frame_small; %place subgrid on frame
end