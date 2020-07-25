function [set, SNR]  = give_inputs(set)

set.sample.k_off = 1.6; %s^-1
set.sample.k_on = 2.3E6; %M^-1s^-1
set.sample.concentration = set.sample.k_off/(set.sample.k_on*20*set.obj.av_binding_spots); %in M
set.sample.tb = 1/set.sample.k_off; %s
set.sample.td = 1/(set.sample.k_on*set.sample.concentration); %s
set.sample.non_lowbound_tb = 0.2; %s lower bound tb range
set.sample.non_upbound_tb = 2; %s upper bound tb range
set.sample.non_on_object_chance = 0;

set.mic.dt = 50E-3;% 
set.mic.frames = round(100*(set.sample.tb+set.sample.td)/(set.obj.av_binding_spots*set.mic.dt));
set.mic.pixelsize = 0.117; %mu
set.mic.t_end = set.mic.dt*set.mic.frames; %s
set.mic.NA = 1.4; %numerical aperature
set.mic.wavelength = 0.637; %mu
set.mic.laser_power = 100; %in mW

set.obj.av_size_x = 0.07; %mu nanorod
set.obj.av_size_y = 0.02; %mu nanorod
set.obj.av_radius = 0.05; %mu spherical particle
set.obj.std_factor_size = 0.1; %the standard deviation is factor*mean

set.ROI.size = 9; %pixelwidth ROI 

set.other.t_shuffle = 1000*(set.sample.tb+set.sample.td);
set.other.clims = [0 0.5E5]; %fix colourscale visualization

%Background (per pixel): 
%mu=A+(B*concentration+C)*laserpower
%std=-D+E*mu
set.bg.A = 400; %camera baseline
set.para.bg.B = 6.4E9; %M^-1mW^-1
set.para.bg.C = 9.9; %mW^-1
set.bg.mu = set.bg.A+(set.para.bg.B*set.sample.concentration+set.para.bg.C)*set.mic.laser_power;
set.para.bg.D = 98; 
set.para.bg.E = 0.26; 
set.bg.std = -set.para.bg.D+set.para.bg.E*set.bg.mu;
%Peak intensity: lognrnd(mu, std)
%mu = F*laserpower
set.para.intensity.F=0.105; %mW^-1 
set.intensity.std=0.6; 
set.intensity.mu=set.para.intensity.F*set.mic.laser_power;

mean = exp(set.intensity.mu+set.intensity.std^2/2);
spatial_sigma = set.mic.wavelength/(2*set.mic.NA*sqrt(8*log(2))*set.mic.pixelsize);
SNR = 2*pi*mean*spatial_sigma^2/(set.ROI.size*set.bg.std); %number of photons from one event/std bg across full ROI

%% loc precision
std_psf=set.mic.wavelength/(2*set.mic.NA*sqrt(8*log(2)));
mean_I=exp(set.intensity.mu+set.intensity.std^2/2);
N_photons=2*pi*(std_psf/set.mic.pixelsize)^2*mean_I;
term1=(std_psf^2+(set.mic.pixelsize^2/12))/N_photons;
term2=8*pi*std_psf^4*set.bg.std^2/(set.mic.pixelsize^2*N_photons^2);
loc_prec_1d=sqrt(term1+term2);
set.loc_prec=sqrt(2)*loc_prec_1d;

%%
set.ana.tolerance=10*set.loc_prec/set.mic.pixelsize; %when correcting for short drops below threshold, X,Y may differ by this tol to be considered from same source
set.ana.std_factor=4; %threshold at mu+factor*sigma
set.ana.loc_settings.thresh=set.bg.mu+sqrt(set.bg.mu)*set.ana.std_factor;
set.ana.loc_settings.initSig=set.mic.wavelength/(2*set.mic.NA*sqrt(8*log(2)))/set.mic.pixelsize;
end