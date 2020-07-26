function ROIs = generate_objects(ROIs, set, i)
%{
Define the particle dimensions, orientations, and numbers of binding sites.
Determine the starting time of the first non-specific event that will 
take place.

INPUTS
-------
ROIs: information on all previous ROIs (pass through to add information)
set: system settings (such as average number of sites, average dimensions)
i: index of the ROI that is considered 

OUTPUTS 
------
ROIs: properties of the particle corresponding to ROI i, as well as of the
non-specific events in the ROI

Created by Tanya van Horen - July 2020
%}

%%
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
while ROIs.ROI(i).object_number_bind == 0 %exclude particles without binding sites
    ROIs.ROI(i).object_number_bind=poissrnd(set.obj.av_binding_spots);
end

ROIs.ROI(i).non_specific.period=set.para.freq_ratio*(set.sample.td+set.sample.tb)/ROIs.ROI(i).object_number_bind;
ROIs.ROI(i).non_specific.t_start=exprnd(ROIs.ROI(i).non_specific.period);
ROIs.ROI(i).non_specific.number=0;
end