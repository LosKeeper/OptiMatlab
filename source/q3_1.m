% question 3.1


alpha = 0.1;
epsilon = 1e-3;

syms x1 x2

f = 1 + 2*x1*exp(-((x1).^2)-((x2).^2));

gradf = round(gradient(f, [x1, x2]),5); % gradient de f

% les valeurs de x0 dans les 3 cas qu'on demande de traîter
x01=[-0.5 0.5]';
x02=[0.5 -0.5]';
x03=[1 1]';

% on les regroupe dans un tableau pour facilement faire une boucle for pour
% pouvoir afficher tous les résultats
x0 = [x01 x02 x03];

for (i = 1:3),
    
    tic;
    
    xk0 = x0(:,i); % on récupère la condition initiale x0
    
    xk = xk0;
    
    grad =subs(gradf,[x1,x2],xk');

    xk1= xk - alpha.*grad;
    
    norme = round(norm(grad),10);
    
    % application de l'algorithme de la méthode du gradient
    while(norme >= epsilon),
        xk = xk1;
        grad =subs(gradf,[x1,x2],xk');
        xk1= xk - alpha.*grad;
        norme = round(norm(grad),10);
    end
    
    timer = toc; 
    
    fprintf("\nEn prenant x0 = [%1.1f %1.1f]', le minimizer avec la méthode du gradient est [%f %f]'\n", xk0(1),xk0(2),xk1(1),xk1(2));
    fprintf("Le coût optimal vaudrait donc dans ce cas %f\n", subs(f, [x1 x2], xk1'));
    fprintf("Le temps de calcul est de %1.4f secondes\n\n", timer);
end
