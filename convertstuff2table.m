%% export as a table for latex
% matrix=[nSseries(1:2:end)' peakv0nS(1:2:end,1) THz2wavenumber(stateenergynS(1:2:end))];
ind=[20 26];
matrix=[nSseries(ind)' peakv0nS(ind,1) THz2wavenumber(stateenergynS(ind))];

% matrix=[nDseries(1:2:end)' peakv0nD(1:2:end,1) THz2wavenumber(stateenergynD(1:2:end))];
% matrix=[nDseries(end)' peakv0nD(end,1) THz2wavenumber(stateenergynD(end))];

width = 3; % size(matrix, 2);
height = size(matrix, 1);

matrix = num2cell(matrix);
for h=1:height
%  diff formats for diff rows
        matrix{h, 1} = [num2str(matrix{h, 1}, '%2d') 'S']; % int. 
%         matrix{h, 1} = [num2str(matrix{h, 1}, '%2d') '$D_{3/2}$']; % int. 

        matrix{h, 2} = num2str(matrix{h, 2},'%.5f'); % 5 dec.
        matrix{h, 3} = num2str(matrix{h, 3},'%.3f'); % 3 dec.
end
        
fid = fopen('latextable', 'w');
% fprintf(fid, '\\begin{tabular}\r\n');
for h=1:height
    for w=1:width-1
        fprintf(fid, '%s &', matrix{h, w});
    end
        fprintf(fid, '%s\\\\\r\n', matrix{h, width});
end
fclose(fid);
open latextable
%% add , to py array
matrix=[34.6331363 31.867942  29.4094936 27.217193  25.2564241 23.4976263...
  21.9154807 20.488263  19.1972801 18.0264248 16.9617645 15.9912338...
  15.1043529 14.2919934 13.5461912 12.8599822 12.2272472 11.6426195...
  11.1013608 10.5992914 10.1327071  9.6983246  9.293224   8.9148007...
   8.5607316  8.2289376  7.9175526  7.6248998  7.349475   7.0899136...
   6.8449884  6.6135876  6.3947009  6.1874134  5.9908901  5.8043727...
   5.6271663  5.4586385  5.2982081  5.1453424  ]   ;
height = size(matrix, 1);

% matrix = num2cell(matrix);
% for h=1:height
% %  diff formats for diff rows
%         matrix{h, 1} = [num2str(matrix{h, 1}, '%2d') 'S']; % int. 
% %         matrix{h, 1} = [num2str(matrix{h, 1}, '%2d') '$D_{3/2}$']; % int. 
% 
%         matrix{h, 2} = num2str(matrix{h, 2},'%.5f'); % 5 dec.
%         matrix{h, 3} = num2str(matrix{h, 3},'%.3f'); % 3 dec.
% end
        
fid = fopen('latextable2', 'w');
% fprintf(fid, '\\begin{tabular}\r\n');
for h=1:height
    for w=1:width-1
        fprintf(fid, '%s ,', num2str(matrix(h, w),'%.7f'));
    end
%         fprintf(fid, '%s\\\\\r\n', matrix{h, width});
end
% fprintf(fid, '\\end{tabular}\r\n');
fclose(fid);


open latextable2