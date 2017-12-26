function p = center_difference( f, x0, h )
    %calculates 3 point center difference
    p = (f(x0 + h) - f(x0 - h))./(2 .* h);
    return;
end

