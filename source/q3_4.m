% question 3.4

x0 = [0 0]';

q = [-3 -1]';

syms x1 x2

Q = [5 2; 2 1];

[n, m] = size(Q);

gradf = Q*([x1 x2]')+q;

fprintf("\nPour k = 0 :\n\n");
xk = x0

gradfx = subs(gradf, [x1 x2], xk'); % gradient de f évalué en x

gk = gradfx

dk = -gk

alpha = -(gk'*dk)./(dk'*Q*dk)

fprintf("\nPour k = 1 :\n\n");

xk1 = xk + alpha.*dk

nbiter = 0; % compteur pour les itéartions de l'algorithme

norme = round(norm(gk),10);
    
% application de l'algorithme de la méthode conjugate gradient
while (norme > 0) && (nbiter < n-1),
    % d'après le cours, on converge dans le cas quadratique en n
    % itérations au plus
    
    xk = xk1;
    
    gradfx = subs(gradf, [x1 x2], xk');

    gk = gradfx
    
    beta = (gk'*Q*dk)./(dk'*Q*dk)

    dk = -gk + beta*dk

    alpha = -(gk'*dk)./(dk'*Q*dk)
    
    fprintf("\nPour k = %i :\n\n", (nbiter + 2));

    xk1 = xk + alpha.*dk
    
    norme = round(norm(gk),10);
    
    nbiter = nbiter + 1;
    
end
    
fprintf("Le minimizer avec la méthode conjugate gradient est [%2.2f %2.2f]':\n", xk1(1), xk1(2));
fprintf("Le coût optimal vaudrait donc dans ce cas %2.2f\n\n", (xk1'*Q*xk1./2 + q'*xk1));
