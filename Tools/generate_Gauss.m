function Gauss = generate_Gauss(x, y, gauss_data) 
u = ((x-gauss_data.xc).^2 + (y-gauss_data.yc).^2)./(2*gauss_data.sigma^2); 
Gauss = gauss_data.I_max*(exp(-u)); 
end


