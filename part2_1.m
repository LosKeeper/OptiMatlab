% Q1
clear all;

ro = 1/3;
a0 = -2;
b0 = 2;
a1 = ro*(b0-a0)+a0;
b1 = b0 - ro*(b0-a0);
eps = 10^(-2);
i=0;

while abs(b0-a0)>eps
    i=i+1;
    if f(a1)<=f(b1)
        b0=b1;
    end
    if f(a1)>f(b1)
        a0=a1;
    end
    a1 = ro*(b0-a0)+a0;
    b1 = b0 - ro*(b0-a0);
end

[a0,b0]

function y = f(x)
    y = x^4+4*x^3+9*x^2+6*x+6;
end

