function SupResParams = merge_process_frame(frame_to_process, set, event_number)

persistent index initSig
index = 1;

initSig = set.ana.loc_settings.initSig;

[PositionX, PositionY] = phasor_fit(frame_to_process, set);
pixel_intensity = frame_to_process(ceil(PositionX),ceil(PositionY));
myROI_bg = mean(frame_to_process(frame_to_process < mean(frame_to_process)));
gausInit = double([myROI_bg, pixel_intensity, PositionX, initSig, PositionY]);
[result, ~, residual, exitFlag, its] = lsqGauss(gausInit,frame_to_process,size(frame_to_process,2));
if exitFlag < 1
    SupResParams = [];
    return
end
SupResParams(index).event_idx = event_number;
SupResParams(index).x_coord = result(5);
SupResParams(index).y_coord = result(3);
SupResParams(index).I = result(2);
SupResParams(index).sig_x = result(4);  % X-width (sigma, rows, fitted) of this Gaussian
SupResParams(index).sig_y = result(4);  % Y-width (sigma, cols, fitted) of this Gaussian
SupResParams(index).resDion = sum(residual.^2)/sum(frame_to_process.^2);
SupResParams(index).its = its;
index = index +1;

end