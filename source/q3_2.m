% question 3.2

% 2.

epsilon1 = 1e-3;
epsilon2 = 1e-4;

syms x1 x2 alpha

f = 100*(x2-x1*x1)*(x2-x1*x1) + (1-x1)*(1-x1);

gradf = round(gradient(f, [x1, x2]),5); % gradient de f

x0 = [-1 2]';

alpha0 = 0.1;

tic;

xk = x0;

alphak = alpha0;

gradfx =subs(gradf,[x1,x2],xk'); %gradient de f évalué en xk

xk1= xk - alphak.*gradfx;

% critère d'arrêt de la méthode Steepest descend
stopdescent = round(norm(xk1-xk),10)/norm(xk);

% application de l'algorithme de la méthode Steepest pour x
while(stopdescent >= epsilon1),
    
    xk = xk1;
    
    gradfx =subs(gradf,[x1,x2],xk');
    
    vect = xk - alpha*gradfx; % pour la fonction hk (slide 6 du cours)
    
    h = subs(f, [x1,x2], transpose(vect)); % valeur de la fonction hk 
        
    gradh = round(gradient(h, alpha),5); % gradient de la fonction hk
        
    hessh = round(hessian(h,alpha), 5); % matrice hessienne de hk
    
    gradha = subs(gradh, alpha, alphak); % gradient de hk évalué en alphak
        
    hessha = subs(hessh, alpha, alphak);% matrice hessienne de hk évaluée en alphak
        
    alphak1 = alphak - inv(hessha)*gradha;
    
    % critère d'arrêt de la méthode de Newton        
    stopalpha = abs(alphak1-alphak)/alphak;
    
    % application de l'algorithme de la méthode de Newton pour alpha
    while(stopalpha >= epsilon2),
            
        alphak = alphak1;
            
        gradh = round(gradient(h, alpha),5);
        
        hessh = round(hessian (h,alpha),5);
        
        gradha = subs(gradh, alpha, alphak);
        
        hessha = subs(hessh, alpha, alphak);
        
        alphak1 = alphak - inv(hessha)*gradha;
        
        stopalpha = abs(alphak1-alphak)/alphak;
            
    end
        
    xk1= xk - alphak1.*gradfx;
    % on peut enlever le ";" pour afficher le xk1
    % on peut ainsi voir la convergence en "zig-zag" pour la fonction de
    % Rosenbrock

    stopdescent = round(norm(xk1-xk),10)/norm(xk);
    
end

timer = toc;
            

fprintf("\nEn prenant x0 = [-1 2]' et alpha0 = 0.1, le minimizer avec la méthode de Steepest descent est [%f %f]'\n", xk1(1), xk1(2))
fprintf("Le coût optimal vaudrait donc dans ce cas %f\n\n", subs(f, [x1 x2], xk1'));
fprintf("Le temps de calcul avec epsilon1 = %1.0e est de %3.4f secondes\n\n", epsilon1, timer);
