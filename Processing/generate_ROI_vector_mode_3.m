function ana = generate_ROI_vector_mode_3(ana, set, obj)
counter = 1;

for i=1:obj.gen.number
    for j=1:obj.object(i).number_bind %loop over all binding spots, next; check if not at edges
        if (obj.object(i).site(j).position_x > (ana.ROI.size-1)/2*set.mic.pixelsize && obj.object(i).site(j).position_x < (set.mic.pixels_x -(ana.ROI.size-1)/2)*set.mic.pixelsize && obj.object(i).site(j).position_y > (ana.ROI.size-1)/2*set.mic.pixelsize && obj.object(i).site(j).position_y < (set.mic.pixels_y -(ana.ROI.size-1)/2)*set.mic.pixelsize )
            ana.ROI.ROI(counter).position_x = ceil(obj.object(i).site(j).position_x/set.mic.pixelsize); %define what the position of ROI(counter) is, in pixels
            ana.ROI.ROI(counter).position_y = ceil(obj.object(i).site(j).position_y/set.mic.pixelsize);
            ana.ROI.ROI(counter).label = 1; %specific
            counter = counter + 1 ;
        end
    end
end

for i=1:set.non.N
    if (set.non.site(i).position_x > (ana.ROI.size-1)/2*set.mic.pixelsize && set.non.site(i).position_x < (set.mic.pixels_x -(ana.ROI.size-1)/2)*set.mic.pixelsize && set.non.site(i).position_y > (ana.ROI.size-1)/2*set.mic.pixelsize && set.non.site(i).position_y < (set.mic.pixels_y -(ana.ROI.size-1)/2)*set.mic.pixelsize )
        ana.ROI.ROI(counter).position_x = ceil(set.non.site(i).position_x/set.mic.pixelsize); %define what the position of ROI(counter is) in pixels
        ana.ROI.ROI(counter).position_y = ceil(set.non.site(i).position_y/set.mic.pixelsize);
        ana.ROI.ROI(counter).label = 0; %nonspecific
        counter = counter + 1 ;
    end
end

ana.ROI.number=counter-1;