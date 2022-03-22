clear all;

alpha=0.1;
eps=10^-3;

xk=[-0.5 0.5];
while norm(gradf(xk))>eps
    xk = xk-alpha*gradf(xk);
end
disp("with x0=[-0.5 0.5]")
disp("x=")
disp(xk)

xk=[0.5 -0.5];
while norm(gradf(xk))>eps
    xk = xk-alpha*gradf(xk);
end
disp("with x0=[0.5 -0.5]")
disp("x=")
disp(xk)

xk=[1 1];
while norm(gradf(xk))>eps
    xk = xk-alpha*gradf(xk);
end
disp("with x0=[1 1]")
disp("x=")
disp(xk)

function y = gradf(x)
y(1)=exp(-(x(1)^2)-(x(2)^2))*(2-4*x(1)^2);
y(2)=exp(-(x(1)^2)-(x(2)^2))*(-4*x(1)*x(2));
end

function y = f(x)
y=1+2*x(1)*exp(-(x(1)^2)-(x(2)^2));
end
