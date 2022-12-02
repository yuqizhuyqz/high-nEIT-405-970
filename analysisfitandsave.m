% import .mat file as data
filename='scan1.mat';
data=load(filename);
% add file name (w/o extension) as a property
[~, namename, ~] = fileparts(filename); data.filename=namename;
%% plot lockin output vs freq 
figure;hold on;
% yyaxis left
errorbar(data.wavemeter', data.lockinavg', data.lockinerror);
xlabel('frequency [THz]'); ylabel('lock in output [arb. units]');
% yyaxis right
% plot(data.wavemeter, data.piezo,'.'); ylabel('piezo voltage [V]');
title(strjoin({data.filename}));
set(gca,'Fontsize',12);
% print('data','-depsc')
%% step size hist.
figure;
histogram(diff(data.wavemeter.*1e6));
xlabel('step size [MHz]');ylabel('count');
%% fit to two gaussians and plot
% specify fit parameters
fitparam=struct();
% initial guess
fitparam.startPoints=[2 1 40 240 3 1 1];
% lower bound 
fitparam.lowerB=[0 0 0 0 0.1 .1 -2];
fitresults=doublegaussianfit(data, fitparam)
plotandlabel(data, fitresults, 0.3)
%% fit to four gaussians and plot
% specify fit parameters
fitparam=struct();
% initial guess
fitparam.startPoints=[5 5 1 5 60 75 260 270 1 1 3 2 -1];

% lower bound 
fitparam.lowerB=[0 0 0 0 0 0 0 0.1 .1 -3];

fitresults=quadruplegaussianfit(data, fitparam);
plotandlabel(data, fitresults, 0.3)
%% save fit results and parameters to google drive
save([dirG, '/', strjoin({data.filename,'analysis'},'') '.mat'], 'fitresults', 'fitparam')
%% fit, plot and save multiple scans individually
for i=72
  
    filenamei=sprintf('scan%d.mat',i);datai=load(filenamei);
    [~, namename, ~] = fileparts(filenamei);
    datai.filename=namename;
    % specify fit parameters
    fitparam=struct();
    % initial guess
    fitparam.startPoints=[3 1 50 250 1 1.5 1];
    % lower bound 
    fitparam.lowerB=[0 0 0 0 0.1 .1 -2];
    fitresults=doublegaussianfit(datai, fitparam);
    
    plotandlabel(datai, fitresults, 0.3);
    save([dirG, '/', strjoin({datai.filename,'analysis'},'') '.mat'], ...
        'fitresults', 'fitparam');
end
%%
dirG='/Users/JimCasy/Google Drive/Shared drives/RAY/data/August2021/0825';
scannum=1;
filename=sprintf('scan%d.mat',scannum);datai=load(filename);
analysis=sprintf('scan%danalysis.mat',scannum);ff=load(analysis);
f=ff.fitresults;

figure('units','normalized','position',[.2 0.2 .7 .4]);hold on;
c=[0, .353, 1]; % blue
c2=[1, .149 0]; % red

%[1, .647 0]; %orange
% c=colors.neon(3,:);

plot(datai.wavemeter', datai.lockinavg, '.',...
    'color',c);
plot(datai.wavemeter', f.fit(f.x),'color',c);

% label peaks
h=xline(f.peak(1),'--', ...
    { [num2str(f.peak(1),8), ' THz']},...
    'linewidth',1,'Fontsize',18,'LabelVerticalAlignment','middle',...
    'LabelhorizontalAlignment','center','color',c);
h.Annotation.LegendInformation.IconDisplayStyle = 'off';

ax=gca;
% text(peakv0+1e-5, ax.YLim(2)*.8,'v/c=-hfs_{4S}/f(4S-5P_{1/2})',...
%     'Fontsize',14,'color',c); 
text(f.peak(1)+1e-5, ax.YLim(2)*.8,'v=0',...
    'Fontsize',18,'color',c); 


text(f.peak(2)-4e-5, ax.YLim(2)*.8,'v= -\Delta_{hfs}\lambda_p',...
    'Fontsize',18,'color',c); 

h=xline(f.peak(2),'--', ...
    { [num2str(f.peak(2),8), ' THz']},...
    'linewidth',1,'Fontsize',18,'LabelVerticalAlignment','middle',...
    'LabelhorizontalAlignment','center','color',c);
h.Annotation.LegendInformation.IconDisplayStyle = 'off';

title('4S_{1/2}(F=1)\rightarrow 5P_{1/2}(F=1) \rightarrow 70S');
xlabel('frequency [THz]'); ylabel('lock-in output [arb. units]');
set(gca,'Fontsize',18,'fontweight','bold');
% print('F1F228S','-depsc')

scannum=2;
filename=sprintf('scan%d.mat',scannum);datai=load(filename);
analysis=sprintf('scan%danalysis.mat',scannum);ff=load(analysis);
f=ff.fitresults;

plot(datai.wavemeter', datai.lockinavg, '.',...
    'color',c2);
plot(datai.wavemeter', f.fit(f.x),'color',c2);


% label peaks
h=xline(f.peak(1),'--', ...
    { [num2str(f.peak(1),8), ' THz']},...
    'linewidth',1,'Fontsize',18,'LabelVerticalAlignment','middle',...
    'LabelhorizontalAlignment','right','color',c2);
h.Annotation.LegendInformation.IconDisplayStyle = 'off';

h=xline(f.peak(2),'--', ...
    { [num2str(f.peak(2),8), ' THz']},...
    'linewidth',1,'Fontsize',18,'LabelVerticalAlignment','middle',...
    'LabelhorizontalAlignment','right','color',c2);
h.Annotation.LegendInformation.IconDisplayStyle = 'off';
legend('scan 1 data', 'scan 1 fit', 'scan 2 data', 'scan 2 fit')
% print('signal70Sv2','-dpng')
