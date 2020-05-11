function ROIs = generate_objects(ROIs, set, i)

if set.other.system_choice==1
    ROIs.ROI(i).object_radius=(normrnd(set.obj.av_radius*1000, sqrt(set.obj.av_radius*1000))/1000); %mu
elseif set.other.system_choice==2
    ROIs.ROI(i).object_size_x=(normrnd(set.obj.av_size_x*1000, sqrt(set.obj.av_size_x*1000))/1000); %mu
    ROIs.ROI(i).object_size_y=(normrnd(set.obj.av_size_y*1000, sqrt(set.obj.av_size_y*1000))/1000); %mu
    ROIs.ROI(i).object_orientation=rand()*pi; %rad
end
ROIs.ROI(i).object_number_bind=poissrnd(set.obj.av_binding_spots);
ROIs.ROI(i).non_specific.period=set.para.freq_ratio*(set.sample.td+set.sample.tb)/ROIs.ROI(i).object_number_bind;
ROIs.ROI(i).non_specific.t_start=exprnd(ROIs.ROI(i).non_specific.period);
ROIs.ROI(i).non_specific.number=0;
end