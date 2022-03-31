% Script pour obtenir les tracés des fonctions de la partie 3 
% On peut ainsi mieux visualiser les choses

%plot question 3.1

x1 = linspace(-2.5,3,200);

x2 = linspace(-2.5,3,200);

[X1,X2] = meshgrid(x1,x2);

Z = 1 + 2*X1.*exp(-(X1.*X1)-(X2.*X2));

figure
mesh(X1,X2,Z);

xlabel('x1');
ylabel('x2');
zlabel('f([x1,x2])');
grid ON

title('Tracé de la fonction de la question 3.1');



%plot de Rosenbrock pour 3.2

x1 = linspace(-0.3,2,200);

x2 = linspace(-0.3,4,200);

[X1,X2] = meshgrid(x1,x2);

Z = 100.*(X2-X1.*X1).*(X2-X1.*X1) + (1-X1).*(1-X1);

figure
mesh(X1,X2,Z);

xlabel('x1');
ylabel('x2');
zlabel('f([x1,x2])');
grid ON

title('Tracé de la fonction de Rosenbrock pour la question 3.2');




%plot pour 3.3

% avec Q = [2 0 ; 0 1 ]
x1 = linspace(-1.5,4,200);

x2 = linspace(0,6,200);

[X1,X2] = meshgrid(x1,x2);

Z = X1.*X1+X2.*X2.*0.5-3.*X1-3.*X2;

figure
mesh(X1,X2,Z);

xlabel('x1');
ylabel('x2');
zlabel('f([x1,x2])');
grid ON

title('Tracé de la fonction de la question 3.3 avec Q=[2 0; 0 1]');

% avec Q = [10 0 ; 0 1 ]
x1 = linspace(-2.5,3,200);

x2 = linspace(0,6,200);

[X1,X2] = meshgrid(x1,x2);

Z = 5.*X1.*X1+X2.*X2.*0.5-3.*X1-3.*X2;

figure
mesh(X1,X2,Z);

xlabel('x1');
ylabel('x2');
zlabel('f([x1,x2])');
grid ON

title('Tracé de la fonction de la question 3.3 avec Q=[10 0; 0 1]');




%plot question 3.4

x1 = linspace(-1,3,200);

x2 = linspace(-3,1,200);

[X1,X2] = meshgrid(x1,x2);

Z = (5.*X1.*X1+X2.*X2).*0.5+2.*X1.*X2-3.*X1-X2;

figure
mesh(X1,X2,Z);

xlabel('x1');
ylabel('x2');
zlabel('f([x1,x2])');
grid ON

title('Tracé de la fonction de la question 3.4');




%plot question 3.5

x1 = linspace(-4.25,1.25,200);

x2 = linspace(-2.25,3.25,200);

[X1,X2] = meshgrid(x1,x2);

Z = (X1.*X1+5.*X2.*X2)+2.*X1.*X2+2.*X1;

figure
mesh(X1,X2,Z);

xlabel('x1');
ylabel('x2');
zlabel('f([x1,x2])');
grid ON

title('Tracé de la fonction de la question 3.5');
