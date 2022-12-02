%% nS series (50-60), and nD series (48-58) data from 08/23 
% add data folder and analysis folder to path
dirG='/Users/JimCasy/Google Drive/Shared drives/RAY/data/August2021/0823';
    addpath(dirG,'/Users/JimCasy/Documents/now!/EIT');
%% nS series
nSseries=[50 repelem(51:1:60,2)]; % repeated scans for the same n
scannumnS=[1 6 7 10 11 12 13 16 17 20 21 24 25 30 31 34 35 38 39 42 43];
peakv0nS=zeros(length(nSseries),2);

cmap=cat(1,colormap(cool(5)),colormap(winter(5)));
for i=1:length(nSseries)
    
    filenamei=sprintf('scan%d.mat',scannumnS(i));datai=load(filenamei);
    analysisi=sprintf('scan%danalysis.mat',scannumnS(i));ff=load(analysisi);
    fS=ff.fitresults;
    
    f=figure('units','normalized','position',[.2 0.2 .7 .4]);
    hold on;
    xlabel('frequency [THz]'); ylabel('lock in output [arb. units]');

    plot(datai.wavemeter', datai.lockinavg, '.',...
        'color',cmap(mod(i,length(cmap))+1,:));
    h=plot(datai.wavemeter', fS.fit(fS.x),'color',cmap(mod(i,length(cmap))+1,:));
    h.Annotation.LegendInformation.IconDisplayStyle = 'off';
    
    
    if length(fS.peak)==4
        % get freq of v=0 peak (when locking to 4S(2)->5P1/2(co)) mean and ci
        peakv0nS(i,1) =fS.peak(2);
        peakv0nS(i,2)=fS.peakerror(2);
    else
        % get freq of v=0 peak (when locking to 4S(2)->5P1/2(1)) mean and ci
        peakv0nS(i,1)=fS.peak(1);
        peakv0nS(i,2)=fS.peakerror(1);
    end
     % label v=0 peak
    xline(peakv0nS(i,1),'--', ...
    { [num2str(fS.peak(1),8), ' THz']},...
    'linewidth',1,'Fontsize',14,'LabelVerticalAlignment','middle',...
    'LabelhorizontalAlignment','center','color',cmap(mod(i,length(cmap))+1,:));
end
%% nD series
nDseries=48:1:58; % [mW] 
nDseries= repelem(nDseries,2); % repeated scans for the same n

scans=1:43; % all scans
p = ismember(scans,scannumnS);
scannumnD=scans(~p);

peakv0nD=zeros(length(nDseries),2);
% cmap=colors.neon;
cmap=cat(1,colormap(cool(5)),colormap(winter(5)));

for i=1:length(nDseries)
    
    filenamei=sprintf('scan%d.mat',scannumnD(i));datai=load(filenamei);
    analysisi=sprintf('scan%danalysis.mat',scannumnD(i));ff=load(analysisi);
    fS=ff.fitresults;
    
    f=figure('units','normalized','position',[.2 0.2 .7 .4]);
    hold on;
    plot(datai.wavemeter', datai.lockinavg, '.',...
        'color',cmap(mod(i,length(cmap))+1,:));
    h=plot(datai.wavemeter', fS.fit(fS.x),'color',cmap(mod(i,length(cmap))+1,:));
    h.Annotation.LegendInformation.IconDisplayStyle = 'off';
  
    % get freq of v=0 peak (when locking to 4S(1)->5P1/2(1)) mean and ci
    if length(fS.peak)==4
        % get freq of v=0 peak (when locking to 4S(2)->5P1/2(co)) mean and ci
        peakv0nD(i,1) =fS.peak(2);
        peakv0nD(i,2)=fS.peakerror(2);
    else
        % get freq of v=0 peak (when locking to 4S(2)->5P1/2(1)) mean and ci
        peakv0nD(i,1) =fS.peak(1);
        peakv0nD(i,2)=fS.peakerror(1);
    end
    
    % label v=0 peak
    xline(peakv0nD(i,1),'--', ...
    { [num2str(peakv0nD(i,1),8), ' THz']},...
    'linewidth',1,'Fontsize',14,'LabelVerticalAlignment','middle',...
    'LabelhorizontalAlignment','center','color',cmap(mod(i,length(cmap))+1,:));

    xlabel('frequency [THz]'); ylabel('lock in output [arb. units]');
end
%% state energy [THz]
firsttransition=740.52932; % 4S(1)-5P1/2(1) in Thz
stateenergynS=firsttransition+peakv0nS(:,1);
stateenergynD=firsttransition+peakv0nD(:,1);
%% save nS & nD series lines to mat.
peaknS=peakv0nS; peaknD = peakv0nD;
save([dirG, '/', 'nSnD5060', '.mat'], 'nSseries', 'peaknS', ....
    'stateenergynS','nDseries','peaknD', 'stateenergynD');
%% nS series (60-71), and nD series (59-69) data from 08/25
% add data folder and analysis folder to path
dirG='/Users/JimCasy/Google Drive/Shared drives/RAY/data/August2021/0825';
addpath(dirG,'/Users/JimCasy/Documents/now!/EIT');
%% nS series
nSseries=[repelem(61:70,2) 71]; % double
scannumnS=[41 42 39 40 35 36 31 32 23 24 21 22 13 14 17 18 5 6 1 2 11];
%
peakv0nS=zeros(length(nSseries),2);
% cmap=colors.neon;
cmap=cat(1,colormap(cool(5)),colormap(winter(5)));

for i=1:length(nSseries)
    
    filenamei=sprintf('scan%d.mat',scannumnS(i));datai=load(filenamei);
    analysisi=sprintf('scan%danalysis.mat',scannumnS(i));ff=load(analysisi);
    fS=ff.fitresults;
    
    figure('units','normalized','position',[.2 0.2 .7 .4]);hold on;
    plot(datai.wavemeter', datai.lockinavg, '.',...
        'color',cmap(mod(i,length(cmap))+1,:));
    h=plot(datai.wavemeter', fS.fit(fS.x),'color',cmap(mod(i,length(cmap))+1,:));
    h.Annotation.LegendInformation.IconDisplayStyle = 'off';
  
    if length(fS.peak)==4
        % get freq of v=0 peak (when locking to 4S(2)->5P1/2(co)) mean and ci
        peakv0nS(i,1) =fS.peak(2);
        peakv0nS(i,2)=fS.peakerror(2);
    else
        % get freq of v=0 peak (when locking to 4S(2)->5P1/2(1)) mean and ci
        peakv0nS(i,1)=fS.peak(1);
        peakv0nS(i,2)=fS.peakerror(1);
    end
    
     % label v=0 peak
    xline(peakv0nS(i,1),'--', ...
    { [num2str(peakv0nS(i,1),8), ' THz']},...
    'linewidth',1,'Fontsize',14,'LabelVerticalAlignment','middle',...
    'LabelhorizontalAlignment','center','color',cmap(mod(i,length(cmap))+1,:));

    xlabel('frequency [THz]'); ylabel('lock in output [arb. units]');
end
%% nD series
nDseries=[59 59 60 60 61 62 62 63 repelem(64:67,2) 68 69 69]; % 
scannumnD=[43 44 37 38 33 29 30 26 27 28 15 16 19 20 3 4 7 9 10];

peakv0nD=zeros(length(nDseries),2);
cmap=cat(1,colormap(cool(5)),colormap(winter(5)));

for i=1:length(nDseries)
    
    filenamei=sprintf('scan%d.mat',scannumnD(i));datai=load(filenamei);
    analysisi=sprintf('scan%danalysis.mat',scannumnD(i));ff=load(analysisi);
    fS=ff.fitresults;
    
    figure('units','normalized','position',[.2 0.2 .7 .4]);hold on;
    plot(datai.wavemeter', datai.lockinavg, '.',...
        'color',cmap(mod(i,length(cmap))+1,:));
    h=plot(datai.wavemeter', fS.fit(fS.x),'color',cmap(mod(i,length(cmap))+1,:));
    h.Annotation.LegendInformation.IconDisplayStyle = 'off';
  
   % get freq of v=0 peak (when locking to 4S(1)->5P1/2(1)) mean and ci
    if length(fS.peak)==4
        % get freq of v=0 peak (when locking to 4S(2)->5P1/2(co)) mean and ci
        peakv0nD(i,1) =fS.peak(2);
        peakv0nD(i,2)=fS.peakerror(2);
    else
        % get freq of v=0 peak (when locking to 4S(2)->5P1/2(1)) mean and ci
        peakv0nD(i,1) =fS.peak(1);
        peakv0nD(i,2)=fS.peakerror(1);
    end
  
    
     % label v=0 peak
    xline(peakv0nD(i,1) ,'--', ...
    { [num2str(peakv0nD(i,1) ,8), ' THz']},...
    'linewidth',1,'Fontsize',14,'LabelVerticalAlignment','middle',...
    'LabelhorizontalAlignment','center','color',cmap(mod(i,length(cmap))+1,:));

    xlabel('frequency [THz]'); ylabel('lock in output [arb. units]');
end
%% state energy [THz]
firsttransition=740.52932; % 4S(1)-5P1/2(1) in Thz
stateenergynS=firsttransition+peakv0nS(:,1); 
stateenergynD=firsttransition+peakv0nD(:,1); 
%% save nS & nD series lines to mat.
peaknS=peakv0nS; peaknD = peakv0nD;
save([dirG, '/', 'nSnD6070', '.mat'], 'nSseries', 'peaknS', ....
    'stateenergynS','nDseries','peaknD', 'stateenergynD');
%% nS series (72-89), and nD series (70-87) data from 08/30
% add data folder and analysis folder to path
dirG='/Users/JimCasy/Google Drive/Shared drives/RAY/data/August2021/0830';
addpath(dirG,'/Users/JimCasy/Documents/now!/EIT');
%% 
nSseries=[repelem(72:77,2) 78 repelem(79:81,2) 82 83 84 84 85 85 ...
    86 repelem(87:89,2)]; % 
scannumnS=[1 2 7 8 9 10 15 16 21 22 19 20 28 33 34 37 38 27 29 54 ...
    46 41 42 51 52 57 63 64 69 70 65 66];
nDseries=[repelem(70:72,2) 73 repelem(74:80,2) 81 repelem(82:83,2) 84 ...
    85 85 86 86 87 ]; % 
scannumnD=[3 4 5 6 11 12 14 23 24 17 18 25 26 35 36 39 40 31 32 ...
    55 56 48 43 44 49 50 59 61 62 71 72 67];
%% nS series
peakv0nS=zeros(length(nSseries),2);
% cmap=colors.neon;
cmap=cat(1,colormap(cool(5)),colormap(winter(5)));

for i=1:length(nSseries)
    
    filenamei=sprintf('scan%d.mat',scannumnS(i));datai=load(filenamei);
    analysisi=sprintf('scan%danalysis.mat',scannumnS(i));ff=load(analysisi);
    fS=ff.fitresults;
    
    figure('units','normalized','position',[.2 0.2 .7 .4]);hold on;
    plot(datai.wavemeter', datai.lockinavg, '.',...
        'color',cmap(mod(i,length(cmap))+1,:));
    h=plot(datai.wavemeter', fS.fit(fS.x),'color',cmap(mod(i,length(cmap))+1,:));
    h.Annotation.LegendInformation.IconDisplayStyle = 'off';
  
    if length(fS.peak)==4
        % get freq of v=0 peak (when locking to 4S(2)->5P1/2(co)) mean and ci
        peakv0nS(i,1) =fS.peak(2);
        peakv0nS(i,2)=fS.peakerror(2);
    else
        % get freq of v=0 peak (when locking to 4S(2)->5P1/2(1)) mean and ci
        peakv0nS(i,1)=fS.peak(1);
        peakv0nS(i,2)=fS.peakerror(1);
    end
    
     % label v=0 peak
    xline(peakv0nS(i,1),'--', ...
    { [num2str(peakv0nS(i,1),8), ' THz']},...
    'linewidth',1,'Fontsize',14,'LabelVerticalAlignment','middle',...
    'LabelhorizontalAlignment','center','color',cmap(mod(i,length(cmap))+1,:));

    xlabel('frequency [THz]'); ylabel('lock in output [arb. units]');
end
%% nD series
peakv0nD=zeros(length(nDseries),2);
cmap=cat(1,colormap(cool(5)),colormap(winter(5)));

for i=1:length(nDseries)
    
    filenamei=sprintf('scan%d.mat',scannumnD(i));datai=load(filenamei);
    analysisi=sprintf('scan%danalysis.mat',scannumnD(i));ff=load(analysisi);
    fS=ff.fitresults;
    
    figure('units','normalized','position',[.2 0.2 .7 .4]);hold on;
    plot(datai.wavemeter', datai.lockinavg, '.',...
        'color',cmap(mod(i,length(cmap))+1,:));
    h=plot(datai.wavemeter', fS.fit(fS.x),'color',cmap(mod(i,length(cmap))+1,:));
    h.Annotation.LegendInformation.IconDisplayStyle = 'off';
  
   % get freq of v=0 peak (when locking to 4S(1)->5P1/2(1)) mean and ci
    if length(fS.peak)==4
        % get freq of v=0 peak (when locking to 4S(2)->5P1/2(co)) mean and ci
        peakv0nD(i,1) =fS.peak(2);
        peakv0nD(i,2)=fS.peakerror(2);
    else
        % get freq of v=0 peak (when locking to 4S(2)->5P1/2(1)) mean and ci
        peakv0nD(i,1) =fS.peak(1);
        peakv0nD(i,2)=fS.peakerror(1);
    end
 
     % label v=0 peak
    xline(peakv0nD(i,1) ,'--', ...
    { [num2str(peakv0nD(i,1) ,8), ' THz']},...
    'linewidth',1,'Fontsize',14,'LabelVerticalAlignment','middle',...
    'LabelhorizontalAlignment','center','color',cmap(mod(i,length(cmap))+1,:));

    xlabel('frequency [THz]'); ylabel('lock in output [arb. units]');
end
%% state energy [THz]
firsttransition=740.52932; % 4S(1)-5P1/2(1) in Thz
stateenergynS=firsttransition+peakv0nS(:,1); 
stateenergynD=firsttransition+peakv0nD(:,1); 
%% save nS & nD series lines to mat.
peaknS=peakv0nS; peaknD = peakv0nD;
save([dirG, '/', 'nSnD7090', '.mat'], 'nSseries', 'peaknS', ....
    'stateenergynS','nDseries','peaknD', 'stateenergynD');