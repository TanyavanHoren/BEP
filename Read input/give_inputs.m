function [set, SNR]  = give_inputs(set)

set.mic.dt = 300E-3; %s
set.mic.pixelsize = 0.117; %mu
set.mic.t_end = set.mic.dt*set.mic.frames; %s
set.mic.NA = 1.4; %numerical aperature
set.mic.wavelength = 0.637; %mu
set.mic.laser_power = 100; %in mW

set.sample.k_off = 1.6; %s^-1
set.sample.k_on = 2.3E6; %M^-1s^-1
set.sample.concentration = set.sample.k_off/(set.sample.k_on*20*set.obj.av_binding_spots); %in M
set.sample.tb = 1/set.sample.k_off; %s
set.sample.td = 1/(set.sample.k_on*set.sample.concentration); %s
set.sample.non_lowbound_tb = 0.2; %s lower bound tb range
set.sample.non_upbound_tb = 6; %s upper bound tb range
set.sample.non_on_object_chance = 0;

set.obj.av_size_x = 0.07; %mu nanorod
set.obj.av_size_y = 0.02; %mu nanorod
set.obj.av_radius = 0.05; %mu spherical particle
set.obj.std_factor_size = 0.1; %the standard deviation is factor*mean

set.ROI.size = 9; %pixelwidth ROI 

set.other.t_shuffle = 1000*(set.sample.tb+set.sample.td);
set.other.clims = [0 2000]; %fix colourscale visualization

%Background (per pixel): poissrnd(mu)
%mu=A+(B*concentration+C)*laserpower
set.para.bg.A = 400; %camera baseline
set.para.bg.B = 0.51E9; %M^-1mW^-1
set.para.bg.C = 0.79; %mW^-1
set.bg.mu = set.para.bg.A;%+(set.para.bg.B*set.sample.concentration+set.para.bg.C)*set.mic.laser_power;
%Peak intensity: lognrnd(mu, B)
%mu = A*laserpower
set.para.intensity.A=0.055; %mW^-1 
set.intensity.std=0.45; 
set.intensity.mu=set.para.intensity.A*set.mic.laser_power;

mean = exp(set.intensity.mu+set.intensity.std^2/2);
variance = exp(2*set.intensity.mu+set.intensity.std^2)*exp(set.intensity.std^2-1);
SNR = mean/sqrt(set.bg.mu+(variance)); %estimate SNR

set.ana.std_factor=5; %threshold at mu+factor*sigma
set.ana.loc_settings.thresh=set.bg.mu+sqrt(set.bg.mu)*set.ana.std_factor;
set.ana.loc_settings.initSig=set.mic.wavelength/(2*set.mic.NA*sqrt(8*log(2)))/set.mic.pixelsize;
end