function p = forward_difference( f, x0, h )
    p = (f(x0 + h) - f(x0))./h;
    return;
end

