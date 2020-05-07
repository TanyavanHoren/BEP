function obj = generate_non_spec_binding_spots(obj, set)

for i=1:obj.non.N
    obj.non.site(i).position_x=rand()*set.mic.pixels_x*set.mic.pixelsize; %assign position on frame
    obj.non.site(i).position_y=rand()*set.mic.pixels_y*set.mic.pixelsize;
    obj.non.site(i).isBound=0;
    obj.non.site(i).intensity_factor=0;
    obj.non.site(i).I_mean=10;%50*log(set.laser.power*(set.laser.laser_frame(ceil(obj.non.site(i).position_y/set.mic.pixelsize),ceil(obj.non.site(i).position_x/set.mic.pixelsize))/max(set.laser.laser_frame, [], 'all')));%peak intensity Gauss binding event
    obj.non.site(i).sigma=5*set.mic.pixelsize; %random number %spatial sigma binding event
    obj.non.site(i).td=obj.non.lowbound_td+rand()*(obj.non.upbound_td-obj.non.lowbound_td); %give tau_b/d within range
    obj.non.site(i).tb=obj.non.lowbound_tb+rand()*(obj.non.upbound_tb-obj.non.lowbound_tb);
    obj.non.site(i).t_switch=exprnd(obj.non.site(i).td);
end
