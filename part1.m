A4 = [10 30 30 1 0 0; 1 1 1 0 1 0; 0 1 0 0 0 1];

b4 = [2500 120 30]';

c4 = [-474 -774 -645 0 0 0]';

fprintf("\nAvec la méthode bourrin :\n");
[f, x, B] = LP_bourrin(A4, b4, c4)

function [f, x, B] = LP_bourrin(A, b, c)

    % Check for errors in the arguments
    if ~ismatrix(A) || ~ismatrix(b) || ~ismatrix(c)
        error('Not matrix or vector');
    end

    [m, n] = size(A);

    if rank(A) < m
        error('A not full rank');
    end

    if length(b) ~= m || length(c) ~= n
        error('b and c dont have same dimensions as A');
    end

    % Initialisation of the variables
    x = []; % x is the solution
    B = []; % B is the basis
    f = Inf; % f is the minimal cost
    L = nchoosek(1:n, m); % L is the list of all the possible combinations of n elements

    for i = 1:nchoosek(n, m)
        % We choose the i-th combination of n elements
        % We create the matrix B
        B = A(:, L(i, :));
        % We create the vector b
        b = b(L(i, :));
        % We create the vector c
        c = c(L(i, :));
        % We create the vector x
        x = B \ b;
        % We create the cost function
        f = c' * x;
    end

end

   
