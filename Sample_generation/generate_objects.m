function ROIs = generate_objects(ROIs, set, i)

if set.other.system_choice==1
    ROIs.ROI(i).object_radius=(normrnd(set.obj.av_radius*1000, sqrt(set.obj.av_radius*1000))/1000); %mu
    ROIs.ROI(i).object_number_bind=poissrnd(set.obj.av_binding_spots);
elseif set.other.system_choice==2
    ROIs.ROI(i).object_size_x=(normrnd(set.obj.av_size_x*1000, sqrt(set.obj.av_size_x*1000))/1000); %mu
    ROIs.ROI(i).object_size_y=(normrnd(set.obj.av_size_y*1000, sqrt(set.obj.av_size_y*1000))/1000); %mu
    ROIs.ROI(i).object_orientation=rand()*pi; %rad
    ROIs.ROI(i).object_number_bind=poissrnd(set.obj.av_binding_spots);
end
end