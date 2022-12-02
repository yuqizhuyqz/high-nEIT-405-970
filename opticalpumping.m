%% optical pumping --data from 08/17 scan 3 5 6- co; scan 4,7 2->1; scan 8 2->2
% add data folder and analysis folder to path
dirG='/Users/JimCasy/Google Drive/Shared drives/RAY/data/August2021/0817';
addpath(dirG,'/Users/JimCasy/Documents/now!/EIT');
% colors=load('colors.mat');
%% 4 gaussians scan 3,5,6
scannum=6;
filename=sprintf('scan%d.mat',scannum);datai=load(filename);
analysis=sprintf('scan%danalysis.mat',scannum);ff=load(analysis);
f=ff.fitresults;
figure('units','normalized','position',[.2 0.2 .7 .4]);hold on;
c=[1, .149 0]; % red
%colors.neon(3,:);
% % c=[	45.9, 63.5, 51.8]./100;
% c=[	.145, 0, 1]%[0, .353, 1];	

plot(datai.wavemeter', datai.lockinavg, '.',...
    'color',c,'markersize',8);
h=plot(datai.wavemeter', f.fit(f.x),'color',c,'LineWidth',1);
h.Annotation.LegendInformation.IconDisplayStyle = 'off';

% label v=0 peaks (when locking to 4S(1)->5P1/2(co))
xline(f.peak(4),'--', ...
    { [num2str(f.peak(4),8), ' THz']},...
    'linewidth',2.5,'Fontsize',18,'FontWeight','bold','LabelVerticalAlignment','middle',...
    'LabelhorizontalAlignment','center','color',c);
ax=gca;
text(f.peak(4)+1e-5, ax.YLim(2)*.8,'v = -\Delta_{hfs}\lambda_p',...
    'color',c,'Fontsize',20,'FontWeight','bold'); 

xline(f.peak(3),'--', ...
    { [num2str(f.peak(3),8), ' THz']},...
    'linewidth',2.5,'Fontsize',18,'FontWeight','bold','LabelVerticalAlignment','middle',...
    'LabelhorizontalAlignment','center','color',c);

% label v\neq0 peaks (when locking to 4S(1)->5P1/2(co))
xline(f.peak(1),'--', ...
    {[num2str(f.peak(1),8), ' THz']},...
    'linewidth',2.5,'Fontsize',18,'FontWeight','bold','LabelVerticalAlignment','middle',...
    'LabelhorizontalAlignment','center','color',c);

text(f.peak(2)+1e-5, ax.YLim(2)*.8,'v = 0',...
    'Fontsize',20,'color',c,'FontWeight','bold','FontName','Times New Roman'); 
xline(mean(f.peak(2)),'--', ...
    { [num2str(f.peak(2),8), ' THz']},...
    'linewidth',2.5,'Fontsize',18,'FontWeight','bold','LabelVerticalAlignment','middle',...
    'LabelhorizontalAlignment','center','color',c);
xtickformat('%.5f')


title('4S_{1/2}(F=1)\rightarrow 5P_{1/2}(F=c.o.) \rightarrow 28S');
xlabel('frequency [THz]'); ylabel('lock-in output [arb. units]');
set(gca,'Fontsize',18,'fontweight','bold');
print('crossover28S','-depsc')
% print('crossover28S','-dpng')

%% 2 gaussians
scannum=8;
filename=sprintf('scan%d.mat',scannum);datai=load(filename);
analysis=sprintf('scan%danalysis.mat',scannum);ff=load(analysis);
f=ff.fitresults;
fig=figure('units','normalized','position',[.2 0.2 .7 .4]);hold on;
c=[0, .353, 1]; % blue
%[1, .647 0]; %orange
% c=colors.neon(3,:);

plot(datai.wavemeter', datai.lockinavg, '.',...
    'color',c,'markersize',8);
h=plot(datai.wavemeter', f.fit(f.x),'color',c, 'linewidth',1);
h.Annotation.LegendInformation.IconDisplayStyle = 'off';

% label peaks
xline(f.peak(1),'--', ...
    { [num2str(f.peak(1),8), ' THz']},...
    'linewidth',2.5,'Fontsize',18,'FontWeight','bold','LabelVerticalAlignment','middle',...
    'LabelhorizontalAlignment','center','color',c);
ax=gca;
% text(peakv0+1e-5, ax.YLim(2)*.8,'v/c=-hfs_{4S}/f(4S-5P_{1/2})',...
%     'Fontsize',14,'color',c); 
text(f.peak(1)+1e-5, ax.YLim(2)*.8,'v = 0',...
    'Fontsize',20,'FontWeight','bold','color',c); 


text(f.peak(2)-5e-5, ax.YLim(2)*.8,'v = -\Delta_{hfs}\lambda_p',...
    'Fontsize',20,'FontWeight','bold','color',c); 

xline(f.peak(2),'--', ...
    { [num2str(f.peak(2),8), ' THz']},...
    'linewidth',2.5,'Fontsize',18,'FontWeight','bold','LabelVerticalAlignment','middle',...
    'LabelhorizontalAlignment','center','color',c);

title('4S_{1/2}(F=1)\rightarrow 5P_{1/2}(F=2) \rightarrow 28S');
xlabel('frequency [THz]'); ylabel('lock-in output [arb. units]');
% xticklabels({30, 'none','2\pi','3\pi','4\pi','5\pi','6\pi'})
xtickformat('%.5f')

set(gca,'Fontsize',18,'fontweight','bold');
print('F1F228S','-depsc')
% print('F1F228S','-dpng')

%% 
scannum=7;
filename=sprintf('scan%d.mat',scannum);datai=load(filename);
analysis=sprintf('scan%danalysis.mat',scannum);ff=load(analysis);
f=ff.fitresults;
figure('units','normalized','position',[.2 0.2 .7 .4]);hold on;
c=[0, .353, 1];
% [1, .647 0];
% c=colors.neon(3,:);

plot(datai.wavemeter', datai.lockinavg, '.',...
    'color',c,'markersize',8);
plot(datai.wavemeter', f.fit(f.x),'color',c,'LineWidth',1);
% h.Annotation.LegendInformation.IconDisplayStyle = 'off';

% label peaks
h=xline(f.peak(1),'--', ...
    { [num2str(f.peak(1),8), ' THz']},...
    'linewidth',2.5,'Fontsize',18,'fontweight','bold','LabelVerticalAlignment','middle',...
    'LabelhorizontalAlignment','center','color',c);
h.Annotation.LegendInformation.IconDisplayStyle = 'off';

ax=gca;
% text(peakv0+1e-5, ax.YLim(2)*.8,'v/c=-hfs_{4S}/f(4S-5P_{1/2})',...
%     'Fontsize',14,'color',c); 
text(f.peak(1)+1e-5, ax.YLim(2)*.8,'v = 0',...
    'Fontsize',20,'fontweight','bold','color',c); 

text(f.peak(2)-5e-5, ax.YLim(2)*.8,'v= - \Delta_{hfs}\lambda_p',...
    'Fontsize',20,'fontweight','bold','color',c); 

h=xline(f.peak(2),'--', ...
    { [num2str(f.peak(2),8), ' THz']},...
    'linewidth',2.5,'Fontsize',18,'fontweight','bold','LabelVerticalAlignment','middle',...
    'LabelhorizontalAlignment','center','color',c);
h.Annotation.LegendInformation.IconDisplayStyle = 'off';
legend('data','gaussian fit')
title('4S_{1/2}(F=1)\rightarrow 5P_{1/2}(F=1) \rightarrow 28S');
xlabel('frequency [THz]'); ylabel('lock-in output [arb. units]');
set(gca,'Fontsize',18,'fontweight','bold');xtickformat('%.5f')

print('signalexample','-depsc')
% print('signalexample','-dpng')

%% 
scannum=1;
filename=sprintf('scan%d.mat',scannum);datai=load(filename);
analysis=sprintf('scan%danalysis.mat',scannum);ff=load(analysis);
f=ff.fitresults;
figure('units','normalized','position',[.2 0.2 .7 .4]);hold on;
c=[0, .353, 1];
% [1, .647 0]; 
% c=colors.neon(3,:);

plot(datai.wavemeter', datai.lockinavg, '.',...
    'color',c,'markersize',8);
h=plot(datai.wavemeter', f.fit(f.x),'color',c,'LineWidth',1);
h.Annotation.LegendInformation.IconDisplayStyle = 'off';

% label peaks
xline(f.peak(1),'--', ...
    { [num2str(f.peak(1),8), ' THz']},...
    'linewidth',2.5,'Fontsize',18,'fontweight','bold','LabelVerticalAlignment','middle',...
    'LabelhorizontalAlignment','center','color',c);
ax=gca;
% text(peakv0+1e-5, ax.YLim(2)*.8,'v/c=-hfs_{4S}/f(4S-5P_{1/2})',...
%     'Fontsize',14,'color',c); 
text(f.peak(1)+1e-5, ax.YLim(2)*.8,'v = \Delta_{hfs}\lambda_p',...
    'Fontsize',20,'fontweight','bold','color',c); 


text(f.peak(2)-3e-5, ax.YLim(2)*.8,'v = 0',...
    'Fontsize',20,'fontweight','bold','color',c); 

xline(f.peak(2),'--', ...
    { [num2str(f.peak(2),8), ' THz']},...
    'linewidth',2.5,'Fontsize',18,'fontweight','bold','LabelVerticalAlignment','middle',...
    'LabelhorizontalAlignment','center','color',c);

title('4S_{1/2}(F=2)\rightarrow 5P_{1/2}(F=2) \rightarrow 28S');
xlabel('frequency [THz]'); ylabel('lock-in output [arb. units]');
set(gca,'Fontsize',18,'fontweight','bold');xtickformat('%.5f')

print('F2F228S','-depsc')
% print('F2F228S','-dpng')
%%

%% 
dirG='/Users/JimCasy/Google Drive/Shared drives/RAY/data/August2021/0825';
addpath(dirG,'/Users/JimCasy/Documents/now!/EIT');
scannum=36;
filename=sprintf('scan%d.mat',scannum);datai=load(filename);
analysis=sprintf('scan%danalysis.mat',scannum);ff=load(analysis);
ff2=ff;datai2=datai;
%%
mean([datai.lockinavg; datai2.lockinavg]);
%%


f=ff.fitresults;
f2=ff2.fitresults;
fontsizehere=20;
figure('units','normalized','position',[.2 0.2 .7 .4]);hold on;
c=[0, .353, 1];
% [1, .647 0];
% c=colors.neon(3,:);

plot(datai.wavemeter', datai.lockinavg, '.',...
    'color',c,'markersize',10);
% plot(datai2.wavemeter', datai2.lockinavg, '.',...
%     'color',c,'markersize',8);
% plot(datai2.wavemeter', mean([datai.lockinavg; datai2.lockinavg]), '.',...
%     'color','k','markersize',8);

%
plot(datai.wavemeter', f.fit(f.x),'color',c,'LineWidth',1);
% plot(datai2.wavemeter', f2.fit(f2.x),'color',c,'LineWidth',1);

% h.Annotation.LegendInformation.IconDisplayStyle = 'off';

% label peaks
h=xline(f.peak(1),'--', ...
    { [num2str(f.peak(1),8), ' THz']},...
    'linewidth',2.5,'Fontsize',fontsizehere,'fontweight','bold','LabelVerticalAlignment','middle',...
    'LabelhorizontalAlignment','center','color',c);
h.Annotation.LegendInformation.IconDisplayStyle = 'off';

ax=gca;
% text(peakv0+1e-5, ax.YLim(2)*.8,'v/c=-hfs_{4S}/f(4S-5P_{1/2})',...
%     'Fontsize',14,'color',c); 
text(f.peak(1)+1e-5, ax.YLim(2)*.8,'v = 0',...
    'Fontsize',fontsizehere,'fontweight','bold','color',c); 

text(f.peak(2)-5e-5, ax.YLim(2)*.8,'v= - \Delta_{hfs}\lambda_p',...
    'Fontsize',20,'fontweight','bold','color',c); 

h=xline(f.peak(2),'--', ...
    { [num2str(f.peak(2),8), ' THz']},...
    'linewidth',2.5,'Fontsize',fontsizehere,'fontweight','bold','LabelVerticalAlignment','middle',...
    'LabelhorizontalAlignment','center','color',c);
h.Annotation.LegendInformation.IconDisplayStyle = 'off';
legend('data','gaussian fit')
title('4S_{1/2}(F=1)\rightarrow 5P_{1/2}(F=1) \rightarrow 63S');
xlabel('frequency [THz]'); ylabel('lock-in output [arb. units]');
set(gca,'Fontsize',fontsizehere,'fontweight','bold');xtickformat('%.5f')

% print('signalexample63S','-depsc')