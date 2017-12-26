function w = Runge_Kutta2(  f, a, b, alpha, N )
    %Uses Runge Kutta 2nd order method to solve for numerical solution for "y" based on 1st
    %order differential equation's initial value problem 
    %y'(t) = f(t, y(t)), y(a) = alpha
    h = (b - a) / N;
    y = zeros(N, 1);
    t = zeros(N, 1);
    t(1) = a;
    y(1) = alpha;

    for i = 1:(N)
        t(i + 1) = t(i) + h; %t = a + (i * h);
        K1 = f(t(i), y(i));
        K2 = f(t(i + 1), y(i) + (h*K1));
        
        y(i + 1) = y(i) + h*(K1 + K2)/2;
        
    end
    w = [t, y];
    return;

end

