% question 3.5

x0 = [0 0]';

q = [2 0]';

syms x1 x2

Q = [2 2; 2 10];

[n, m] = size(Q);

gradf = Q*([x1 x2]')+q;

H0 = n*eye(2); % est une matrice réelle definie strictement positive

fprintf("\nAvec x0 = [-2 -7 ]' et H0 = [%i 0; 0 %i] :\n\n", n, n);

xk = x0;

gradfx = subs(gradf, [x1 x2], xk'); % gradient de f évalué en x

gk = gradfx;

Hk = H0;

nbiter = 0; % compteur pour les itéartions de l'algorithme

% application de l'algorithme de la méthode DFP
while (norm(gk) > (1e-2)) && (nbiter <n+1),
    % d'après le cours, on converge en n+1 itérations au plus
    
    dk = -Hk*gk;

    alpha = -(gk'*dk)/(dk'*Q*dk);

    xk1 = xk+alpha.*dk;

    deltax = xk1-xk;

    gradfx = subs(gradf, [x1 x2], xk1');

    gk1 = gradfx;

    deltag = gk1-gk;

    Hk = Hk + (deltax*(deltax'))./((deltax')*deltag)-([Hk deltag]*([Hk deltag]'))./((deltag')*Hk*deltag);
    
    gk = gk1;
    
    xk = xk1;
    
    nbiter = nbiter + 1; 

end

fprintf("Le minimizer avec la méthode DFP est [%2.2f %2.2f]':\n", xk1(1), xk1(2));
fprintf("Le coût optimal vaudrait donc dans ce cas %1.3f\n\n", (xk1'*Q*xk1./2 + q'*xk1));
