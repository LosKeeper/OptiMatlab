function [f,x,B] = LP_Simplex(A,b,c,v)
% question 1.2

[n m] = size(A); % dimensions de A
    
Btmp = A(:, v); % on crée la base

Ag = [A; c']; % on commence à créer la matrice augmentée

Bg = Ag(:, v); % correspond à B et cb' en dessous

% variable pour avoir les indices des colonnes de D (de même que v pour B)
oth = zeros(1,1); % initialisation

arajouter = 1;
for (i = 1 : m),
    % pour chaque colonne de A on regarde si c'est une colonne de la base
    for (j = 1: n),
        if(v(j) == i),
            arajouter = 0;
        end
    end
    % si la colonne n'est pas une colonne de la base, on la garde pour oth
    if (arajouter == 1),
        oth= horzcat(oth, [i]);
    end
    arajouter = 1;
end

% on enlève le 0 au début (qui n'était que là pour initialiser oth)
oth = oth(:, 2:m-n+1);


% pour avoir les colonnes correspondantes à D et cd'

Dg = Ag(:, oth); % correspond à D et cd' en dessous

bg = [b ; 0];

Ag = [Bg Dg bg]; % tableau du problème LP

% opérations pour avoir le tableau canonique (slide 40 du cours)
Ag = [inv(Btmp) zeros(n,1); zeros(1,n) 1]*Ag;
Ag = [eye(n) zeros(n,1); -transpose(c(1:n, :)) 1]*Ag;

% Ag correspond maintenant au tableau canonique

% on récupère les coeffients de coût réduit sur la dernière ligne et on
% regarde quel est le cûtp le plus petit et on garde son numéro de colonne
rd = Ag(end, :);
[rmin q] = min(rd(n+1:m));
q = q + n; % numéro de colonne du coefficient de coût réduit minimal
% q correspond à la colonne à rentrer dans la base

indicesB = v; % variable pour retenir la position des colonnes de la base

% variable valant 1 si on sait que le problème est non-borné (on peut ainsi
% arrêter l'algorithme si c'est le cas), 0 sinon
nonborne = 0;


while (rmin < (-1e-8)) && (nonborne == 0),
    % (on ne teste pas si rmin est strictement  excatement inférieur à 0,
    % car avec les calculs MATLAB, il pourrait y avoir des approximations
    % qui erroneraient le résultat)
    
    % on vérifie que le problème n'est pas borné
    if(max(Ag(:,q)) <= 0),
        nonborne = 1; % si il est non-borné, on sortira de la boucle
    end
    
    
    if(nonborne == 0),
        
        % on calcule la ligne du pivot (slide 33 du cours)     
        val = Inf;
        for (i = 1: n+1),
            if(Ag(i,q) > 0) && ((Ag(i, m+1)/Ag(i,q)) < val),
                p=i;
                val = (Ag(i, m+1)/Ag(i,q));
            end
        end
        % p correspond à la colonne à sortir de la base
        
        pivot = Ag(p,q);
        
        % on pivote sur le (p,q)eme élément (slide 31 du cours)   
        for(i = 1 : n+1),
            for(j = 1 : m+1),
                if( i ~= p) && (j~=q),
                    Ag(i,j) = Ag(i,j) - (Ag(i,q)*Ag(p,j))./pivot;
                end
            end
        end
        for(i = 1: n+1),
            if(i ~=p),
                Ag(i,q) = 0;
            end
        end
        for(j = 1 :m+1),
            Ag(p,j) = Ag(p,j)./pivot;
        end
    end
    
    % on met à jour les indices des colonnes de la base
    for (k = 1: n),
        if(indicesB(k) == p),
            indicesB(k) = q;
        end
    end
    
    % on determine la prochaine colonne à rentrer  
    rd = Ag(end, :);
    [rmin q] = min(rd(n+1:m));
    q = n+ q;
    
end


if (nonborne == 0),
    % si on est sorti de la boucle car on a trouvé une solution optimale :
    % on retourne le BFS optimal x, sa base B et le coût optimal f en 
    % regardant la dernière colonne de la matrice augmentée (pour x et f)
    
    B = indicesB;
    xb = Ag(1:n, end);
    Xtmp = zeros (m, 1);
    for (k = 1: n),
        Xtmp(indicesB(k)) = xb(k);
    end
    x = Xtmp;
    
    f = -Ag(end, end);
    
else
    % si le problème est non-borné, on retourne des valeurs spéciales pour 
    % que l'utilisateur du programme se rende compte qu'il y a un problème
    
    B = [];
    f = Inf;
    x = [];
    
    frpintf("\nLe problème est non-borné\n\n");
end


return