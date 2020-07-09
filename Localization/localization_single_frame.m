function [X,Y] = localization_single_frame(frame_to_process, set)

persistent initSig

initSig = set.ana.loc_settings.initSig;

[PositionX, PositionY] = phasor_fit(frame_to_process, set);
pixel_intensity = frame_to_process(ceil(PositionX),ceil(PositionY));
myROI_bg = mean(frame_to_process(frame_to_process < mean(frame_to_process)));
gausInit = double([myROI_bg, pixel_intensity, PositionX, initSig, PositionY]);
[result, ~, exitFlag] = lsqGauss(gausInit,frame_to_process,size(frame_to_process,2));
if exitFlag < 1
    X = [];
    Y = [];
    return
end
X = result(5);
Y = result(3);

end