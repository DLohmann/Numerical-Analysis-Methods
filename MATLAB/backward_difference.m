function p = backward_difference( f, x0, h )
    p = -1 * (f(x0 - h) - f(x0))./h;
    return;
end
