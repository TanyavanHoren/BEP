function nanorod_data = generate_nanorods(pixel_data, nanorod_data)

for i=1:nanorod_data.number
  nanorod_data.nanorod(i).size_x = normrnd(nanorod_data.size_x*1000, sqrt(nanorod_data.size_x*1000)/1000);
  nanorod_data.nanorod(i).size_y = normrnd(nanorod_data.size_y*1000, sqrt(nanorod_data.size_y*1000)/1000);
  
  nanorod_data.nanorod(i).number_bind = poissrnd(nanorod_data.average_binding_spots);
  nanorod_data.nanorod(i).position_x = rand()*pixel_data.pixels_x*pixel_data.pixelsize;
  nanorod_data.nanorod(i).position_y = rand()*pixel_data.pixels_y*pixel_data.pixelsize;
  nanorod_data.nanorod(i).orientation = rand()*pi;
end 