function set = generate_non_spec_binding_spots(set)

for i=1:set.non.N
    set.non.site(i).position_x=rand()*set.mic.pixels_x*set.mic.pixelsize;
    set.non.site(i).position_y=rand()*set.mic.pixels_y*set.mic.pixelsize;
    set.non.site(i).isBound=0;
    set.non.site(i).intensity_factor=0;
    set.non.site(i).td= set.non.lowbound_td+rand()*(set.non.upbound_td-set.non.lowbound_td);
    set.non.site(i).tb= set.non.lowbound_tb+rand()*(set.non.upbound_tb-set.non.lowbound_tb);
    set.non.site(i).t_switch=exprnd(set.non.site(i).td);
end
