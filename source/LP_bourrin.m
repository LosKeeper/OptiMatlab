function [f,x,B] = LP_bourrin(A,b,c)
% question 1.1

[n m] = size(A); % dimensions de A

% recherche de solution avec differents B

V = [1:m]; % vecteur lignes des indices 
L = nchoosek(V, n);
% L est la matrice donnant les combinaisons possibles de colonnes pour B

% on initialise un vecteur tampon pour x
Xtmp = zeros(m, 1);

f = Inf; % on initialise le coût minimal 

% on initialise x et B comme étant une matrice vide pour renvoyer quelque
% chose dans le cas où il n'y a pas de BFS dutout (l'utilisateur s'en
% rendra ainsi compte)
x = [];
B = [];

% variable valant 1 si une solution basique est faisable, 0 sinon
indicateurF = 1;

% on va tester toutes les solutions basiques pour chaque base
% on va considérer les solutions faisables, et on va regarder parmis elles
% laquelle est la solution optimale

for (i = 1:nchoosek(m,n)),
    
    indices = L(i , :); %on choisit les colonnes pour une base
    Btmp = A(:, indices); %on crée une base
    
    % création de Xtmp (BFS) si il existe pour la base calculée
    
    % détermination de xb si possible
    if (abs(det(Btmp)) >= (1e-8)), % on vérifie que Btmp est inversible
        % (on ne teste pas si le determinant vaut exactement 0, mais plutôt
        % si il est très proche de 0, car avec les calculs MATLAB avec la
        % fonction det, il pourrait y avoir des approximations qui
        % erroneraient le résultat)
        
        xb= (inv(Btmp))*b;
        
        %on vérifie d'abord que la solution est faisable
        k=1;
        while (k <= n) && (indicateurF==1),
            if (xb(k) < 0),
                indicateurF = 0;
            end
            k = k+1;
        end %si X est faisable indicateurF vaut 1, 0 sinon
        
        if (indicateurF == 1),
            
            %on crée Xtmp à partir de xb
            for (k = 1: n),
                Xtmp(indices(k)) = xb(k);
            end
            
            % Xtmp est donc à ce niveau BFS
        
            % on regarde si ce Xtmp est optimal
            ftmp = c'*Xtmp;
            if (ftmp < f),
                x = Xtmp;
                B = indices;
                f = ftmp;
            end
            Xtmp = zeros(m,1);
        end
        indicateurF = 1;
        
    end

end

return