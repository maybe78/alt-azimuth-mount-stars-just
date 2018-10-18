% Генерация по данным вектора времени, вектора угла места и вектора скорости.

time = pointsdata(:,1)-pointsdata(1,1);
ang = pointsdata(:,3)/pi*180;
vang = (ang(2:end)-ang(1:end-1))./(time(2:end)-time(1:end-1));
vang(end+1)=vang(end);