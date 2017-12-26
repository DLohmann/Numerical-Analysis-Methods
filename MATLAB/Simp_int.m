function I = Simp_int( f, a, b, n )
%Uses Simpson method to approximate the integral of the function "f" for "a" to "b" using "n" sub
%intervals
    h = (b - a) ./ n;
    I = 0;
    for i = a:h:(b-h)
        I = I + f(i) + (4*f(i + (h/2))) + f(i + h);
        %fprintf('I = %d, i = %d\n', I, i);
    end
    
    %{
    for i = (a + (2*h)):h:(b - (2*h))
        I = I + f(i);
        fprintf('I = %d, i = %d\n', I, i);
    end
    I = I * 6;
    fprintf('I = %d\n', I);
    I = I + f(a) + (5*f(a + h)) + (5*f(b - h)) + f(b);
    fprintf('I = %d\n', I);
    %}
    I = I .* h ./ 6;
    format long;
    return;
end

