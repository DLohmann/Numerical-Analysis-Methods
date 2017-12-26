function w = Runge_Kutta4(  f, a, b, alpha, N )
    %Uses Runge Kutta 4th order method to solve for numerical solution for "y" based on 1st
    %order differential equation's initial value problem 
    %y'(t) = f(t, y(t)), y(a) = alpha
    %2nd order Runge Kutta is also called "modified Euler method"
    h = (b - a) / N;
    y = zeros(N, 1);
    t = zeros(N, 1);
    t(1) = a;
    y(1) = alpha;
    K1 = 0;
    K2 = 0;
    K3 = 0;
    K4 = 0;
    for i = 1:(N)
        t(i + 1) = t(i) + h; %t = a + (i * h);
        K1 = h * f(t(i), y(i));
        K2 = h * f(t(i) + (h/2), y(i) + (K1/2));
        K3 = h * f(t(i) + (h/2), y(i) + (K2/2));
        K4 = h * f(t(i + 1), y(i) + K3);
        
        
        y(i + 1) = y(i) + (K1 + (2*K2) + (2*K3) + K4)/6;
        %y(i + 1) = y(i) + (h * f(t(i))); %y(t + h) = y(t) + (h * f(t));
        
    end
    w = [t, y];
    return;

end

