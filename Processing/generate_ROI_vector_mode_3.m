function ana = generate_ROI_vector_mode_3(ana, set, obj)

counter = 1;

for i=1:obj.gen.number
    if (obj.object(i).position_x > (ana.ROI.size-1)/2*set.mic.pixelsize && obj.object(i).position_x < (set.mic.pixels_x -(ana.ROI.size-1)/2)*set.mic.pixelsize && obj.object(i).position_y > (ana.ROI.size-1)/2*set.mic.pixelsize && obj.object(i).position_y < (set.mic.pixels_y -(ana.ROI.size-1)/2)*set.mic.pixelsize )
        ana.ROI.ROI(counter).position_x = ceil(obj.object(i).position_x/set.mic.pixelsize);
        ana.ROI.ROI(counter).position_y = ceil(obj.object(i).position_y/set.mic.pixelsize);
        ana.ROI.ROI(counter).label = 1; %specific
        counter = counter + 1 ;
    end
end

for i=1:obj.non.N
    if (obj.non.site(i).position_x > (ana.ROI.size-1)/2*set.mic.pixelsize && obj.non.site(i).position_x < (set.mic.pixels_x -(ana.ROI.size-1)/2)*set.mic.pixelsize && obj.non.site(i).position_y > (ana.ROI.size-1)/2*set.mic.pixelsize && obj.non.site(i).position_y < (set.mic.pixels_y -(ana.ROI.size-1)/2)*set.mic.pixelsize )
        ana.ROI.ROI(counter).position_x = ceil(obj.non.site(i).position_x/set.mic.pixelsize); 
        ana.ROI.ROI(counter).position_y = ceil(obj.non.site(i).position_y/set.mic.pixelsize);
        ana.ROI.ROI(counter).label = 0; %nonspecific
        counter = counter + 1 ;
    end
end

ana.ROI.number=counter-1; %total number ROIs
end