function x = secant_method (f, p0, p1, TOL, N)
    %uses secant method to find zeros of function f
    %uses initial guess p0
    %calculates to within TOL
    %maximum number of iterations N

    i = 1;
    pn1 = p0;
    pn = p1;
    while (abs(f(pn)) >= TOL)
         temp = pn;
         pn = pn - f(pn)*((pn1 - pn)/(f(pn1) - f(pn)));
         pn1 = temp;
         if (i > N)
               fprintf('error: could not calculate within %d in %d iterations\n', TOL, i)
               return
         end
         fprintf('p(%d) = %d\n', i, pn)
         i = i + 1;
    end
    x = pn;
    return
    
end