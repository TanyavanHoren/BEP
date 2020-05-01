function Gauss = generate_Gauss_v2(x, y, gauss_data) %output is a Gauss
u = ((x-gauss_data.xc).^2 + (y-gauss_data.yc).^2)./(2*gauss_data.sigma^2); %Gaussian function
Gauss = gauss_data.I_max*(exp(-u)); %Gaussian function (2D, cont)
end


