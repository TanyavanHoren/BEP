function Gauss = generate_Gauss(x, y, gauss_data, center) %output is a Gauss
xc = center(1); %column vector center gives x and y position center
yc = center(2);
u = ((x-xc).^2 + (y-yc).^2)./(2*gauss_data.sigma^2); %Gaussian function
Gauss = gauss_data.I_max*(exp(-u)); %Gaussian function (2D, cont)
end


