% Мой метод юстировки по звездам.

% Задаем положение звезд на небе З, смещенное положение исполнительных
% осей. Вносим ошибки в положение исполнительных осей И. Переводим
% положение звезд в исполнительную систему. Убираем звезды около нулевого
% меридиана. Вносим ошибки определения положения звезд в исполнительных
% осях Зи. Ищем углы поворота системы координат минимизируя норму вектора
% невязки (Зи - Ф(З, имполнительные углы)), где Ф - функция перевода в
% систему исполнительных осей.

% for i=1:100
    % отклонение исполнительной оси от кульминации для пролетов в близзенитной
    % области
    alfa = 20/180*pi;
    % количество звезд для калибровки
    n = 3;
    % ошибки определения положения звезд в исполнительных осях
    astroangerr = 10/60; % в градусах
    % угловые ошибки исполнительных осей
    vangerr = 2; % в градусах
   
    
    % равномерное распределение точек по полусфере
    z = acos(1 - rand(n,1));
    az = 2*pi*rand(n,1);

    % случайное положение кульминации траектории
    azk = 2*pi*rand;
    zk = acos(1 - rand*(1-cos(alfa*pi/180)));

    % положение исполнительных осей
    zv = alfa-zk;
    azv = azk+pi;

    if 1
        figure
        axis equal
        hold on
        plot(sin(0:0.1:2.1*pi),cos(0:0.1:2.1*pi),'k')
        plot(sin(0:0.1:2.1*pi)*20/90,cos(0:0.1:2.1*pi)*20/90,'k')
        plot(0,0,'k+')
        r = (zk/pi*180)/90;
        plot(-r.*sin(pi-azk), r.*cos(pi-azk), 'r+')
        r = (zv/pi*180)/90;
        plot(-r.*sin(pi-azv), r.*cos(pi-azv), 'b+')
        r = (z/pi*180)/90;
        plot(-r.*sin(pi-az), r.*cos(pi-az), '.')
    end
    
    % вносим угловые ошибки исполнительных осей
    zv_real = zv;
    azv_real = azv;
    zv_meas = zv + vangerr/180*pi*(2*rand-1);
    azv_meas = azv + vangerr/180*pi*(2*rand-1);

    % перевод звезд к координатам в исполнительных осях
    otv = zaztodsts(z, az, zv_real, azv_real);
    ds = otv(:,1);
    ts = otv(:,2);
    
    % если звезда лежит вблизи нулевого меридиана строительных осей, то все
    % косячит, убираем такие звезды
    f = find(~((ts<2*vangerr/180*pi)+((2*pi-ts)<2*vangerr/180*pi)));
    ts = ts(f);
    ds = ds(f);
    z = z(f);
    az = az(f);
    
    % вносим ошибки определения положения звезд в исполнительных осях
    ds_real = ds;
    ts_real = ts;
    ds_meas = ds + astroangerr/180*pi*(2*rand(length(ds),1)-1);
    ts_meas = ts + astroangerr/180*pi*(2*rand(length(ts),1)-1);

    options = optimset('Display', 'off');
    [x, n] = lsqcurvefit(@(x,xdata)zaztodsts(xdata(:,1),xdata(:,2),x(:,1),x(:,2)),[zv_meas,azv_meas],[z,az],[ds_meas,ts_meas],[zv_meas-vangerr/180*pi,azv_meas-vangerr/180*pi],[zv_meas+vangerr/180*pi,azv_meas+vangerr/180*pi], options);
    zv_found = x(1);
    azv_found = x(2);

    if 1
        figure;
        axis equal
        plot(zv_meas/pi*180, azv_meas/pi*180, 'b+', zv_real/pi*180, azv_real/pi*180, 'r+', zv_found/pi*180, azv_found/pi*180,'bo')
    end
    a(i,:) = [abs((azv_real-azv_found)/pi*180*60), abs((zv_real-zv_found)/pi*180*60)];
% end