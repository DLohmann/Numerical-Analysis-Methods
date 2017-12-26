function p = FivePointOneSideDifference( f, x0, h )
%Calculates five point one side difference
    p = ( (-25 .* f(x0)) + (48 .* f(x0 + h)) + (-36 .* f(x0 + (2.*h))) + (16 .* f(x0 + (3.*h))) + (-3 .* f(x0 + (4 .* h))) ) ./ (12 .* h);
    return;
end

