% question 3.3

%2.

epsilon = 1e-5;

x0 = [-2 -7]';

q = [-3 -3]';


fprintf("\nEn prenant x0 = [-2 -7 ]' et q = [-3 -3] on a :\n");
syms x1 x2

% les valeurs de Q dans les 2 cas qu'on demande de traîter
Q1 = [2 0; 0 1];
Q2 = [10 0; 0 1];

% on les regroupe dans un tableau pour facilement faire une boucle for pour
% pouvoir afficher tous les résultats
Q0 = [Q1 Q2];

for (i = 1:2),
    
    Q = Q0(:, (2*i-1):(2*i)); % on récupère la matrice Q qu'on veut traîter
    
    fprintf("\n\nPour Q = [%i 0; 0 1]\n\n", Q(1,1));

    [n, m] = size(Q);

    gradf = Q*([x1 x2]')+q; % gradient de f

    % ***** Pour la méthode Steepest descent
    
    tic;

    xk = x0;

    gradfx = subs(gradf, [x1 x2], xk'); % gradient de f évalué en x

    alpha = (gradfx'*gradfx)./(gradfx'*Q*gradfx);

    xk1 = xk - alpha.*gradfx;

    norme = round(norm(gradfx),10);
    
    % application de l'algorithme de la méthode Steepest descent
    while (norme >= epsilon),
    
        xk = xk1;
    
        gradfx = subs(gradf, [x1 x2], xk');

        alpha = (gradfx'*gradfx)/(gradfx'*Q*gradfx);

        xk1 = xk - alpha.*gradfx;

        norme = round(norm(gradfx),10);
    
    end
    
    timerS = toc;

    fprintf("Le minimizer avec la méthode Steepest descent est [%2.2f %2.2f]':\n", xk1(1), xk1(2));
    fprintf("Le coût optimal vaudrait donc dans ce cas %f\n", (xk1'*Q*xk1./2 + q'*xk1));
    fprintf("Le temps de calcul est de %1.4f secondes\n\n", timerS);

    % ***** Pour la méthode conjugate gradient
    
    tic;

    xk = x0;

    gradfx = subs(gradf, [x1 x2], xk'); % gradient de f évalué en x

    gk = gradfx;

    dk = -gk;

    alpha = -(gk'*dk)./(dk'*Q*dk);

    xk1 = xk + alpha.*dk;

    nbiter = 0; % compteur pour les itéartions de l'algorithme

    norme = round(norm(gk),10);
    
    % application de l'algorithme de la méthode conjugate gradient
    while (norme > 0) && (nbiter < n-1),
        % d'après le cours, on converge dans le cas quadratique en n
        % itérations au plus
    
        xk = xk1;
    
        gradfx = subs(gradf, [x1 x2], xk');

        gk = gradfx;
    
        betak = (gk'*Q*dk)./(dk'*Q*dk);

        dk = -gk + betak*dk;

        alpha = -(gk'*dk)./(dk'*Q*dk);

        xk1 = xk + alpha.*dk;
    
        norme = round(norm(gk),10);
    
        nbiter = nbiter + 1;
    
    end
    
    timerC = toc;
    
    fprintf("Le minimizer avec la méthode conjugate gradient est [%2.2f %2.2f]':\n", xk1(1), xk1(2));
    fprintf("Le coût optimal vaudrait donc dans ce cas %f\n", (xk1'*Q*xk1./2 + q'*xk1));
    fprintf("Le temps de calcul est de %1.4f secondes\n\n", timerC);

    
end
