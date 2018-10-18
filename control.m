type = 'sin';
switch type
    case 'step'
        %подать 10 000 000
        tic
        while toc<2
            %считываем значение
        end
        %подать 50 000 000
        tic
        while toc<4
            %считываем значение
        end        
    case 'sin'
        %максимальная скорость 4 градуса в сек
        tic
        while toc<20
            t = toc;
            %подать 20*10^6*sin(omega*t) + 30*10^6
            %считываем значение
        end
end