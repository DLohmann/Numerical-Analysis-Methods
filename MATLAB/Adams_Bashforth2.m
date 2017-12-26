function w = Adams_Bashforth2(  f, a, b, Y0, Y1, N )
    %Can also take parameters in format (  f, a, b, alpha, N ) and will use
    %2nd order Runge Kutta with 1 iteration to approximate Y1
    %Uses Adams-Bashforth 2 step method to solve for numerical solution for "y" based on 1st
    %order differential equation's initial value problem 
    %y'(t) = f(t, y(t)), y(a) = alpha
    
    if (nargin == 5)
        N = Y1;
        h = (b - a) / N;
        q = Runge_Kutta2 (f, a, a+h, Y0, 1);
        Y1 = q(3);
    else
        h = (b - a) / N;
    end %else assume nargin is 6
    
    y = zeros(N, 1);
    t = zeros(N, 1);
    t(1) = a;
    y(1) = Y0;
    t(2) = a + h;
    y(2) = Y1;
    
    for i = 2:(N)
        t(i + 1) = t(i) + h; %t = a + (i * h);
        y(i + 1) = y(i) + h*(3*f(t(i), y(i)) - f(t(i - 1), y(i - 1)))/2;
    end
    w = [t, y];
    return;

end

