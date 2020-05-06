function set = generate_non_spec_binding_spots(set)

for i=1:set.non.N
    set.non.site(i).position_x=rand()*set.mic.pixels_x*set.mic.pixelsize; %assign position on frame
    set.non.site(i).position_y=rand()*set.mic.pixels_y*set.mic.pixelsize;
    set.non.site(i).isBound=0;
    set.non.site(i).intensity_factor=0;
    set.non.site(i).I_mean=8.5;%50*log(set.laser.power*(set.laser.laser_frame(ceil(set.non.site(i).position_y/set.mic.pixelsize),ceil(set.non.site(i).position_x/set.mic.pixelsize))/max(set.laser.laser_frame, [], 'all')));%peak intensity Gauss binding event
    set.non.site(i).sigma=5*set.mic.pixelsize; %random number %spatial sigma binding event
    set.non.site(i).td=set.non.lowbound_td+rand()*(set.non.upbound_td-set.non.lowbound_td); %give tau_b/d within range
    set.non.site(i).tb=set.non.lowbound_tb+rand()*(set.non.upbound_tb-set.non.lowbound_tb);
    set.non.site(i).t_switch=exprnd(set.non.site(i).td);
end
