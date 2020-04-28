function obj = generate_objects(set, obj)

for i=1:obj.gen.number
    if set.other.system_choice == 1
    obj.object(i).position_x = rand()*set.mic.pixels_x*set.mic.pixelsize;
    obj.object(i).position_y = rand()*set.mic.pixels_y*set.mic.pixelsize;
    obj.object(i).number_bind = 1;
    elseif set.other.system_choice == 2
    obj.object(i).size_x = (normrnd(obj.gen.av_size_x*1000, sqrt(obj.gen.av_size_x*1000))/1000);
    obj.object(i).size_y = (normrnd(obj.gen.av_size_y*1000, sqrt(obj.gen.av_size_y*1000))/1000);
    obj.object(i).number_bind = poissrnd(obj.gen.av_binding_spots);
    obj.object(i).position_x = rand()*set.mic.pixels_x*set.mic.pixelsize;
    obj.object(i).position_y = rand()*set.mic.pixels_y*set.mic.pixelsize;
    obj.object(i).orientation = rand()*pi;
    end
end 