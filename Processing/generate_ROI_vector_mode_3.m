function ana = generate_ROI_vector_mode_3(ana, set, obj)
counter = 1;

for i=1:obj.gen.number
    for j=1:obj.object(i).number_bind %loop over all binding spots, next; check if not at edges
        if (obj.object(i).site(j).position_x > (ana.ROI.size/2-1)*set.mic.pixelsize && obj.object(i).site(j).position_x < (set.mic.pixels_x -(ana.ROI.size/2-1))*set.mic.pixelsize && obj.object(i).site(j).position_y > (ana.ROI.size/2-1)*set.mic.pixelsize && obj.object(i).site(j).position_y < (set.mic.pixels_y -(ana.ROI.size/2-1))*set.mic.pixelsize )
            ana.ROI.ROI(counter).position_x = obj.object(i).site(j).position_x; %define what the position of ROI(counter is)
            ana.ROI.ROI(counter).position_y = obj.object(i).site(j).position_y;
            ana.ROI.ROI(counter).label = 1; %specific
            counter = counter + 1 ;
        end
    end
end

for i=1:set.non.N
    if (set.non.site(i).position_x > (ana.ROI.size/2-1)*set.mic.pixelsize && set.non.site(i).position_x < (set.mic.pixels_x -(ana.ROI.size/2-1))*set.mic.pixelsize && set.non.site(i).position_y > (ana.ROI.size/2-1)*set.mic.pixelsize && set.non.site(i).position_y < (set.mic.pixels_y -(ana.ROI.size/2-1))*set.mic.pixelsize )
        ana.ROI.ROI(counter).position_x = set.non.site(i).position_x; %define what the position of ROI(counter is)
        ana.ROI.ROI(counter).position_y = set.non.site(i).position_y;
        ana.ROI.ROI(counter).label = 0; %nonspecific
        counter = counter + 1 ;
    end
end

ana.ROI.number=counter-1;