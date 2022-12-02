%% import data from 08/23 and 08/25
% add data folder and analysis folder to path
addpath('/Users/JimCasy/Google Drive/Shared drives/RAY/data/August2021/0825',...
'/Users/JimCasy/Google Drive/Shared drives/RAY/data/August2021/0823',...
'/Users/JimCasy/Google Drive/Shared drives/RAY/data/August2021/0830');
d1=load('nSnD5060.mat');
d2= load('nSnD6070.mat'); d3= load('nSnD7090.mat');
%% Ry. constant for K
Ry=10973731.568508; %Ry const. 1/m [Mohr et al 2016]
% me=9.10938356e-31/(1.66053906660e-27) %electron mass in amu CODATA
me=5.48579909070e-4; % Electron molar mass [Mohr et al 2016]
ArK39=38.9637064864; %relative atomic mass from NIST https://physics.nist.gov/cgi-bin/Compositions/stand_alone.pl?ele=K

format longG
Ry39=Ry/(1+me/ArK39)/100 %corrected Ry const. 1/cm
Ry39=109735.7706656;
%% ionization energy and q.defect v2: fit to diff orders, everything other than Ry.
% combine nS data add 28S and 4S(gs)
dataS=struct();
dataS.x=[d1.nSseries d2.nSseries d3.nSseries 28 4];
dataS.y=THz2wavenumber([d1.stateenergynS; d2.stateenergynS;...
    d3.stateenergynS; 1044.63243; 0]);%+.0015;
fitresults2S = fitRylevels(dataS, 2)
fitresults4S = fitRylevels(dataS, 4);
% fitresults6S = fitRylevels(dataS, 6);
% combine nD data
dataD=struct();
dataD.x=[d1.nDseries d2.nDseries d3.nDseries];
dataD.y=THz2wavenumber([d1.stateenergynD; d2.stateenergynD; d3.stateenergynD]);

fitresults2D = fitRylevels(dataD, 2);
fitresults4D = fitRylevels(dataD, 4);
% fitresults6D = fitRylevels(dataD, 6);
%% plot 
% c=colors.neon(4,:);
% c2=[.51, 0, .78];%colors.neon(4,:); 
c=[1, .149 0]; % red
c2=[0, .353, 1]; % blue

figure('units','normalized','position',[.2 .2 .5 .6]); hold on;
plot(dataS.x(1:end-2), dataS.y(1:end-2),'s','linewidth',1,'color',c);
plot(dataS.x(1:end-2),fitresults2S.fit(dataS.x(1:end-2)),'linewidth',1,'color',c);
plot(dataD.x, dataD.y,'d','linewidth',1,'color',c2);
plot(dataD.x, fitresults2D.fit(dataD.x), 'linewidth',1,'color',c2)

ylabel('E_{n,l,j} [cm^{-1}]'); ytickformat('%.4f')

xlabel('principal quantum number n');
legend('data: nS series', 'fit E_{nS}^{fit} ', 'data: nD series', ...
    'fit E_{nD}^{fit}', 'location','northwest');
set(gca,'Fontsize',18,'FontWeight','bold'); 

% print('levels5090','-depsc')

axes('Position',[.43 .2 .2 .2]);box on
% tiledlayout(2,1)

plot(dataS.x(1:end-2), dataS.y(1:end-2)-fitresults2S.fit(dataS.x(1:end-2)),'s','linewidth',1,'color',c);
ylabel('\DeltaE_{nS} [cm^{-1}]');yline(0);ax=gca;ax.XLim=[49 90];xticks(50:5:90); 
set(gca,'Fontsize',16) %'FontWeight','bold'); 

axes('Position',[.7 .2 .2 .2]);box on;
plot(dataD.x, dataD.y-fitresults2D.fit(dataD.x),'d','linewidth',1,'color',c2);
yline(0);ylabel('\DeltaE_{nD} [cm^{-1}]');ax=gca;ax.XLim=[47 90];
xticks(50:5:90); 
set(gca,'Fontsize',16)%,'FontWeight','bold'); 
print('levels5090inset','-depsc')
%% residual plots
yy1= 3.500980552572258e4 -Ry39./(dataS.x(1:end-2)-2.18083814337-(fitresults2S.fit.c-.0004)./(dataS.x(1:end-2)...
    -2.18083814337).^2).^2;
yy2= 3.500980514242603e4 -Ry39./(dataS.x(1:end-2)-2.18105565774-(fitresults2S.fit.c+.0004)./(dataS.x(1:end-2)...
    -2.18105565774).^2).^2;
eb1=(yy1-yy2);
yy3= 3.500980429894320e4 -Ry39./(dataD.x-.27702408693-(-.20962939540)./(dataD.x...
    -.27702408693).^2).^2;
yy4= 3.500980488130599e4 -Ry39./(dataD.x-.27627376423-(1.04935318721)./(dataD.x...
    -.27627376423).^2).^2;
eb2=(yy3-yy4)/2;
% figure;hold on;
subplot(2,1,1);hold on;ylabel('\DeltaE_{nS} [cm^{-1}]');
% errorbar(dataS.x(1:end-2), dataS.y(1:end-2)-fitresults2S.fit(dataS.x(1:end-2)),eb1,'s','linewidth',1,'color',c)
plot(dataS.x(1:end-2), dataS.y(1:end-2)-fitresults2S.fit(dataS.x(1:end-2)),'s','linewidth',1,'color',c);
% plot(dataS.x(1:end-2), dataS.y(1:end-2)-yy1','bs');plot(dataS.x(1:end-2), dataS.y(1:end-2)-yy2','bs');
yline(0);ax=gca;ax.XLim=[49 90];xticks(50:5:90); 
% annotation(.3,.4,'nS')
set(gca,'Fontsize',18,'FontWeight','bold'); 

subplot(2,1,2);hold on;ylabel('\DeltaE_{nD_{3/2}} [cm^{-1}]');
% plot(dataD.x, dataD.y-yy1','bs');plot(dataS.x(1:end-2), dataS.y(1:end-2)-yy2','bs');

% errorbar(dataD.x, dataD.y-fitresults2D.fit(dataD.x),eb2,'d','linewidth',1,'color',c2);
yline(0)
plot(dataD.x, dataD.y-fitresults2D.fit(dataD.x),'d','linewidth',1,'color',c2);
% plot(dataD.x, dataD.y-yy3','rd');
xlabel('principal quantum number (n)');
set(gca,'Fontsize',18,'FontWeight','bold'); ax=gca;ax.XLim=[47 88];
xticks(50:5:90); 
% print('levels5090resnobar','-depsc')
%% save ionization E and q defect to .mat
save([dirG, '/', 'QDEinftyv2', '.mat'], 'fitresults2S','fitresults2D',...
    'fitresults4S','fitresults4D','fitresults6S','fitresults6D');
%% quantum defect
deltanS=fitresults6S.delta(1)...
    -fitresults6S.delta(2)./(dataS.x(1:end-2)-fitresults6S.delta(1)).^2 ...
    -fitresults6S.delta(3)./(dataS.x(1:end-2)-fitresults6S.delta(1)).^4 ...
    -fitresults6S.delta(4)./(dataS.x(1:end-2)-fitresults6S.delta(1)).^6;
%
deltanD=fitresults6D.delta(1)...
    -fitresults6D.delta(2)./(dataD.x-fitresults6D.delta(1)).^2 ...
    -fitresults6D.delta(3)./(dataD.x-fitresults6D.delta(1)).^4 ...
    -fitresults6D.delta(4)./(dataD.x-fitresults6D.delta(1)).^6;
%%
deltanS=fitresults4S.delta(1)...
    -fitresults4S.delta(2)./(dataS.x(1:end-2)-fitresults4S.delta(1)).^2 ...
    -fitresults4S.delta(3)./(dataS.x(1:end-2)-fitresults4S.delta(1)).^4;
deltanD=fitresults2D.delta(1)...
    -fitresults4D.delta(2)./(dataD.x-fitresults4D.delta(1)).^2 ...
    -fitresults4D.delta(3)./(dataD.x-fitresults4D.delta(1)).^4;
%%
format shortG

figure; hold on;
xlabel('principal quantum number (n)');ylabel('quantum defect of nS (\delta)'); 
yyaxis left
plot(dataS.x(1:end-2), deltanS, 's','linewidth',1,'color',c)
yyaxis right
ylabel('quantum defect of nD_{3/2} (\delta)'); 
plot(dataD.x, deltanD, 'd','linewidth',1,'color',c2)
ax=gca; ax.YAxis(1).Color=c;ax.YAxis(2).Color=c2;
set(gca,'Fontsize',14,'FontWeight','bold'); 
% print('QDefect','-depsc')
%%
