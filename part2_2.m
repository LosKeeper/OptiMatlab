clear all;

xNewton = Newton(2, 10^ - 4, 4);
xSecant = Secant(2.1, 2, 10^ - 4, 4);

disp("with Newton method")
disp("x=")
disp(xNewton)
disp("With Secant method")
disp("x=")
disp(xSecant)

% print curve with minimum points
xaff=linspace(-4,4,500);
yaff=2*xaff.^4-5*xaff.^3+100*xaff.^2+30*xaff-75;
figure(1);
hold on;
plot(xaff,yaff,'b');
plot(xNewton,2*xNewton.^4-5*xNewton.^3+100*xNewton.^2+30*xNewton-75,'r*');
plot(xSecant,2*xSecant.^4-5*xSecant.^3+100*xSecant.^2+30*xSecant-75,'g*');

function xk = Newton(x0, eps, Nmax)
    % This function implements the Newton method applied to the function from the question
    xk = x0;
    gk = 8 * x0^3 - 15 * x0^2 + 200 * x0 + 30;
    hk = 24 * x0^2 - 30 * x0 + 200;
    n = 0;

    while abs(gk) >= eps && n <= Nmax && hk > 0
        xk = xk - (gk / hk);
        gk = 8 * xk^3 - 15 * xk^2 + 200 * xk + 30;
        hk = 24 * xk^2 - 30 * xk + 200;
        n = n + 1;
    end

end

function xk = Secant(x0, x1, eps, Nmax)
    % This function corresponds to the secant method applied to the function from the question
    xl = x0;
    xk = x1;
    gl = 8 * x0^3 - 15 * x0^2 + 200 * x0 + 30;
    gk = 8 * x1^3 - 15 * x1^2 + 200 * x1 + 30;
    n = 0;

    while abs(gk) >= eps && n <= Nmax && (gk - gl) / (xk - xl) > 0
        xr = xk - ((xk - xl) / (gk - gl)) * gk;
        xl = xk;
        xk = xr;
        gl = gk;
        gk = 8 * xk^3 - 15 * xk^2 + 200 * xk + 30;
        n = n + 1;
    end

end
