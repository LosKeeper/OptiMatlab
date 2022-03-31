% Tests pour la partie 1


% Avec la Q4 du TD 

fprintf("\nPour la question Q4 du TD, on obtient les résultats suivants :\n");

A4 = [10 30 30 1 0 0; 1 1 1 0 1 0; 0 1 0 0 0 1];

b4 = [2500 120 30]';

c4 = [-474 -774 -645 0 0 0]';

fprintf("\nAvec la méthode bourrin :\n");
[f, x, B] = LP_bourrin(A4, b4, c4)

fprintf("\nAvec la méthode Simplex :\n");
[f, x, B] = LP_Simplex(A4, b4, c4, [1 2 3])

fprintf("\nAvec la méthode Two_Phase_Simplex :\n");
[f, x, B] = LP_Two_Phase_Simplex(A4, b4, c4)



% Avec la Q5 du TD

fprintf("\nPour la question Q5 du TD, on obtient les résultats suivants :\n");

A5 = [1 0 -1 0 0; 1 -1 0 -2 0; 2 0 0 1 1];

b5 = [3 1 7]';

c5 = [2 0 0 0 0]';

fprintf("\nAvec la méthode bourrin :\n");
[f, x, B] = LP_bourrin(A5, b5, c5)

%fprintf("\nAvec la méthode Simplex :\n");
%[f, x, B] = LP_Simplex(A5, b5, c5, [1 2 3])

%fprintf("\nAvec la méthode Two_Phase_Simplex :\n");
%[f, x, B] = LP_Two_Phase_Simplex(A5, b5, c5)



% Avec l'exemple de la slide 45 du cours

fprintf("\nPour l'exemple de la slide 45, on obtient les résultats suivants :\n");

A45 = [4 2 -1 0; 1 4 0 -1];

b45 = [12 6]';

c45 = [2 3 0 0]';

%fprintf("\nAvec la méthode bourrin :\n");
%[f, x, B] = LP_bourrin(A45, b45, c45)

fprintf("\nAvec la méthode Two_Phase_Simplex :\n");
[f, x, B] = LP_Two_Phase_Simplex(A45, b45, c45)
