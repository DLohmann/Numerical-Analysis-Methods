function p = FivePointCenterDifference( f, x0, h )
%Calculates Five point centered difference
%   Detailed explanation goes here
    p = ((-1 .* f(x0 + (2 .* h))) + (8.*f(x0 + h)) - (8.*f(x0 - h)) + f(x0 - (2*h)) ) ./ (12 .* h);
    return;
end

