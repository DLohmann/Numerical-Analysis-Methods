function [x, X, Err] = newton_method (f, df, p0, TOL, N)
    %uses newton's method to find zeros of function f
    %f MUST BE a symbolic expression, so that it's derivative can be found
    %uses initial guess p0
    %calculates to within TOL
    %maximum number of iterations N
    %Returns:
    %X = array with each estimation 
    %

    i = 0;
    p = p0;
    plast = Inf;    % will store the value of the previous iteration
    while (abs(p - plast) >= TOL)
        plast = p;
        p = p - (f(p) / df(p));
        fprintf('p(%d) = %d\n', i, p);
        
        if (i > N)
               fprintf('error: could not calculate within %d in %d iterations\n', TOL, i)
               break;
        end
        
        i = i + 1;
    end
    x = p;

    return
end