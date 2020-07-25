function [test, resnorm, residual, exitflag, its] = lsqGauss(init_guess,pcle_gauss, ROI_size_gauss)

rad = (ROI_size_gauss-1)/2;
options = optimoptions('lsqcurvefit','Display','off','MaxIter',600);
% xx = linspace(-(ROI_size_gauss-1)/2,(ROI_size_gauss-1)/2,ROI_size_gauss);
% yy = xx;     
    xx = (0.5:2*rad+0.5)';      % x-positions (rows) (pixel widths) as column vector
    yy = (0.5:2*rad+0.5)';
[x,y] = meshgrid(xx,yy);
xdata(:,:,1) = x;
xdata(:,:,2) = y;


[test, resnorm, residual, exitflag ,output,lambda, jacobian] = lsqcurvefit(@D2GaussFunction,init_guess,xdata,double(pcle_gauss),[],[],options);
its = output.iterations;
end