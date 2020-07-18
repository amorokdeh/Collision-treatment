%Autoren:
%Amr Okdeh
%Mohamad Alkasem

%Kollision Kugel mit Kugel (2D)
%m1 m2 Kugel-Masse
%v1 v2 die Geschwindigkeit vor dem Stoss
%v1nach, v2nach die Geschwindigkeit nach dem Stoss
%p1, p2 Impuls vor der Kollision
%p1nach, p2nach Impuls nach der Kollision

function f = kollisionCC()
    %circle 1
    r1 = 20;
    xc1 = 50;
    yc1 = 20;
    %center point
    o1 = [xc1; yc1];
    th = 0:pi/50:2*pi;
    circle1 = [r1 .* cos(th) + xc1;
              r1 .* sin(th) + yc1];
    %Masse 1
    m1 = 18;
    
    %circle 2
    r2 = 17;
    xc2 = - 80;
    yc2 = 25;
    %center point
    o2 = [xc2; yc2];
    th = 0:pi/50:2*pi;
    circle2 = [r2 .* cos(th) + xc2;
              r2 .* sin(th) + yc2];
    %Masse 2
    m2 = 15;
    
    %die Geschwindigkeit vor der Kollisiom
    v1 = [-2; 0];
    v2 = [ 1; 0];
    
    %Impuls vor der Kollision
    p1 = m1.* v1
    p2 = m2.* v2
    ImpulsVor = p1 + p2
    
    for t = 0:.01:7
        %Kollision-Erkennung
        collision = sqrt((xc1 - xc2).^2 + (yc1 - yc2).^2);
        %vor der Kollision
        if collision > r1 + r2
            
            %Bewegungen
            circle1 = circle1 + v1;
            xc1 = xc1 + v1(1) ;
            yc1 = yc1 + v1(2) ;
            o1 = o1 + v1;
        
            circle2 = circle2 + v2;
            xc2 = xc2 + v2(1) ;
            yc2 = yc2 + v2(2) ;
            o2 = o2 + v2;
            
        %nach der Kollision
        else
            %normalenvektor
            %n = (o1 - o2)./ norm(o1 - o2);
            
            %Die Geschwindigkeit nach der Kollision
            v1nach = v1 - (2.* m2./ (m1 + m2)).* dot(v1 - v2, o1 - o2)./(norm(o1 - o2)).^2 .* (o1 - o2);
            
            v2nach = v2 - (2.* m1./ (m1 + m2)).* dot(v2 - v1, o2 - o1)./(norm(o2 - o1)).^2 .* (o2 - o1);
            
            %Impuls nach der Kollision (= Impuls vor der Kollision)
            p1nach = m1.* v1nach;
            p2nach = m2.* v2nach;
            ImpulsNach = p1nach + p2nach
            
            v1 = v1nach;
            v2 = v2nach;
            
            %Bewegungen
            circle1 = circle1 + v1;
            xc1 = xc1 + v1(1) ;
            yc1 = yc1 + v1(2) ;
            o1 = o1 + v1;
            
            circle2 = circle2 + v2;
            xc2 = xc2 + v2(1) ;
            yc2 = yc2 + v2(2) ;
            o2 = o2 + v2;
            
        end
        
        %Kollision mit den Seiten (Erste Kugel)
        if xc1 - r1 <= -100
            v1(1) = - v1(1);
        end
        if yc1 + r1 >= 100
            v1(2) = - v1(2);
        end
        if xc1 + r1 >= 100
            v1(1) = - v1(1);
        end
        if yc1 - r1 <= -100
            v1(2) = - v1(2);
        end
        
        %Kollision mit den Seiten (Zweite Kugel)
        if xc2 - r2 <= -100
            v2(1) = - v2(1);
        end
        if yc2 + r2 >= 100
            v2(2) = - v2(2);
        end
        if xc2 + r2 >= 100
            v2(1) = - v2(1);
        end
        if yc2 - r2 <= -100
            v2(2) = - v2(2);
        end
        
        %plot
        plot(circle1(1,:), circle1(2,:), 'lineWidth', 1.5)
        hold on
        plot(circle2(1,:), circle2(2,:), 'lineWidth', 1.5)
        axis([-100 100 -100 100]);
        hold off
        drawnow
end