function ROI_data = generate_ROI_vector(ROI_frame, pixel_data, analysis_data)
counter = 1;
for i=((analysis_data.size_ROI-1)/2+1):(pixel_data.pixels_y-(analysis_data.size_ROI-1)/2) 
    for j=((analysis_data.size_ROI-1)/2+1):(pixel_data.pixels_x-(analysis_data.size_ROI-1)/2)
       if ROI_frame(i,j) == 1
           ROI_data.ROI(counter).position_x = j;
           ROI_data.ROI(counter).position_y = i; 
           counter = counter + 1 ;
       end
    end
end
ROI_data.number=sum(ROI_frame(:)==1);
    