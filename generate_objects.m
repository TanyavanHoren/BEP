function object_data = generate_objects(pixel_data, object_data, analysis_data, system_choice)

for i=1:object_data.number
    if system_choice == 1
    object_data.object(i).position_x = rand()*pixel_data.pixels_x*pixel_data.pixelsize;
    object_data.object(i).position_y = rand()*pixel_data.pixels_y*pixel_data.pixelsize;
    object_data.object(i).number_bind = 1;
    elseif system_choice == 2
    object_data.object(i).size_x = (normrnd(object_data.size_x*1000, sqrt(object_data.size_x*1000))/1000);
    object_data.object(i).size_y = (normrnd(object_data.size_y*1000, sqrt(object_data.size_y*1000))/1000);
  
    object_data.object(i).number_bind = poissrnd(object_data.average_binding_spots);
    object_data.object(i).position_x = rand()*pixel_data.pixels_x*pixel_data.pixelsize;
    object_data.object(i).position_y = rand()*pixel_data.pixels_y*pixel_data.pixelsize;
    object_data.object(i).orientation = rand()*pi;
    end
        if object_data.object(i).position_x < (analysis_data.size_ROI-1)/2*pixel_data.pixelsize || object_data.object(i).position_x > (pixel_data.pixels_x -(analysis_data.size_ROI-1)/2)*pixel_data.pixelsize || object_data.object(i).position_y < (analysis_data.size_ROI-1)/2*pixel_data.pixelsize || object_data.object(i).position_y > (pixel_data.pixels_y -(analysis_data.size_ROI-1)/2)*pixel_data.pixelsize 
        object_data.object(i).analysis = 0;
        else
        object_data.object(i).analysis = 1;
        end
end 