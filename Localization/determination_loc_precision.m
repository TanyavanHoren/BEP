function set = determination_loc_precision(set)

std_psf=set.mic.wavelength/(2*set.mic.NA*sqrt(8*log(2)));
mean_I=exp(set.intensity.mu+set.intensity.std^2/2);
N_photons=2*pi*(std_psf/set.mic.pixelsize)^2*mean_I;
term1=(std_psf^2+(set.mic.pixelsize^2/12))/N_photons;
term2=8*pi*std_psf^4*set.bg.std^2/(set.mic.pixelsize^2*N_photons^2);
loc_prec_1d=sqrt(term1+term2);
set.loc_prec=sqrt(2)*loc_prec_1d;
end