function square = plot_square(ROIs, set, i)

x1=-1/2*ROIs.ROI(i).object_size_x*cos(ROIs.ROI(i).object_orientation)+1/2*ROIs.ROI(i).object_size_y*sin(ROIs.ROI(i).object_orientation);
x3=1/2*ROIs.ROI(i).object_size_x*cos(ROIs.ROI(i).object_orientation)+1/2*ROIs.ROI(i).object_size_y*sin(ROIs.ROI(i).object_orientation);
y1=-1/2*ROIs.ROI(i).object_size_x*sin(ROIs.ROI(i).object_orientation)-1/2*ROIs.ROI(i).object_size_y*cos(ROIs.ROI(i).object_orientation);
y3=1/2*ROIs.ROI(i).object_size_x*sin(ROIs.ROI(i).object_orientation)-1/2*ROIs.ROI(i).object_size_y*cos(ROIs.ROI(i).object_orientation);
x = [x1, -x3, -x1, x3, x1]/set.mic.pixelsize;
y = [y1, -y3, -y1, y3, y1]/set.mic.pixelsize;
square = plot(x, y, 'b-', 'LineWidth', 0.5, 'Color', 'Black');
end