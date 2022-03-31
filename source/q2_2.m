% question 2.2

% la fonction mise en jeu dans ce problème est polynomiale :
% on va se servir des polynomes MATLAB

f = [2 -5 100 30 -75];
fprime = polyder(f); % dérivée de f

epsilon = 1e-4;

% ***** 1.Méthode de Newton

fsecN = polyder(fprime); % dérivée seconde de f

x0 = 2;

xk = x0;

rapport = polyval(fprime, xk)/polyval(fsecN, xk);

xk1 = xk-rapport;

% application de l'algorithme de la méthode de Newton
while(abs(polyval(fprime, xk1)) > epsilon),
    
    rapport = polyval(fprime, xk1)/polyval(fsecN, xk1);
    
    xk = xk1;
    
    xk1 = xk - rapport;
end

fprintf("\nEn prenant x0 = 2, le minimizer avec la méthode de Newton est %f\n", xk1);

fprintf("Le coût optimal vaudrait donc dans ce cas %f\n\n", polyval(f, xk1));


% ***** 2.Méthode Secant

x0 = 2.1;
x1 = 2;


% approximation de la dérivée seconde de f (avec la méthode Secant) évaluée
% en x1
fsecS = (polyval(fprime,x1)-polyval(fprime,x0))/(x1-x0);

xk = x1;

xk1 = xk - polyval(fprime, xk)/fsecS;

% application de l'algorithme de la méthode Secant
while(abs(polyval(fprime, xk)) > epsilon),
    
    % approximation de la dérivée seconde de f (avec la méthode Secant) 
    % évaluée en xk
    fsecS = (polyval(fprime,xk1)-polyval(fprime,xk))/(xk1-xk);
    
    xk = xk1;
    
    xk1 = xk - polyval(fprime, xk)/fsecS;
end
   
fprintf("En prenant x0 = 2.1 et x1 = 2, le minimizer avec la méthode Secant est %f\n", xk1);

fprintf("Le coût optimal vaudrait donc dans ce cas %f\n\n", polyval(f, xk1));
