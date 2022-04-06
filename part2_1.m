clear all;

ro = (3 - sqrt(5)) / 2;
a0 = -2;
b0 = 2;
a1 = ro * (b0 - a0) + a0;
b1 = b0 - ro * (b0 - a0);
eps = 10^(-2);

xaff=linspace(a0,b0,100); %printing the graph
for i=1:100
    yaff(i)=f(xaff(i));
end

while abs(b0 - a0) > eps
    if f(a1) <= f(b1)
        b0 = b1;
    end

    if f(a1) > f(b1)
        a0 = a1;
    end

    a1 = ro * (b0 - a0) + a0;
    b1 = b0 - ro * (b0 - a0);
end

[a0, b0]

figure(1);
hold on;
plot(xaff,yaff,'r');
plot(a0,f(a0),'o');

function y = f(x)
    y = x^4 + 4 * x^3 + 9 * x^2 + 6 * x + 6;
end
