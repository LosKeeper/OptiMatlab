% Script pour obtenir les tracés des fonctions de la partie 2 
% On peut ainsi mieux visualiser les choses

% Pour la question 2.1

% On peut notamment constater graphiquement que cette fonction est bien
% unimodale et que l'on peut donc appliquer la méthode Golden section

x = linspace(-2,2,300);

y = x.*x.*x.*x+4*x.*x.*x+9*x.*x+6*x+6;

figure
plot(x,y);

xlabel("x");
ylabel("f(x)");
grid ON

title("Courbe de f de la question 2.1");



% Pour la question 2.2

x = linspace(-3,3,300);

y = 2*x.*x.*x.*x-5*x.*x.*x+100*x.*x+30*x-75;

figure
plot(x,y);

xlabel("x");
ylabel("f(x)");
grid ON

title("Courbe de f de la question 2.2");