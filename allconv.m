load larec
larec = larec(:,4:7);
alfa = 20 /180*pi;
%часовой угол, склонение, азимут, угол места
t = larec(:,1);
v = num2str(t);
t = str2num(v(:,end-1:end))/180*pi/60/60+str2num(v(:,end-3:end-2))/180*pi/60+str2num(v(:,1:end-4))/180*pi;
d = larec(:,2); 
v = num2str(d);
d = str2num(v(:,end-1:end))/180*pi/60/60+str2num(v(:,end-3:end-2))/180*pi/60+str2num(v(:,1:end-4))/180*pi;
az = larec(:,3); 
v = num2str(az);
az = str2num(v(:,end-1:end))/180*pi/60/60+str2num(v(:,end-3:end-2))/180*pi/60+str2num(v(:,1:end-4))/180*pi;
um = larec(:,4); 
v = num2str(um);
um = str2num(v(:,end-1:end))/180*pi/60/60+str2num(v(:,end-3:end-2))/180*pi/60+str2num(v(:,1:end-4))/180*pi;
 
%переход к зенитному расстоянию
z = pi/2-um;
%широта москвы
fi = 55.949/180*pi;

%переход к экваториальным координатам от азимутальных
d1 = asin(sin(fi).*cos(z) - cos(fi).*sin(z).*cos(az));
sint = sin(z).*sin(az)./cos(d1);
cost = (cos(fi).*cos(z)+sin(fi).*sin(z).*cos(az))./cos(d1);
% перевод арксинус из отрезка [-pi/2;pi/2] в [0;2*pi]
for i = 1:length(sint)
    if sint(i)>=0
        if cost(i)>=0
            t1(i) = asin(sint(i));
        else
            t1(i) = pi-asin(sint(i));
        end  
    else
        if cost(i)>=0
            t1(i) = 2*pi+asin(sint(i));
        else
            t1(i) = pi-asin(sint(i));
        end  
    end
end

%рисование траектории и всего
figure
axis equal
hold on
plot(sin(0:0.1:2.1*pi),cos(0:0.1:2.1*pi),'k')
plot(sin(0:0.1:2.1*pi)*20/90,cos(0:0.1:2.1*pi)*20/90,'k')
r = (z/pi*180)/90;
plot(0,(90-fi/pi*180)/90,'b*')
plot(-r.*sin(pi-az), r.*cos(pi-az), 'r')
plot(-r(1).*sin(pi-az(1)), r(1).*cos(pi-az(1)), 'rx')

text(-0.05,0.9,'N','FontSize',18)
text(-0.05,-0.9,'S','FontSize',18)
text(0.85,0,'E','FontSize',18)
text(-0.95,0,'W','FontSize',18)
% text(0.90,-0.8,{'+ - start', 'o - end'},'FontSize',12)
plot(sin(0:pi/6:2.1*pi),cos(0:pi/6:2.1*pi),'k*')
plot(0,0,'k*')

%нахождение кульминации траектории
[zmin,nzmin] = min(z);
azk = az(nzmin);
zk = zmin;
r = (zk/pi*180)/90;
plot(-r.*sin(pi-azk), r.*cos(pi-azk), 'r+')

%нахождение исполнительной оси
zv = alfa-zk;
azv = azk+pi;
r = (zv/pi*180)/90;
plot(-r.*sin(pi-azv), r.*cos(pi-azv), 'b+')

%переход к координатам в исполнительных осях
ds = asin(cos(zv).*cos(z) + sin(zv).*sin(z).*cos(azv-az));
sints = sin(z).*sin(azv-az)./cos(ds);
costs = (sin(zv).*cos(z)-cos(zv).*sin(z).*cos(azv-az))./cos(ds);
% перевод арксинус из отрезка [-pi/2;pi/2] в [0;2*pi]
ts = ds*0;
for i = 1:length(sints)
    if sints(i)>=0
        if costs(i)>=0
            ts(i) = asin(sints(i));
        else
            ts(i) = pi-asin(sints(i));
        end  
    else
        if costs(i)>=0
            ts(i) = 2*pi+asin(sints(i));
        else
            ts(i) = pi-asin(sints(i));
        end  
    end
end

figure; 
subplot(2,2,1); plot(d/pi*180); title('Sklonenie')
subplot(2,2,2); plot((d(2:end)-d(1:end-1))/pi*180); title('Skorost po skloneniu')
subplot(2,2,3); plot(t/pi*180); title('Chasovoi ugol')
subplot(2,2,4); plot((t(2:end)-t(1:end-1))/pi*180.*(abs(t(2:end)-t(1:end-1))<(1.9*pi))); title('Skorost po chasovomu uglu')
figure; 
subplot(2,2,1); plot(az/pi*180); title('Azimut')
subplot(2,2,2); plot((az(2:end)-az(1:end-1))/pi*180); title('Skorost po azimutu')
subplot(2,2,3); plot(z/pi*180); title('Zenitnii ugol')
subplot(2,2,4); plot((z(2:end)-z(1:end-1))/pi*180); title('Skorost po zenitnomu uglu')
figure; 
subplot(2,2,1); plot(ds/pi*180); title('Ispolnitelnoe sklonenie')
subplot(2,2,2); plot((ds(2:end)-ds(1:end-1))/pi*180); title('Skorost po ispolnitelnomu skloneniu')
subplot(2,2,3); plot(ts/pi*180); title('Ispolnitelnii chasovoi ugol')
subplot(2,2,4); plot((ts(2:end)-ts(1:end-1))/pi*180.*(abs(ts(2:end)-ts(1:end-1))<(1.9*pi))); title('Skorost po ispolnitelnomu chasovomu uglu')