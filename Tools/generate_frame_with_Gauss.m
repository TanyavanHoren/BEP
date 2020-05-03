function frame = generate_frame_with_Gauss(frame, gauss_data, center)
xc_int = floor(center(1)); %find integer
yc_int = floor(center(2)); %find remainder
xc_rem = mod(center(1),1);
yc_rem = mod(center(2),1);

gauss_data.gauss_size = 10;
%adjust bounds subframe if exceeds bounds frame:
if xc_int + gauss_data.gauss_size < size(frame,1) %check overlap right
    xr = xc_int + gauss_data.gauss_size; %set value x at right side
else
    xr = size(frame,1);
end

if xc_int - gauss_data.gauss_size > 0 %left
    xl = xc_int - gauss_data.gauss_size;
else
    xl = 1;
end

if yc_int + gauss_data.gauss_size < size(frame,2) %top
    yr = yc_int + gauss_data.gauss_size;
else
    yr = size(frame,2);
end

if yc_int - gauss_data.gauss_size > 0 %bottom
    yl = yc_int - gauss_data.gauss_size;
else
    yl = 1;
end

gauss_data.xc = gauss_data.gauss_size+1+xc_rem;
gauss_data.yc = gauss_data.gauss_size+1+yc_rem;

gsize = [xr-xl+1 yr-yl+1]; 

[R,C] = ndgrid(1:gsize(1), 1:gsize(2)); %generate subgrid for Gauss
gauss_on_frame_small = int16(generate_Gauss(R,C, gauss_data)); %place Gauss on subgrid

frame(xl:xr,yl:yr)  =  frame(xl:xr, yl:yr) + gauss_on_frame_small; %place subgrid on frame
end
