function frame = generate_frame_with_Gauss_v2(frame, gauss_data, center)
xc_int = floor(center(1));
yc_int = floor(center(2));
xc_rem = mod(center(1),1);
yc_rem = mod(center(2),1);

gauss_data.gauss_size = 10;
if xc_int + gauss_data.gauss_size < size(frame,1)
    xr = xc_int + gauss_data.gauss_size;
else
    xr = size(frame,1);
end

if xc_int - gauss_data.gauss_size > 0
    xl = xc_int - gauss_data.gauss_size;
else
    xl = 1;
end

if yc_int + gauss_data.gauss_size < size(frame,2)
    yr = yc_int + gauss_data.gauss_size;
else
    yr = size(frame,2);
end

if yc_int - gauss_data.gauss_size > 0
    yl = yc_int - gauss_data.gauss_size;
else
    yl = 1;
end

gauss_data.xc = gauss_data.gauss_size+1+xc_rem;
gauss_data.yc = gauss_data.gauss_size+1+yc_rem;

gsize = [xr-xl+1 yr-yl+1]; 

[R,C] = ndgrid(1:gsize(1), 1:gsize(2)); %Generate a matrix with the size of the frame
gauss_on_frame_small = int16(generate_Gauss_v2(R,C, gauss_data)); %Place a gauss on the matrix

frame(xl:xr,yl:yr)  =  frame(xl:xr, yl:yr) + gauss_on_frame_small;
end
