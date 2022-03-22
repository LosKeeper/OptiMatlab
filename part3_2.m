clear all;

alpha=0.1;
alphap=0;
x0=[-1 2];
xk = steepest_descent(x0,10^-3,100);

while norm(xk-x0)/norm(x0)<10^-3
    while abs(alphap-alpha)/alpha<10^-4

    end
    x0=xk;
    xk = steepest_descent(x0,10^-3,100);
end


function y = f(x)
y=100*(x(2)-x(1)^2)^2+(1-x(1))^2;
end

function y = gradf(x)
y(1)=-400*x(1)*(x(2)-x(1)^2)-2*(1-x(1));
y(2)=200*(x(2)-x(1)^2);
end

function xk = steepest_descent(x0,eps,Nmax)
    xk=x0;
    gk=gradf(x0);
    n=0;
    while abs(gk)>=eps && n<=Nmax
        d=-gradf(xk);
        alpha=arguments(min(f(xk+alpha*d)));
        xk=xk+alpha*d;
        gk=gradf(xk);
        n=n+1;
    end
end
