% question 2.1

% la fonction mise en jeu dans ce problème est polynomiale :
% on va se servir des polynomes MATLAB

f = [1 4 9 6 6];

epsilon = 1e-2;

rho = (3 - sqrt(5))/2; 
% (démonstration de la valeur de rho slide 7 du cours)

% valeurs de l'intervalle sur lequel on étudie la fonction
a0 = -2;
b0 = 2;

etendue = b0-a0;

%application de l'algorithme de la méthode Golden section 
while(etendue > epsilon),
    
    a1 = rho*etendue + a0;

    b1 = b0 - rho*etendue;
    
    if(polyval(f, b1) > polyval(f, a1)),
        b0 = b1;
    else
        % on considère arbitrairement le cas f(b1) = f(b2)  également ici
        a0 = a1;
    end
    
    etendue = b0-a0;

end

fprintf("\nLe minimizer se trouve dans l'intervalle [%f %f]\n\n", a0, b0);