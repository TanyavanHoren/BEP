function [set, n_frame, obj, ana]  = give_inputs(set, obj)

set.mic.dt = 300E-3;
set.mic.pixels_x = 1024; %# pixels
set.mic.pixels_y = 552; %# pixels
set.mic.pixelsize = 0.117; %mu
set.mic.t_end = set.mic.dt*set.mic.frames;
set.sample.concentration = 8E-9; %in M
set.sample.k_off = 0.33; %s^-1
set.sample.k_on = 2.3E6; %M^-1s^-1
set.sample.tb = 1/set.sample.k_off; %s
set.sample.td = 1/(set.sample.k_on*set.sample.concentration); %s
obj.non.lowbound_tb = 0.2; %s lower bound tb range
obj.non.upbound_tb = 6; %s upper bound tb range
obj.non.lowbound_td = 2; %s
obj.non.upbound_td = 1700; %s
obj.non.N = obj.non.events_per_time*set.mic.frames*set.mic.dt; %# over full time

obj.gen.av_size_x = 0.07; %mu nanorod
obj.gen.av_size_y = 0.02; %mu nanorod
obj.gen.av_radius = 0.05; %mu cell/spherical particle
obj.gen.av_I0 = 200; %rest intensity object

ana.ROI.size = 9; %pixelwidth ROI 

set.other.t_shuffle = 1000*(set.sample.tb+set.sample.td);
set.other.clims = [0 2000]; %fix colourscale visualization
set.other.clims_laser = [0 200];

%Background (per pixel): normrnd(mu, sigma)
%mu=A+(B*concentration+C)*laserpower
%sigma=D+E*mu
set.para.A = 400; %camera baseline
set.para.B = 0.51E9; %M^-1mW^-1
set.para.C = 0.79; %mW^-1
set.para.D = -11.8;
set.para.E = 0.031; 

n_frame = 1; %set counter
end