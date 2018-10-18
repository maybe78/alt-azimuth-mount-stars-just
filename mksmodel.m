R = 6371000; %˜˜˜˜˜˜ ˜˜˜˜˜
h = 350000; %˜˜˜˜˜˜ ˜˜˜
omega=2*pi/(91.44*60); %˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜
T = 91.44*60; %˜˜˜˜˜˜
alfa = acos(R/(R+h));
t1 = (pi-2*alfa)/2/2/pi*T; %˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ 
t2 = (pi-(pi-2*alfa)/2)/2/pi*T; %˜˜˜˜˜ ˜˜˜˜˜˜
t=[1.01*t1:0.99*t2]; %˜˜˜˜˜˜ ˜˜˜˜˜˜˜
x1 = (R + h)*sin(omega*t)-R; %˜˜˜˜˜˜˜˜˜ ˜˜ ˜
y1 = (R + h)*cos(omega*t); %˜˜˜˜˜˜˜˜˜˜ ˜˜ ˜
beta = atan(x1./y1); %˜˜˜˜ ˜˜ ˜˜˜˜˜˜
%˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜ ˜˜˜˜ ˜˜˜˜˜
um = abs(beta)/pi*180; 
az = um*0;
[NaN,n]=max(um);
az(1:n)=180;


um=um/180*pi;
az=az/180*pi;
alfa = 20 /180*pi;
%˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜
z = pi/2-um;
%˜˜˜˜˜˜ ˜˜˜˜˜˜
fi = 55.949/180*pi;

%˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜
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

%˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜
zv = alfa;
azv = pi/2;
r = (zv/pi*180)/90;
plot(-r.*sin(pi-azv), r.*cos(pi-azv), 'b+')

%˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜
ds = asin(cos(zv).*cos(z) + sin(zv).*sin(z).*cos(azv-az));
sints = sin(z).*sin(azv-az)./cos(ds);
costs = (sin(zv).*cos(z)-cos(zv).*sin(z).*cos(azv-az))./cos(ds);
% ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜ [-pi/2;pi/2] ˜ [0;2*pi]
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

%˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜
d = asin(sin(fi).*cos(z) - cos(fi).*sin(z).*cos(az));
sint = sin(z).*sin(az)./cos(d);
cost = (cos(fi).*cos(z)+sin(fi).*sin(z).*cos(az))./cos(d);
% ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜ [-pi/2;pi/2] ˜ [0;2*pi]
t = d*0;
for i = 1:length(sint)
    if sint(i)>=0
        if cost(i)>=0
            t(i) = asin(sint(i));
        else
            t(i) = pi-asin(sint(i));
        end  
    else
        if cost(i)>=0
            t(i) = 2*pi+asin(sint(i));
        else
            t(i) = pi-asin(sint(i));
        end  
    end
end

figure; 
subplot(2,3,1); plot(d/pi*180); title('Sklonenie')
v = (d(2:end)-d(1:end-1))/pi*180;
subplot(2,3,2); plot(v); title('Skorost po skloneniu')
a = v(2:end)-v(1:end-1);
subplot(2,3,3); plot(a); title('Uskorenie po skloneniu')
subplot(2,3,4); plot(t/pi*180); title('Chasovoi ugol')
v = (t(2:end)-t(1:end-1))/pi*180.*(abs(t(2:end)-t(1:end-1))<(1.9*pi));
subplot(2,3,5); plot(v); title('Skorost po chasovomu uglu')
a = v(2:end)-v(1:end-1);
subplot(2,3,6); plot(a); title('Uskorenie po chasovomu uglu')

figure; 
subplot(2,3,1); plot(az/pi*180); title('Azimut')
v = (az(2:end)-az(1:end-1))/pi*180;
subplot(2,3,2); plot(v); title('Skorost po azimutu')
a = v(2:end)-v(1:end-1);
subplot(2,3,3); plot(a); title('Uskorenie po azimutu')

subplot(2,3,4); plot(z/pi*180); title('Zenitnii ugol')
v = (z(2:end)-z(1:end-1))/pi*180;
subplot(2,3,5); plot(v); title('Skorost po zenitnomu uglu')
a = v(2:end)-v(1:end-1);
subplot(2,3,6); plot(a); title('Uskorenie po zenitnomu uglu')

figure; 
subplot(2,3,1); plot(ds/pi*180); title('Ispolnitelnoe sklonenie')
v = (ds(2:end)-ds(1:end-1))/pi*180;
subplot(2,3,2); plot(v); title('Skorost po ispolnitelnomu skloneniu')
a = v(2:end)-v(1:end-1);
subplot(2,3,3); plot(a); title('Uskorenie po ispolnitelnomu skloneniu')

ts(n+1:end) = ts(n+1:end) + 2*pi;
subplot(2,3,4); plot(ts/pi*180); title('Ispolnitelnii chasovoi ugol')
v = (ts(2:end)-ts(1:end-1))/pi*180;
subplot(2,3,5); plot(v); title('Skorost po ispolnitelnomu chasovomu uglu')
a = v(2:end)-v(1:end-1);
subplot(2,3,6); plot(a); title('Uskorenie po ispolnitelnomu chasovomu uglu')
