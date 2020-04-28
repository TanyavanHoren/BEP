function ana = generate_ROI_vector(ana, set)
counter = 1;
for i=((ana.ROI.size-1)/2+1):(set.mic.pixels_y-(ana.ROI.size-1)/2) 
    for j=((ana.ROI.size-1)/2+1):(set.mic.pixels_x-(ana.ROI.size-1)/2)
       if ana.ROI.frame(i,j) == 1
           ana.ROI.ROI(counter).position_x = j;
           ana.ROI.ROI(counter).position_y = i; 
           counter = counter + 1 ;
       end
    end
end
ana.ROI.number=sum(ana.ROI.frame(:)==1);
    