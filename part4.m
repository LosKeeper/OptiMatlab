clear all;

% Q4.2
% Plot the curve

figure (1);
f1 = @(x,y) 20 - x.^2 - 4*y.^2 ;
fimplicit(f1,[-10 5],'r')
hold on;
f2 = @(x,y) x.^4 - 10 - y;
fimplicit(f2,'b')