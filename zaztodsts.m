% ������� ��������� ����� �� �������������� ��������� � ��������������.

function otv = zaztodsts(z,az,zv,azv)
% ������� ����� � ����������� � �������������� ����
ds = asin(cos(zv).*cos(z) + sin(zv).*sin(z).*cos(azv-az));
sints = sin(z).*sin(azv-az)./cos(ds);
costs = (sin(zv).*cos(z)-cos(zv).*sin(z).*cos(azv-az))./cos(ds);
% ������� �������� �� ������� [-pi/2;pi/2] � [0;2*pi]
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
otv = [ds, ts];