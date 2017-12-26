function p = bisection_method (lowerbound, upperbound, func, TOLerance)
    %This function uses the bisection method to approximate the root of a
    %function between it's lowerbound and upper bound to within a specified
    %tolerance. This assumes there is only one root in the boundary. The
    %function also assumes that "a" and "b" have different signs, and are
    %on opposite sides of the root
 if (sign(func(lowerbound)) == sign(func(upperbound)))
     fprintf ('Error: bounds upper and lower bounds of bisection method \ncannot have same sign, but the function values of %d and %d do, \nbecause they are %d and %d, respectively', lowerbound, upperbound, func(lowerbound), func(upperbound));
     return
 end
 
 disp(' Log of how the bisection method found the numerical solution:');
 a = lowerbound;
 b = upperbound;
 x = a + (b-a)/2;
 N = 1;
 while (TOLerance < abs(func(x)))
     fprintf('Iteration: %d, ', N);
     N = N + 1;
     if (sign(func(a)) == sign(func(x)))
         a = x;
     else
         b = x;
     end
     x = a + (b-a)/2;
     fprintf('a=%d, b=%d, x=%d\n', a, b, x);
     %disp('a=', a, ', b=', b, ', x=', x)
 end
 p = x;
 return