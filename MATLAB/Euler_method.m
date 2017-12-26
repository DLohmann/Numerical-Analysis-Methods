function w = Euler_method( f, a, b, alpha, N )
    %Uses Euler's method to solve for numerical solution for "y" based on 1st
    %order differential equation's initial value problem 
    %y'(t) = f(t, y(t)), y(a) = alpha
    h = (b - a) / N;
    y = zeros(N, 1);
    t = zeros(N, 1);
    t(1) = a;
    y(1) = alpha;

    for i = 1:(N - 1)
        y(i + 1) = y(i) + (h * f(t(i), y(i))); %y(t + h) = y(t) + (h * f(t));
        t(i + 1) = t(i) + h; %t = a + (i * h);
    end
    w = [t, y];
    return;
end

