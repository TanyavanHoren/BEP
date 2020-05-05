function [set, n_frame, obj, ana]  = give_inputs(set, obj)

set.mic.dt = 50E-3;
set.mic.pixels_x = 1024; %# pixels
set.mic.pixels_y = 552; %# pixels
set.mic.pixelsize = 0.22; %mu
set.mic.t_end = set.mic.dt*set.mic.frames;
set.sample.concentration = 2E4; %in M
set.sample.k_off = 1.6; %M^-1s^-1
set.sample.k_on = 2.3E-6; %s^-1
set.sample.tb = 1/set.sample.k_off; %s
set.sample.td = 1/(set.sample.k_on*set.sample.concentration); %s
set.non.lowbound_tb = 0.2; %s lower bound tb range
set.non.upbound_tb = 6; %s upper bound tb range
set.non.lowbound_td = 2; %s
set.non.upbound_td = 1700; %s
set.non.N = set.non.events_per_time*set.mic.frames*set.mic.dt; %# over full time

obj.gen.av_size_x = 0.07; %mu
obj.gen.av_size_y = 0.02; %mu
obj.gen.av_I0 = 200; %rest intensity object

ana.ROI.size = 9; %pixelwidth ROI 

set.other.clims = [0 2000]; %fix colourscale visualization
set.other.clims_laser = [0 200];

n_frame = 1; %set counter
end