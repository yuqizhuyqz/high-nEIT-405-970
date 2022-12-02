function fitresults=quadruplegaussianfit(data, fitparam)
%% fitparam: fit parameters (3*4+1) struct
% startpoints--initial guess
% lowerB--lower bounds of fit parameters
% data: data struct

% returns: fit-matlab, adj. Rsq, sep, fwhm, psnr= 20*log10(max/rms),  peak
% centers in THz, uncert @ 95% level 

% four gaussians
gauss4Eqn = 'a1*exp(-(x-b1)^2/c1^2/2)+a2*exp(-(x-b2)^2/c2^2/2)+a3*exp(-(x-b3)^2/c3^2/2)+a4*exp(-(x-b4)^2/c4^2/2)+d';
% % format x-freq for fitting -- MHz, relative to the start of the scan
x=(data.wavemeter'-min(data.wavemeter')).*1e6; 
% % fit to gaussian
[f, gof] = fit(x,data.lockinavg',gauss4Eqn,...
    'Start', fitparam.startPoints, 'Lower', fitparam.lowerB)
% conf. intervals @ 95% level
ci = confint(f,.95);
% 
% % return obj.
fitresults=struct();
% return fit, rsq, x vector in fit
fitresults.fit=f;
fitresults.Rsq=gof.adjrsquare;
fitresults.x=x;
% 
% % calculate fwhm and sep [Mhz]
fitresults.fwhm = 2*sqrt(2*log(2)).*[f.c1, f.c2, f.c3, f.c4];
fitresults.fwhmerror=2*sqrt(2*log(2)).*[diff(ci(:,9))/2 diff(ci(:,10))/2 ...
    diff(ci(:,11))/2 diff(ci(:,12))/2];
fitresults.sep=[f.b2-f.b1 f.b3-f.b2 f.b4-f.b3]; 
fitresults.seperror=[sqrt((diff(ci(:,5))/2)^2+(diff(ci(:,5))/2)^2) ...
    sqrt((diff(ci(:,6))/2)^2+(diff(ci(:,7))/2)^2) sqrt((diff(ci(:,7))/2)^2+(diff(ci(:,8))/2)^2)]; 

% % calculate mean sq. error from 'noise'-- outside the 4\sigma radius of either peak
xpeak=(abs(x-f.b1)<4*f.c1 | abs(x-f.b2)<4*f.c2 | abs(x-f.b3)<4*f.c3 | abs(x-f.b4)<4*f.c4);

% calculate peak signal-to-noise ratio:  psnr(dB)=20*log10(max/rms)
mse=std(data.lockinavg(~xpeak))^2/length(data.lockinavg(~xpeak))+sum((data.lockinerror).^2);
fitresults.psnr=20*log10(max(data.lockinavg)/sqrt(mse));

% get peak centers (L2R) mean and ci [THz]
fitresults.peak =[f.b1 f.b2 f.b3 f.b4].*1e-6+min(data.wavemeter);
fitresults.peakerror=[(diff(ci(:,5))/2)*1e-6 (diff(ci(:,6))/2)*1e-6 ...
    (diff(ci(:,7))/2)*1e-6 (diff(ci(:,8))/2)*1e-6];
end