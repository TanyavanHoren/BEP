function ROIs = generate_objects(ROIs, set, i)

if set.other.system_choice==1
    ROIs.ROI(i).object_radius=normrnd(set.obj.av_radius, set.obj.std_factor_size*set.obj.av_radius); %mu
elseif set.other.system_choice==2
    ROIs.ROI(i).object_size_x=normrnd(set.obj.av_size_x, set.obj.std_factor_size*set.obj.av_size_x); %mu
    ROIs.ROI(i).object_size_y=normrnd(set.obj.av_size_y, set.obj.std_factor_size*set.obj.av_size_y); %mu
    ROIs.ROI(i).object_orientation=rand()*pi; %rad
end
if set.other.fixed_bind_spots==0
    ROIs.ROI(i).object_number_bind=poissrnd(set.obj.av_binding_spots);
elseif set.other.fixed_bind_spots==1
    ROIs.ROI(i).object_number_bind=set.obj.av_binding_spots;
end
while ROIs.ROI(i).object_number_bind == 0 %in reality, we would also exclude objects without events
    ROIs.ROI(i).object_number_bind=poissrnd(set.obj.av_binding_spots);
end
ROIs.ROI(i).non_specific.period=set.para.freq_ratio*(set.sample.td+set.sample.tb)/ROIs.ROI(i).object_number_bind;
ROIs.ROI(i).non_specific.t_start=exprnd(ROIs.ROI(i).non_specific.period);
ROIs.ROI(i).non_specific.number=0;
end