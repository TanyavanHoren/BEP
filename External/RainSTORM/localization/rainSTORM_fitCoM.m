function SupResParams = rainSTORM_fitCoM(frameIdx, myFrame,myPixels,bkgdSig,settings)
% Fitting algorithm which determines the "centre of mass" of the ROI.
% Calculate centroid for the ROI and use these coordinates as the localisation.

rad = settings.rad.val;
SupResParams = [];

for lpPx = 1:size(myPixels,1); % For local maxima in descending order
    myRow = myPixels(lpPx,1);
    myCol = myPixels(lpPx,2);
    myROI = myFrame(myRow-rad:myRow+rad,myCol-rad:myCol+rad);
    myROI_min = min(myROI(:));
    myROI_bg = mean( [myROI(:,1); myROI(:,end); myROI(1,2:end-1)'; myROI(end,2:end-1)' ] );
    myROI = myROI - myROI_bg;  % Square region to fit. Subtract background.
    % Note that myROI = ones(7) gives sigX = NaN: real data peaks obviate this
    weight = (-rad:rad); % Basis. Let the ROI centre be (0,0).
    
    % Calculate total intensity of the ROI.
    totalIntensity = sum(myROI(:));
    
    % Calculate x-value for centroid.
    xSums = sum(myROI,2);              % Determine the sum of each row.
    xValues = xSums' * weight';        % Weighted sum of rows
    xCoord = xValues / totalIntensity; % Calculate x-coordinate.
    sigX = sqrt( (xSums' * (weight.^2)')/totalIntensity - xCoord^2); % CHECK!
    
    % Calculate y-value for centroid.
    ySums = sum(myROI,1);      % Determine the sum of each column.
    yValues = ySums * weight'; % Weighted sum of columns
    yCoord = yValues / totalIntensity; % Centre of Mass y-coordinate.
    sigY = sqrt( (ySums * (weight.^2)')/totalIntensity - yCoord^2); % CHECK!
    
    SupResParams(lpPx).frame_idx = frameIdx;
    SupResParams(lpPx).x_coord = (double(myRow)+xCoord- 0.5); % Note -(0.5,0.5) for pixel registration.
    SupResParams(lpPx).y_coord = (double(myCol)+yCoord- 0.5); % Note -(0.5,0.5) for pixel registration.
    SupResParams(lpPx).z_coord = 0;
    SupResParams(lpPx).I = myPixels(lpPx,3); % Averaged magnitude of this signal
    SupResParams(lpPx).sig_x = sigX;  % X-width (sigma, rows, fitted) of this Gaussian
    SupResParams(lpPx).sig_y = sigY;  % Y-width (sigma, cols, fitted) of this Gaussian
    SupResParams(lpPx).avg_brigthness = bkgdSig; % Background for each ROI
    SupResParams(lpPx).res = 0; % Bodge tolerance as perfect: no fit!
    SupResParams(lpPx).res_Row = 0;
    SupResParams(lpPx).res_Col = 0;
    SupResParams(lpPx).roi_min = myROI_min;
    SupResParams(lpPx).Sum_signal = totalIntensity; % Sum of signal (counts) for this fit
    
end
end