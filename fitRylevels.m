function fitresults = fitRylevels(data, order)
%
% input: data with x, y fields to fit,
% order=o(n), 
% output: fitresults with fit results, ionization energy, deltas in a
% vector, uncert.

%% corrected rydberg constant
% Ry=10973731.568160; %Ry const. 1/m, CODATA
% me=9.1093837015e-31/(1.66053906660e-27); %electron mass in amu CODATA
% format longG
% Ry39=Ry/(1+me/39)/100; %corrected Ry const. 1/cm
%%
if order==4
    Ryeqn='a-109735.772121603/(x-b-c/(x-b)^2-d/(x-a)^4)^2';
    startpt=[35009 1 .1 .1];
elseif order ==6
    Ryeqn='a-109735.772121603/(x-b-c/(x-b)^2-d/(x-a)^4-e/(x-a)^6)^2';
    startpt=[35009 1 .1 .1 .1];
elseif order==2 
    Ryeqn='a-109735.772121603/(x-b-c/(x-b)^2)^2';
    startpt=[35009 1 .1];
else
   error('Error. \n this can only fit 2, 4, 6 order ');
end

[f, gof] = fit(data.x', data.y,Ryeqn, 'Start', startpt);

% conf. intervals @ 95% level
ci = confint(f,.95);
fitresults =struct();
fitresults.fit=f; fitresults.order=order;
fitresults.gof=gof;
fitresults.Einf=f.a; 
fitresults.Einferror=abs(diff(ci(:,1)))/2;

if order==2
    fitresults.delta=[f.b f.c];
    fitresults.deltaerrorS=abs(diff(ci(:,2:3)))/2;
elseif order==4
    fitresults.delta=[f.b f.c f.d];
    fitresults.deltaerror=abs(diff(ci(:,2:4)))/2;
elseif order ==6
    fitresults.delta=[f.b f.c f.d f.e];
    fitresults.deltaerror=abs(diff(ci(:,2:5)))/2;
end
end