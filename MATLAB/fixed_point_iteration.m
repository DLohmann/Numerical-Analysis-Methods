function  [x, X, Err] = fixed_point_iteration( g, p0, TOL, N)
%Uses fixed point iteration to find zeros of a function f to within a
%specified tolerance TOL, with initial guess p0
    if nargin <= 3
        N = 1000;
        if nargin <= 2
            TOL = 0.01;
        end
    end
    X = zeros (1, 10);
    Err = zeros(1, 10)
    count = 1;
    plast = p0;
    p = g(p0);
    while (abs(p - plast) >= TOL) % computes 1 iteration ahead 'g(p)' before stopping
        if (count <= 10)
            Err(count) = abs(p - plast);
            X(count) = p;
        end
        plast = p;
        p = g(p);
        
        fprintf('p%d = %d\n', count, p);
        count = count + 1;
        if (count > N)
               fprintf('error: could not calculate within %d in %d iterations\n', TOL, count)
               break;
        end
    end
    p = g(p); % since algorithm computes 1 iteration ahead before stopping (when finding error in while loop), must finish that iteration
    fprintf('p%d = %d\n', count, p);

    x = p;
    return
end

