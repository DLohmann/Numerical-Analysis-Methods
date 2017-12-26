function p = ThreePointOnSideDifference( f, x0, h )
%ThreePointOnSideDifference: Calculates 3 point one side difference
    p = ((-1 .* f(x0 + (2.*h))) + (4.*(f(x0 + h))) + (-3 .* f(x0)))./(2.*h);
    return;
end

