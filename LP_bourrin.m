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
    Xtmp = zeros(n, 1); % Xtmp is the temporary solution
    f = Inf; % f is the minimal cost
    L = nchoosek(1:n, m); % L is the list of all the possible combinations of n elements
    feasible = 1; % feasible is a boolean variable that is 1 if the problem is feasible and 0 otherwise

    for i = 1:nchoosek(n, m)
        % We choose the i-th combination of n elements

        index = L(i, :); % index is the list of the indexes of the elements of the i-th combination
        Btmp = A(:, index); % Btmp is the basis of the i-th combination

        xb = Btmp \ b; % xb is the solution of the i-th combination

        % We check if the i-th combination is feasible

        for k = 1:m

            if xb(k) < 0
                feasible = 0;
            end

        end

        if feasible

            % We construct Xtmp with xb
            for j = 1:m
                Xtmp(index(j)) = xb(j);
            end

            % If the i-th combination is feasible, we check if it is the minimal cost
            ftmp = c' * Xtmp;

            if ftmp < f
                f = ftmp;
                x = Xtmp;
                B = index;
            end

            Xtmp = zeros(n, 1);
        end

        feasible = 1;

    end

end
