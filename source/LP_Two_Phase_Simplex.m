function [f,x,B] = LP_Two_Phase_Simplex(A,b,c)
% question 1.3

[n1 m1] = size(A); % dimensions de A

% on crée la matrice augmentée
Ag = [A eye(n1)];

Y = [zeros(1, m1), ones(1,n1)];

Ag = [Ag b; Y 0];

[n,m] = size(Ag); % dimensions de la matrice augmentée

% Phase 1: on veut résoudre le problème artificiel pour trouver une base
% initiale pour appliquer la méthode Simplex au problème initial
% On va ainsi appliquer Simplex au problème artificiel
% (on n'utilise pas encore la fonction de la question précédente car on
% veut modifier la matrice initiale en appliquant Simplex, et la fonction
% précédente ne fait pas cela)

% on met à jour la matrice augmentée pour la transformer en
% tableau canonique
for (i = 1 : n1),
    Ag(end, :) = Ag(end, :) - Ag(i, :);
end

% les coefficients de coût réduit se trouvent au début de la dernière
% ligne
rd = Ag(end, :);
[rmin q] = min(rd(1:m1)); % q correspond à la colonne à rentrer

% variable pour retenir la position des colonnes de la base du problème
% artficiel
indicesB = [(m1+1):(m1+n1)]; 

% variable valant 1 si on sait que le problème est non-borné (on peut ainsi
% arrêter l'algorithme si c'est le cas), 0 sinon
nonborne = 0;
% (ce problème articficielle peut être non-borné)

while (rmin < (-1e-8)) && (nonborne == 0),
    
    % on vérifie que le problème n'est pas borné
    if(max(Ag(:,q)) <= 0),
        nonborne = 1;% si il est non-borné, on sortira de la boucle
    end
    
    if(nonborne == 0),
        
        % on calcule la ligne du pivot (slide 33 du cours)  
        val = Inf;
        for (i = 1: n1),
            if(Ag(i,q) > 0)  && ((Ag(i, end)/Ag(i,q)) < val),
                p=i;
                val = (Ag(i, end)/Ag(i,q));
            end
        end
        % p correspond à la colonne à sortir de la base
        
        pivot = Ag(p,q);
        
        % on pivote sur le (p,q)eme élément (slide 31 du cours)    
        for(i = 1 : n),
            for(j = 1 : m),
                if( i ~= p) && (j~=q),
                    Ag(i,j) = Ag(i,j) - (Ag(i,q)*Ag(p,j))./pivot;
                end
            end
        end
        for(i = 1: n),
            if(i ~=p),
                Ag(i,q) = 0;
            end
        end
        for(j = 1 :m),
            Ag(p,j) = Ag(p,j)./pivot;
        end
    end
    
    % on met à jour les indices des colonnes de la base du problème
    % artificiel
    for (k = 1: n1),
        if(indicesB(k) == p+m1),
            indicesB(k) = q;
        end
    end
    
    % on determine la prochaine colonne à rentrer 
    rd = Ag(end, :);
    [rmin q] = min(rd(1:m1));
        
end

if (nonborne == 0),
    % si on est sorti de la boucle car on a trouvé une solution optimale au
    % problème artificiel, on retire les colonnes correspondant aux
    % variables artificielles   

    btmp = Ag(1:n1, end);

    Atmp = Ag(1:n1, 1:m1);
    
    
    % On passe alors à la phase 2 : on applique Simplex avec les variables
    % restantes et on trouve le coût optimal f et la BFS x avec sa base

    [f,x,B]= LP_Simplex(Atmp, btmp, c, [1:n1]);
    
else
    
    % si le problème est non-borné, on retourne des valeurs spéciales pour 
    % que l'utilisateur du programme se rende compte qu'il y a un problème
    
    B = [];
    f = Inf;
    x = [];
    
    frpintf("\nLe problème est non-borné\n\n");

end


return