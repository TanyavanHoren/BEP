% rainSTORM_accuracy
% Copyright 2012. Refer to 00_license.txt for details.
% by Mark Deimund
%
% 12 Sept 2011: Edited by EJR
%
% FUNCTION
%   Evaluates an estimate of Localisation Precision for each localisation
%   Using the Thompson formula, based on Signal:Noise and PSF width. 
%
% NOTES
%   This routine determines the fitting accuracy of a point (in nm).
%   See paper by Thompson et al (Precise Nanometer Localization Analysis 
%     for Individual Fluorescent Probes in Biophysical Journal 2002)
%   This script reads in a user-defined "camera counts per photon" 
%     calibration. 
%   If the Counts : Photon Number calibration is wrong, then estimated
%     precisions may be wrong. In that case, it might be useful to set 
%     the "Threshold Thompson Precision" to 'inf' in the Reviewer GUI.
%     This would prevent Thresholding based on erroneous numbers.
%   Even if slightly skewed, I still think thresholding by an approximate
%     Thompson Precision is useful in many cases, however.
%   Photon number estimates now saved to workspace as reviewedPhotonNums.
%     Note that this number DEPENDS ON BACKGROUND SUBTRACTION, and is 
%     saved as guidance, not gospel! -- Version 2.34
%     They may be "photons" from non-single molecules, or bad subtraction.
%     Also, photons arriving in Camera Deadtime are not counted (nor
%     guessed at).
%
% FURTHER READING AND WORK
%   Consider alternative precision formulae. 
%     Mortensen (2010) doi:10.1038/nmeth.1447
%   Consider algorithms with alternative precision analyses (Bayesian)
%     Shaevitz (2009) doi:10.1155/2009/896208
%     "3B microscopy" - not that I claim to understand this
%
function [ch_data,N] = rainSTORM_precision(ch_data)
countsPerPhoton = ch_data.rawdata_mgr.countsPerPhoton; % Calibrate # photons
% Hard-coded alternative (uncomment next line):
% countsPerPhoton = ( 2.4 * 90 * 0.9 )/ 21.5 ;
% 21.5 = number of electrons collected per count at given pre-amp value (2.4)
% 2.4 = pre-amp multiplication, 
% 90 = actual EM gain (set to 200), 
% 0.9 = quantum efficiency of CCD at 650 nm - all for acquisition at 10 MHz
% See Andor Help files on Counts for more information
SupResParams = ch_data.localization.results.SupResParams;
deltaXSquared = zeros(size(SupResParams,2),2);

pixelSize = ch_data.rawdata_mgr.myImInfo.pixelWidth; % nm per pixel
sigROW = pixelSize * [SupResParams.sig_x];  % Mark's SigX
sigCOL = pixelSize * [SupResParams.sig_y];  % Mark's SigY

% Correlation between pixel count and detected photons for fit accuracy
% We calibrate counts to # photons using a number set in the reviewer GUI
N = [SupResParams.Sum_signal] / countsPerPhoton;
% bkgd is Poisson noise level - estimated from dark noise on CCD
bkgd = [SupResParams.avg_brigthness] / countsPerPhoton;


% Compute variance of localisations
deltaXSquared(:,1) = ((sigROW).^2 + (pixelSize)^2/12)./(N) +...
      (8*pi*(sigROW).^4.*(bkgd).^2) ./ (pixelSize^2.*(N).^2); 

deltaXSquared(:,2) = ((sigCOL).^2 + (pixelSize)^2/12)./(N) +...
      (8*pi*(sigCOL).^4.*(bkgd).^2) ./ (pixelSize^2.*(N).^2); 

% Compute standard deviation of localisations  
SupResDeltaX = sqrt(deltaXSquared);
X = num2cell(SupResDeltaX(:,1));
Y = num2cell(SupResDeltaX(:,2));

[SupResParams.x_std] = deal(X{:});
[SupResParams.y_std] = deal(Y{:});

ch_data.localization.results.SupResParams = SupResParams;
end
   

  