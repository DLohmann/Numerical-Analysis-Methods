function [ p ] = piecewise1( x )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
if (x < 2)
    p = 0;
    return
end

p = -x + 3;

return

