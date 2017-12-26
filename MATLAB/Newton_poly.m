function p = Newton_poly (x, datx, daty)
    
    p = 0;
    F = daty;
    PI = 1;
    n = length(datx);
    for i = 1:(n - 1)
        p = p + (PI .* F(1));
        for j = 1:i
            fprintf('old: F(i - j + 1) = %d\n', F(i - j + 1));
            F(i - j + 1) = (F(i - j + 1) - F(i - j + 2))./(datx(i - j + 1) - datx(i + 1));
            fprintf('new: F(i - j + 1) = %d\n', F(i - j + 1));
        end
        PI = PI .* (x - datx(i));
    end
    p = p + (PI .* F(1));
    return
end