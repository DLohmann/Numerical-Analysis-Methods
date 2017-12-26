function [ I ] = trap_int2( func,a,b,n )

fa=func(a);

fb=func(b);

XI0 = fa + fb;

h= (b-a)/n;

sum=0;

for i=1:n-1

x= a +h*i;

sum=sum + func(x);

end

I=(h/2)*(XI0 + 2*sum);

format long