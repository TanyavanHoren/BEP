function SupResParams = rainSTORM_main_loop(frameIdx,Frame,algo_handle,settings)

rad = settings.rad.val;
Thresh = settings.Thresh.val;

% 1. Identify local maxima above threshold, and return [row,col,magnitude]
myPixels = rainSTORM_avNMS(Frame,rad);

% 2. Thresholding. To remove noise maxima and weak signals.
myPixels((myPixels(:,3))<Thresh,:)=[]; % Apply threshold
myPixels = flipud(sortrows(myPixels,3)); % Sort for human-readability

bkgdSig = std(double(Frame(Frame < mean(Frame(:))))); % Avoids signal

% 3. Localise centre of each pixellated blur (and reject if not Gaussian)
%Implement selected image processing algorithm.

SupResParams = algo_handle(frameIdx,Frame,myPixels,bkgdSig,settings);

% % % switch algo_name
% % %     case 'Least-Squares Gaussian Halt3'
% % %         SupResParams = rainSTORM_fitLocGF3(frameIdx,Frame,myPixels,bkgdSig,settings);
% % %     case 'Least-Squares Gaussian Thorough'
% % %         % Least squares Gaussian Fitting without halting
% % %         SupResParams = rainSTORM_fitLocGF(frameIdx,Frame,myPixels,bkgdSig,settings);
% % %     case 'Centre of Mass'
% % %         % Or fit by Centre of Mass: find 1st+2nd moment of intensity
% % %         SupResParams = rainSTORM_fitCoM(frameIdx,Frame,myPixels,bkgdSig,settings);
% % %     otherwise
% % %         error('Unknown localization algorithm.')
% % % end
end