% We use the results of the Q4 from the TD to test the functions

A = [10 30 30 1 0 0; 1 1 1 0 1 0; 0 1 0 0 0 1];
b = [2500 120 30]';
c = [-474 -774 -645 0 0 0]';

fprintf("With LP_bourrin function we find the following solution:\n");
[f, x, B] = LP_bourrin(A, b, c)

fprintf("With the simplex function we find the following solution:\n");
[f, x, B] = LP_simplex(A, b, c, [1 2 3])

fprintf("With the two phase simplex function we find the following solution:\n");
[f, x, B] = LP_Two_Phase_Simplex(A, b, c)

% The results are the same, so the functions are working well for this test.
