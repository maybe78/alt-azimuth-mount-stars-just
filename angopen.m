% Загружает из папки ./ang файл по выбору в переменную pointsdata

% Формат:
% в таблице 11 столбцов
% 1 время ЦУ в секундах от начала суток НУ
% 2 дальность в метрах
% 3 азимут в радианах (астрономический - с юга через запад)
% 4 угол места в радианах
% 5 часовой угол в радианах
% 6 склонение в радианах
% 7 безразмерная фаза
% 8 СКО по азимуту в угловых минутах
% 9 СКО по углу места в угловых минутах
%10 блеск в звездных величинах
%11 флаг нахождения в тени земли, 1 - в тени

clc;
disp('Choose ANG file:');
disp(' ');
angdir = dir('ang');
anglist = cell(0);
k = 1;
for i=1:length(angdir)
    if (length(strfind(angdir(i).name,'.ang'))>0)
        anglist{k} = angdir(i).name;
        disp(strcat(num2str(k), ' - ', anglist{k}));
        k = k + 1;
    end
end
disp(' ');
angnum = input('Input number: ');

fid = fopen(strcat('ang\', anglist{angnum}),'r');
angparams = textscan(fid, '%s', 16, 'delimiter', '\n');
numpoints = str2num(angparams{1}{16});
pointsdata = [];
for i = 1 : numpoints
    points = textscan(fid, '%s', 1, 'delimiter', '\n');
    pointsdata(i,:) = str2num(points{1}{1});
end
fclose(fid);