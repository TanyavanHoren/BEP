function Gauss = generate_Gauss_laser(x, y, gauss_data, center) 
xc = center(1); 
yc = center(2);
u = ((x-xc).^2 + (y-yc).^2)./(2*gauss_data.sigma^2); 
Gauss = gauss_data.I_max*(exp(-u)); 
end


