function I = trap_int( f, a, b, n )
%Uses trapezoid method to approximate integral of "f" for "a" to "b" using
%"n" sub-intervals to approximate
    I = 0;
    h = (b - a) / n;
    for i = (a + h):h:(b - h)
        I = I + f(i);
        %fprintf('i = %d, I = %d\n', i, I);
    end
   
    I = I * 2;
    %fprintf('I = %d\n', I);
    I = I + f(a) + f(b);
    %fprintf('I = %d\n', I');
    I = I * h / 2;
    format long;
    return;
end

